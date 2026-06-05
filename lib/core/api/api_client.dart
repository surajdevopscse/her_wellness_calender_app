import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:her_wellness_calender/core/errors/exceptions.dart';

typedef TokenProvider = String? Function();

class ApiClient {
  static const _genericErrorMessage =
      'Something went wrong. Please try again.';
  static const _networkErrorMessage =
      'Unable to connect. Please check your internet connection and try again.';
  static const _responseParsingErrorMessage =
      'We could not read the server response. Please try again.';
  static const _requestFailedMessage =
      'Request failed. Please try again.';
  static const _serverErrorMessage =
      'The service is temporarily unavailable. Please try again later.';
  static const _validationErrorMessage =
      'Please review the highlighted details and try again.';
  static const _unauthorizedErrorMessage =
      'Please sign in again to continue.';
  static const _forbiddenErrorMessage =
      'You do not have permission to perform this action.';
  static const _notFoundErrorMessage =
      'The requested information could not be found.';

  ApiClient({
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.enableLogs,
    this.getToken,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final bool enableLogs;
  final TokenProvider? getToken;
  final http.Client _httpClient;

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _send(
      method: 'GET',
      path: path,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _send(method: 'POST', path: path, body: body, headers: headers);
  }

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _send(method: 'PUT', path: path, body: body, headers: headers);
  }

  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _send(method: 'PATCH', path: path, body: body, headers: headers);
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _send(method: 'DELETE', path: path, body: body, headers: headers);
  }

  Future<dynamic> _send({
    required String method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(
      queryParameters: queryParameters?.map(
        (key, value) => MapEntry(key, '$value'),
      ),
    );

    final resolvedHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    final token = getToken?.call();
    if (token != null && token.isNotEmpty) {
      resolvedHeaders['Authorization'] = 'Bearer $token';
    }

    http.Response response;
    try {
      switch (method) {
        case 'GET':
          response = await _httpClient
              .get(uri, headers: resolvedHeaders)
              .timeout(connectTimeout);
          break;
        case 'POST':
          response = await _httpClient
              .post(
                uri,
                headers: resolvedHeaders,
                body: jsonEncode(body ?? const <String, dynamic>{}),
              )
              .timeout(connectTimeout);
          break;
        case 'PUT':
          response = await _httpClient
              .put(
                uri,
                headers: resolvedHeaders,
                body: jsonEncode(body ?? const <String, dynamic>{}),
              )
              .timeout(connectTimeout);
          break;
        case 'PATCH':
          response = await _httpClient
              .patch(
                uri,
                headers: resolvedHeaders,
                body: jsonEncode(body ?? const <String, dynamic>{}),
              )
              .timeout(connectTimeout);
          break;
        case 'DELETE':
          response = await _httpClient
              .delete(
                uri,
                headers: resolvedHeaders,
                body: jsonEncode(body ?? const <String, dynamic>{}),
              )
              .timeout(connectTimeout);
          break;
        default:
          throw const UnknownAppException(message: _genericErrorMessage);
      }
    } on TimeoutException {
      throw const TimeoutAppException();
    } catch (error) {
      if (error is AppException) {
        throw error;
      }

      throw const NetworkAppException(message: _networkErrorMessage);
    }

    return _parseResponse(response);
  }

  dynamic _parseResponse(http.Response response) {
    final dynamic payload;
    try {
      payload = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body);
    } catch (_) {
      throw const ParsingAppException(
        message: _responseParsingErrorMessage,
      );
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return payload;
    }

    final message = payload is Map<String, dynamic>
        ? _sanitizeErrorMessage(_extractErrorMessage(payload))
        : _requestFailedMessage;

    switch (response.statusCode) {
      case 400:
      case 409:
        throw ValidationAppException(
          message: message.isEmpty ? _validationErrorMessage : message,
        );
      case 401:
        throw UnauthorizedAppException(
          message: message.isEmpty ? _unauthorizedErrorMessage : message,
        );
      case 403:
        throw ForbiddenAppException(
          message: message.isEmpty ? _forbiddenErrorMessage : message,
        );
      case 404:
        throw NotFoundAppException(
          message: message.isEmpty ? _notFoundErrorMessage : message,
        );
      case 422:
        throw ValidationAppException(
          message: message.isEmpty ? _validationErrorMessage : message,
        );
      default:
        throw ServerAppException(
          message: _serverErrorMessage,
          statusCode: response.statusCode,
        );
    }
  }

  String _extractErrorMessage(Map<String, dynamic> payload) {
    final errors = payload['errors'];
    if (errors is Map<String, dynamic>) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString();
        }
        if (value is String && value.isNotEmpty) return value;
      }
    }

    return payload['message'] as String? ??
        payload['error'] as String? ??
        _requestFailedMessage;
  }

  String _sanitizeErrorMessage(String message) {
    final trimmed = message.trim();
    if (trimmed.isEmpty) return '';

    final technicalTerms = [
      'exception',
      'stacktrace',
      'stack trace',
      'socketexception',
      'httpexception',
      'formatexception',
      'typeerror',
      'null check operator',
      'system.',
      'microsoft.',
      'dart:',
      'package:',
      ' at ',
      '\\',
    ];

    final lower = trimmed.toLowerCase();
    final looksTechnical = technicalTerms.any((term) => lower.contains(term));
    return looksTechnical ? '' : trimmed;
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:her_wellness_calender/core/errors/exceptions.dart';

typedef TokenProvider = String? Function();

class ApiClient {
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
          throw UnknownAppException(message: 'Unsupported method: $method');
      }
    } on TimeoutException {
      throw const TimeoutAppException();
    } catch (error) {
      throw NetworkAppException(message: error.toString());
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
        message: 'Unable to parse response payload',
      );
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return payload;
    }

    final message = payload is Map<String, dynamic>
        ? (payload['message'] as String? ??
              payload['error'] as String? ??
              'Request failed')
        : 'Request failed';

    switch (response.statusCode) {
      case 400:
      case 409:
        throw ValidationAppException(message: message);
      case 401:
        throw UnauthorizedAppException(message: message);
      case 403:
        throw ForbiddenAppException(message: message);
      case 404:
        throw NotFoundAppException(message: message);
      case 422:
        throw ValidationAppException(message: message);
      default:
        throw ServerAppException(
          message: message,
          statusCode: response.statusCode,
        );
    }
  }
}

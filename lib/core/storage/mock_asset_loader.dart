import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';

abstract class MockAssetLoader {
  Future<Map<String, dynamic>> loadMap(String path);
  Future<List<dynamic>> loadList(String path);
}

class DefaultMockAssetLoader implements MockAssetLoader {
  @override
  Future<Map<String, dynamic>> loadMap(String path) async {
    final decoded = await _decode(path);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw const ParsingAppException(
      message: 'Unable to load this data. Please try again.',
    );
  }

  @override
  Future<List<dynamic>> loadList(String path) async {
    final decoded = await _decode(path);
    if (decoded is List<dynamic>) {
      return decoded;
    }
    throw const ParsingAppException(
      message: 'Unable to load this data. Please try again.',
    );
  }

  Future<dynamic> _decode(String path) async {
    try {
      final raw = await rootBundle.loadString(path);
      return jsonDecode(raw);
    } catch (_) {
      throw const ParsingAppException(
        message: 'Unable to load this data. Please try again.',
      );
    }
  }
}

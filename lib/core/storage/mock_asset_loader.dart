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
    throw ParsingAppException(message: 'Expected a map at $path');
  }

  @override
  Future<List<dynamic>> loadList(String path) async {
    final decoded = await _decode(path);
    if (decoded is List<dynamic>) {
      return decoded;
    }
    throw ParsingAppException(message: 'Expected a list at $path');
  }

  Future<dynamic> _decode(String path) async {
    try {
      final raw = await rootBundle.loadString(path);
      return jsonDecode(raw);
    } catch (error) {
      throw ParsingAppException(
        message: 'Failed to load mock asset $path: $error',
      );
    }
  }
}

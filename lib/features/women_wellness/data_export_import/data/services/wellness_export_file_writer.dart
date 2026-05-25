import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/export_file_result.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/wellness_export_bundle.dart';

/// Writes export files to app documents directory.
class WellnessExportFileWriter {
  const WellnessExportFileWriter();

  Future<Directory> _exportDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/wellness_exports');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  String _timestamp() => DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

  Future<ExportFileResult> writeJson(WellnessExportBundle bundle) async {
    final dir = await _exportDir();
    final fileName = 'wellness_export_${_timestamp()}.json';
    final file = File('${dir.path}/$fileName');
    final encoder = const JsonEncoder.withIndent('  ');
    final bytes = utf8.encode(encoder.convert(bundle.toJson()));
    await file.writeAsBytes(bytes);
    return ExportFileResult(
      path: file.path,
      fileName: fileName,
      format: 'json',
      byteLength: bytes.length,
    );
  }

  Future<ExportFileResult> writeCsv(WellnessExportBundle bundle) async {
    final dir = await _exportDir();
    final fileName = 'wellness_export_${_timestamp()}.csv';
    final file = File('${dir.path}/$fileName');
    final buffer = StringBuffer()
      ..writeln('section,field,value')
      ..writeln('meta,exportedAt,${bundle.exportedAt.toIso8601String()}')
      ..writeln('meta,version,${bundle.version}');
    for (final period in bundle.periods) {
      buffer.writeln(
        'period,${period['id']},${period['startDate']}|${period['endDate'] ?? ''}',
      );
    }
    for (final log in bundle.dailyLogs) {
      buffer.writeln(
        'dailyLog,${log['id']},${log['logDate']}|${log['mood']}|${log['flow']}',
      );
    }
    final bytes = utf8.encode(buffer.toString());
    await file.writeAsBytes(bytes);
    return ExportFileResult(
      path: file.path,
      fileName: fileName,
      format: 'csv',
      byteLength: bytes.length,
    );
  }

  Future<WellnessExportBundle> readJson(String filePath) async {
    final content = await File(filePath).readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return WellnessExportBundle(
      exportedAt: DateTime.tryParse(json['exportedAt'] as String? ?? '') ??
          DateTime.now(),
      version: json['version'] as String? ?? '1.0',
      profile: json['profile'] as Map<String, dynamic>?,
      periods: (json['periods'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>(),
      dailyLogs: (json['dailyLogs'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>(),
      symptoms: json['symptoms'] as Map<String, dynamic>?,
      reports: json['reports'] as Map<String, dynamic>?,
      reminders: (json['reminders'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>(),
      privacy: json['privacy'] as Map<String, dynamic>?,
    );
  }
}

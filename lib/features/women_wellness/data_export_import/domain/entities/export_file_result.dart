/// Result of writing an export file to device storage.
class ExportFileResult {
  const ExportFileResult({
    required this.path,
    required this.fileName,
    required this.format,
    required this.byteLength,
  });

  final String path;
  final String fileName;
  final String format;
  final int byteLength;
}

sealed class AppException implements Exception {
  const AppException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class NetworkAppException extends AppException {
  const NetworkAppException({required super.message});
}

class TimeoutAppException extends AppException {
  const TimeoutAppException() : super(message: 'The request timed out');
}

class UnauthorizedAppException extends AppException {
  const UnauthorizedAppException({required super.message});
}

class ForbiddenAppException extends AppException {
  const ForbiddenAppException({required super.message});
}

class NotFoundAppException extends AppException {
  const NotFoundAppException({required super.message});
}

class ValidationAppException extends AppException {
  const ValidationAppException({required super.message});
}

class ServerAppException extends AppException {
  const ServerAppException({required super.message, super.statusCode});
}

class ParsingAppException extends AppException {
  const ParsingAppException({required super.message});
}

class UnknownAppException extends AppException {
  const UnknownAppException({required super.message});
}

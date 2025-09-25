class NetworkException implements Exception {
  const NetworkException({this.code, this.message});

  final String? code;
  final String? message;

  @override
  String toString() => message ?? '';
}

class NotFoundException implements Exception {
  const NotFoundException({this.code, this.message});

  final String? code;
  final String? message;

  @override
  String toString() => message ?? '';
}

class UnSupportedException implements Exception {
  const UnSupportedException({this.code, this.message});

  final String? code;
  final String? message;

  @override
  String toString() => message ?? '';
}

class LogicalException implements Exception {
  const LogicalException({this.code, this.message});

  final String? code;
  final String? message;

  @override
  String toString() => message ?? '';
}

class UnknownException implements Exception {
  const UnknownException({this.code, this.message});

  final String? code;
  final String? message;

  @override
  String toString() => message ?? '';
}

class ServiceException implements Exception {
  const ServiceException({this.code, this.message});

  final String? code;
  final String? message;

  @override
  String toString() => message ?? '';
}

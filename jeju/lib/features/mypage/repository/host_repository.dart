import '../../../core/core.dart';

class HostRepository with CommonRepository {
  static HostRepository get to => HostRepository();

  Future<Map<String, dynamic>> getData() async {
    try {
      var result = await get('$hostUrl/me', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> getCalculateData() async {
    try {
      var result = await get('$hostUrl/calculate', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw LogicalException(message: e.message);
    }
  }
}
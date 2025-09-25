import '../../../core/core.dart';

class AlertRepository with CommonRepository {
  static AlertRepository get to => AlertRepository();

  Future<Map<String,dynamic>> getSetting() async {
    try {
      var result = await get('$notificationUrl/setting', token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String,dynamic>> patchSetting(body) async {
    try {
      var result = await patch('$notificationUrl/setting', body: body, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return result.$2;
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }
}

import '../../../core/core.dart';

class EditInfoRepository with CommonRepository {
  static EditInfoRepository get to => EditInfoRepository();

  Future<Profile> getUserInfo() async {
    try {
      var result = await get(userMyInfoUrl, token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return Profile.fromJson(result.$2);
        default:
          throw result.$2;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sendEmail(String email) async {
    try {
      var result = await post(emailAuthUrl,body: {'email' : email}, token: TokenType.authToken);
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

  Future<Map<String, dynamic>> confirmEmail(String code) async {
    try {
      var result = await post('${emailAuthUrl}/confirm',body: {'code' : code}, token: TokenType.authToken);
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

  Future<void> authConfirm(impUid) async {
    try {
      var result = await post('$authUrl/certifications/confirm',body: {"impUid":"$impUid"},  token: TokenType.authToken);
      switch (result.$1) {
        case StatusCode.success:
          return;
        case StatusCode.notFound:
        case StatusCode.unAuthorized:
        case StatusCode.badRequest:
        case StatusCode.timeout:
        case StatusCode.error:
        case StatusCode.forbidden:
        case StatusCode.multiple:
          throw result.$2;
      }
    } on ExceptionModel catch (e) {
      throw ServiceException(message: e.message);
    }
  }
}

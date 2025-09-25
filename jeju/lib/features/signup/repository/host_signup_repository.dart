import '../../../core/core.dart';

class HostSignUpRepository with CommonRepository {
  static HostSignUpRepository get to => HostSignUpRepository();

  Future<void> signupHost() async {
    try {
      var result = await post(hostRegisterUrl, token: TokenType.authToken);
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

  Future<void> authHost(impUid) async {
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

  Future<void> secondSignupHost(Dto dto, file) async {
    try {
      logger.d(dto.toJson());
      var result = await patchWithFile(hostUpdateUrl,body: dto.toJson(), token: TokenType.authToken, files: file);
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

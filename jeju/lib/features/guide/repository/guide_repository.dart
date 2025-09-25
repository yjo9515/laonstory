import '../../../core/core.dart';

class GuideRepository with CommonRepository {
  static GuideRepository get to => GuideRepository();

  Future<void> registerHost() async {
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
}

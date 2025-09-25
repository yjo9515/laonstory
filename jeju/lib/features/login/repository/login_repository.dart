import 'dart:convert';

import '../../../core/core.dart';
import '../../../main.dart';

class LoginRepository with CommonRepository {
  static LoginRepository get to => LoginRepository();

  Future<bool> checkAuthWithEmail(String? email) async {
    var result = await get(checkAuthUrl, query: "email=$email");
    switch (result.$1) {
      case StatusCode.success:
        return true;
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.forbidden:
      case StatusCode.error:
      case StatusCode.multiple:
        return false;
    }
  }

  Future<Model<LoginInfo>> login(String? token, String? email, {String? userId, String? fcmToken, String? deviceId, required LoginMethod loginMethod}) async {
    var userModel = CreateUserModel(email: email, fcm: fcmToken, deviceId: deviceId, userId: userId, type: loginMethod.name.toUpperCase());
    var result = await get('$authUrl/${userModel.type}/callback',
        token: TokenType.customToken, query: 'email=${userModel.email}&fcm=${userModel.fcm}&userId=${userModel.userId}&deviceId=${userModel.deviceId}');
    switch (result.$1) {
      case StatusCode.success:
        var loginInfo = Model<LoginInfo>.fromJson(result.$2);
        return loginInfo;
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.forbidden:
      case StatusCode.error:
        throw ServiceException(message: result.$2);
      case StatusCode.multiple:
        throw ServiceException(message: result.$2);
    }
  }

  Future<bool> setUserToken(String? authToken, String? refreshToken) async {
    try {
      var secureString = await AppConfig.to.storage.read(key: 'secureInfo') ?? jsonEncode(SecureModel(tokenData: TokenData(), loginStatus: LoginStatus.logout).toJson());
      if (authToken != null && refreshToken != null) {
        var secureModel = SecureModel.fromJson(jsonDecode(secureString));
        secureModel.loginStatus = LoginStatus.login;
        secureModel.tokenData.authToken = authToken;
        secureModel.tokenData.refreshToken = refreshToken;
        await AppConfig.to.storage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw const LogicalException(message: 'setToken Error');
    }
  }
}

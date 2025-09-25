import 'dart:convert';

import '../../../core/core.dart';
import '../../../main.dart';

class GlobalRepository with CommonRepository {
  static GlobalRepository get to => GlobalRepository();

  Future<StatusCode> userCheckToken() async {
    var result = await post(checkTokenUrl, token: TokenType.authToken, loginRequest: false);
    switch (result.$1) {
      case StatusCode.success:
      case StatusCode.unAuthorized:
      case StatusCode.notFound:
        return result.$1;
      case StatusCode.badRequest:
      case StatusCode.forbidden:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.multiple:
        throw result.$1;
    }
  }

  Future<(StatusCode, dynamic)> refreshToken() async {
    var secureString = await AppConfig.to.storage.read(key: 'secureInfo');
    var secureModel = TokenData();
    if (secureString != null) {
      secureModel = SecureModel.fromJson(jsonDecode(secureString)).tokenData;
    } else {
      secureModel = TokenData(authToken: "", refreshToken: "");
    }
    var result = await get(refreshTokenUrl, query: 'refreshToken=${secureModel.refreshToken}&fcm=${secureModel.fcmToken}');
    switch (result.$1) {
      case StatusCode.success:
        return result;
      default:
        throw result.$1;
    }
  }

  Future<bool> setFcmToken(String? fcmToken) async {
    var result = await post('setFcmTokenUrl', token: TokenType.authToken, body: {'fcmToken': fcmToken});
    switch (result.$1) {
      case StatusCode.success:
        return true;
      case StatusCode.unAuthorized:
      case StatusCode.notFound:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.forbidden:
      case StatusCode.error:
      case StatusCode.multiple:
        throw result.$1;
    }
  }

  Future<Profile?> getUserInfo() async {
    var result = await get('', token: TokenType.authToken);
    switch (result.$1) {
      case StatusCode.success:
        return Model<Profile>.fromJson(result.$2).data;
      case StatusCode.forbidden:
        return Profile(name: '');
      case StatusCode.unAuthorized:
      case StatusCode.notFound:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.multiple:
        throw result.$1;
    }
  }

  Future<Profile?> getHostInfo() async {
    var result = await get(hostInfoUrl, token: TokenType.authToken);
    switch (result.$1) {
      case StatusCode.success:
        return Model<Profile>.fromJson(result.$2).data;
      case StatusCode.forbidden:
        return Profile(name: '');
      case StatusCode.unAuthorized:
      case StatusCode.notFound:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.multiple:
        throw result.$1;
    }
  }
}

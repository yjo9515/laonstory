import 'package:flutter/foundation.dart';

import '../../common/api/api_url.dart';
import '../../common/enum/enums.dart';
import '../../common/repository/common_repository.dart';
import '../model/profile_model.dart';

class GlobalRepository with CommonRepository  {

  static GlobalRepository get to => GlobalRepository();

  Future<StatusCode> checkDataToken() async {
    var result = await checkToken(checkTokenUrl);
    switch (result.$1) {
      case StatusCode.success:
      case StatusCode.unAuthorized:
      case StatusCode.notFound:
        return result.$1;
      case StatusCode.badRequest:
      case StatusCode.forbidden:
      case StatusCode.timeout:
      case StatusCode.error:
        throw result.$1;
    }
  }

  Future<(StatusCode, dynamic)> refreshToken() async {
    var result = await postRefreshToken(refreshTokenUrl);
    switch (result.$1) {
      case StatusCode.success:
        return result;
      case StatusCode.notFound:
        return result;
      case StatusCode.unAuthorized:
      case StatusCode.forbidden:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
        throw result.$1;
    }
  }

  Future<bool> setFcmToken(String? fcmToken) async {
    var result = await postWithTokenField(setFcmTokenUrl, {'fcmToken': kIsWeb ? 'webToken': fcmToken});
    switch (result.$1) {
      case StatusCode.success:
        return true;
      case StatusCode.unAuthorized:
      case StatusCode.notFound:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.forbidden:
      case StatusCode.error:
        throw result.$1;
    }
  }

  Future<ProfileModel> getUserInfo() async {
    var result = await getWithToken(getUserInfoUrl);
    switch (result.$1) {
      case StatusCode.success:
        return ProfileModel.fromJson(result.$2);
      case StatusCode.forbidden:
        return ProfileModel(statusCode: 403, data: Profile(role: 'ROLE_GUEST', name: ""));
      case StatusCode.unAuthorized:
      case StatusCode.notFound:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
        throw result.$1;
    }
  }
}

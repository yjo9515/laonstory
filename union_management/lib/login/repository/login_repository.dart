import 'package:union_management/common/model/secure_model.dart';

import '../../../common/api/api_url.dart';
import '../../../common/enum/enums.dart';
import '../../../common/repository/common_repository.dart';
import '../model/response_user_model.dart';

class LoginRepository with CommonRepository {
  static LoginRepository get to => LoginRepository();

  Future<ResponseUserModel> login(String id, String pw) async {
    var result = await postWithField(loginUrl, {'id': id, 'password': pw});
    switch (result.$1) {
      case StatusCode.success:
        var responseUserModel = ResponseUserModel.fromJson(result.$2);
        return responseUserModel;
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.forbidden:
        throw result.$2;
    }
  }

  Future<SecureModel> setUserToken(String? accessToken, String? refreshToken, bool? isGuest) async {
    try {
      return await setToken(accessToken, refreshToken, isGuest ?? false);
    } catch (e) {
      throw UnimplementedError('setToken Error');
    }
  }
}

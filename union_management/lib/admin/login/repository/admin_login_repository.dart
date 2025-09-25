
import '../../../common/api/api_url.dart';
import '../../../common/enum/enums.dart';
import '../../../common/repository/common_repository.dart';
import '../model/create_admin_model.dart';

class AdminLoginRepository with CommonRepository {
  static AdminLoginRepository get to => AdminLoginRepository();

  Future<void> emailAuth(String email) async {
    var result = await postField(emailAuthUrl, {"email": email});
    switch (result.$1) {
      case StatusCode.success:
        return;
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.forbidden:
        throw result.$1;
    }
  }

  Future<(bool, dynamic)> checkEmail(String email, String code) async {
    var result = await postField(checkEmailUrl, {"email": email, "code": code});
    switch (result.$1) {
      case StatusCode.success:
        return (true, result.$2);
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.forbidden:
        return (false, result.$2);
    }
  }


  Future<(bool, dynamic)> signUp(CreateAdminModel createAdminModel, List<int> bytes) async {
    var result = await postWithImage(signUpAdminUrl, createAdminModel.toJson(), bytes);
    switch (result.$1) {
      case StatusCode.success:
        return (true, result.$2);
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.forbidden:
        return (false, result.$2);
    }
  }

  Future<(bool, dynamic)> login(String id, dynamic password) async {
    var result = await postWithField(adminLoginUrl, {'id': id, 'password': password});
    switch (result.$1) {
      case StatusCode.success:
        return (true, result.$2);
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.forbidden:
        return (false, result.$2);
    }
  }
}

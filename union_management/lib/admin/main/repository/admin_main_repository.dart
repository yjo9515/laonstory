import '../../../common/api/api_url.dart';
import '../../../common/enum/enums.dart';
import '../../../common/repository/common_repository.dart';
import '../model/admin_info_model.dart';

class AdminMainRepository with CommonRepository {
  static AdminMainRepository get to => AdminMainRepository();

  Future<(bool, dynamic)> adminCheckToken() async {
    try {
      var result = await postWithToken(checkAdminTokenUrl);
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
    } catch (e) {
      return const (false, "");
    }
  }

  Future<AdminData?> getAdminInfo() async {
    var result = await getWithToken(adminInfoUrl);
    switch (result.$1) {
      case StatusCode.success:
        return AdminInfoModel.fromJson(result.$2).data;
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.forbidden:
        throw result;
    }
  }
}

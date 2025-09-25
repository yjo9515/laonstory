import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../model/alert_model.dart';

class AlertRepository with CommonRepository {
  static AlertRepository get to => AlertRepository();

  Future<AlertModel> getAlertList(int page) async {
    var result = await getWithTokenParameter(alertUrl, 'page=$page');
    switch (result.$1) {
      case StatusCode.success:
        return AlertModel.fromJson(result.$2);
      case StatusCode.notFound:
      case StatusCode.unAuthorized:
      case StatusCode.badRequest:
      case StatusCode.timeout:
      case StatusCode.error:
      case StatusCode.forbidden:
        throw result.$1;
    }
  }

  Future<void> showAlert(String id) async {
    var result = await getWithToken('$alertUrl/$id');
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
}

import 'package:union_management/home/model/dashboard_model.dart';

import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';

class HomeRepository with CommonRepository {
  static HomeRepository get to => HomeRepository();

  Future<DashboardModel> getDashboard() async {
    try {
      var result = await getWithToken(dashboardUrl);
      switch (result.$1) {
        case StatusCode.success:
          var dashboardModel = DashboardModel.fromJson(result.$2);
          return dashboardModel;
        case StatusCode.notFound:
        case StatusCode.unAuthorized:
        case StatusCode.badRequest:
        case StatusCode.timeout:
        case StatusCode.error:
        case StatusCode.forbidden:
          throw result.$2;
      }
    } on String {
      rethrow;
    }
  }
}

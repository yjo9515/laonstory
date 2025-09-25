import 'package:union_management/admin/dashboard/model/admin_dashboard_model.dart';

import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';

class AdminDashboardRepository with CommonRepository {
  static AdminDashboardRepository get to => AdminDashboardRepository();

  Future<AdminDashboardModel> getDashboard(int userYear, int pointYear) async {
    try {
      var result = await getWithTokenParameter(adminDashboardUrl, "user=$userYear&point=$pointYear");
      switch (result.$1) {
        case StatusCode.success:
          var adminDashboardModel = AdminDashboardModel.fromJson(result.$2);
          return adminDashboardModel;
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

  Future<bool> addSetting(Map<String, dynamic> field) async {
    try {
      var result = await postWithTokenField(adminSettingUrl, field);
      switch (result.$1) {
        case StatusCode.success:
          return true;
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

  Future<bool> editSetting(String? id, Map<String, dynamic> field) async {
    try {
      var result = await patchWithTokenField('$adminSettingUrl/$id', field);
      switch (result.$1) {
        case StatusCode.success:
          return true;
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

  Future<bool> deleteSetting(String? id) async {
    try {
      var result = await delete('$adminSettingUrl/$id');
      switch (result.$1) {
        case StatusCode.success:
          return true;
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

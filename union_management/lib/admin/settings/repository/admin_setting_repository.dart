import 'package:union_management/admin/settings/model/manager_model.dart';

import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../model/admin_setting_model.dart';

class AdminSettingRepository with CommonRepository {
  static AdminSettingRepository get to => AdminSettingRepository();

  Future<AdminSettingModel> getSettings(int page, String query) async {
    try {
      var result = await getWithTokenParameter(adminSettingUrl, "noticeType=NOTICE&page=$page&query=$query");
      switch (result.$1) {
        case StatusCode.success:
          var adminSettingModel = AdminSettingModel.fromJson(result.$2);
          return adminSettingModel;
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

  Future<ManagerListResponse> getManagers(int page, String query) async {
    try {
      var result = await getWithTokenParameter(adminMangerUrl, "page=$page&query=$query");
      switch (result.$1) {
        case StatusCode.success:
          var managerModel = ManagerListResponse.fromJson(result.$2);
          return managerModel;
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


  Future<void> addManager(Map<String, dynamic> data) async {
    try {
      var result = await postWithTokenField(adminMangerUrl, data);
      switch (result.$1) {
        case StatusCode.success:
          return;
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

  Future<void> editManager(String id, Map<String, dynamic> data) async {
    try {
      var result = await patchWithTokenField('$adminMangerUrl/$id', data);
      switch (result.$1) {
        case StatusCode.success:
          return;
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

  Future<void> deleteManager(String id) async {
    try {
      var result = await delete('$adminMangerUrl/$id');
      switch (result.$1) {
        case StatusCode.success:
          return;
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

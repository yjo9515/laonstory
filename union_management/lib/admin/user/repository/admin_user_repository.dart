import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../model/admin_user_model.dart';
import '../model/admin_user_upload_model.dart';
import '../model/user_data_model.dart';

class AdminUserRepository with CommonRepository {
  static AdminUserRepository get to => AdminUserRepository();

  Future<UserDataModel?> getUserChartData() async {
    try {
      var result = await getWithToken('$adminUserUrl/chart');
      switch (result.$1) {
        case StatusCode.success:
          var dataModel = UserDataModel.fromJson(result.$2);
          return dataModel;
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

  Future<bool> addUser(Map<String, dynamic> field) async {
    try {
      var result = await postWithTokenField('$adminUserUrl/add', field);
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

  Future<bool> editUser(String? id, Map<String, dynamic> field) async {
    try {
      var result = await patchWithTokenField('$adminUserUrl/$id', field);
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

  Future<bool> deleteUser(String? id) async {
    try {
      var result = await delete('$adminUserUrl/$id');
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

  Future<AdminUserModel> getUsers(int page, String query,
      {FilterType filter = FilterType.createdAt, OrderType order = OrderType.asc, PositionEnum position = PositionEnum.all, int birthDay = 0}) async {
    try {
      var result = await getWithTokenParameter(adminUserUrl, "page=$page&query=$query&filter=${filter.name}&order=${order.name}&position=${position.name}&birthDay=$birthDay");
      switch (result.$1) {
        case StatusCode.success:
          var adminUserModel = AdminUserModel.fromJson(result.$2);
          return adminUserModel;
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

  Future<AdminUserUploadModel> uploadFile(PlatformFile file) async {
    try {
      var bytes = await file.readStream?.first ?? [];
      var result = await postWithTokenFile(adminUserUrl, http.MultipartFile.fromBytes('file', bytes, filename: 'users.xlsx'));
      switch (result.$1) {
        case StatusCode.success:
          var resultModel = AdminUserUploadModel.fromJson(result.$2);
          return resultModel;
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

  Future<dynamic> getExcelData() async {
    try {
      var result = await excelDownload('$adminUserUrl/excel');
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

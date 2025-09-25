import 'package:union_management/admin/event/model/admin_event_request_model.dart';

import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../model/admin_event_model.dart';

class AdminEventRepository with CommonRepository {
  static AdminEventRepository get to => AdminEventRepository();

  Future<AdminEventModel> getEvents(int page, String query) async {
    try {
      var result = await getWithTokenParameter(adminEventUrl, "page=$page&query=$query");
      switch (result.$1) {
        case StatusCode.success:
          var adminEventModel = AdminEventModel.fromJson(result.$2);
          return adminEventModel;
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

  Future<bool> addEvent(Map<String, dynamic> field) async {
    try {
      var result = await postWithTokenField(adminEventUrl, field);
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

  Future<bool> editEvent(String? id, Map<String, dynamic> field) async {
    try {
      var result = await patchWithTokenField('$adminEventUrl/$id', field);
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

  Future<bool> deleteEvent(String? id) async {
    try {
      var result = await delete('$adminEventUrl/$id');
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

  Future<Users?> getRequest(String? id) async {
    try {
      var result = await getWithToken('$adminEventUrl/request/$id');
      switch (result.$1) {
        case StatusCode.success:
          return EventRequestModel.fromJson(result.$2).data;
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

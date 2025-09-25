import 'package:union_management/admin/event/model/admin_point_model.dart';

import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../../pay/model/admin_pay_model.dart';


class DetailRepository with CommonRepository {
  static DetailRepository get to => DetailRepository();

  Future<AdminPayModel> getPays(int page, String id, String query) async {
    try {
      var result = await getWithTokenParameter(adminPayDetailUrl, "page=$page&id=$id&query=$query");
      switch (result.$1) {
        case StatusCode.success:
          return AdminPayModel.fromJson(result.$2);
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

  Future<AdminPointModel> getPoints(int page, String id, String query) async {
    try {
      var result = await getWithTokenParameter(adminPointDetailUrl, "page=$page&id=$id&query=$query");
      switch (result.$1) {
        case StatusCode.success:
          return AdminPointModel.fromJson(result.$2);
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

  Future<bool> postPoints(String id, Map<String, dynamic> query) async {
    try {
      var result = await postWithTokenField("$adminPointUrl/$id", query);
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

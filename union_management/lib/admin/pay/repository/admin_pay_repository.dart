import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../../user/model/chart_data_model.dart';
import '../model/admin_pay_model.dart';

class AdminPayRepository with CommonRepository {
  static AdminPayRepository get to => AdminPayRepository();

  Future<AdminPayModel> getPays(int page, String query,
      {FilterType filter = FilterType.payTime,
      OrderType order = OrderType.asc}) async {
    try {
      var result = await getWithTokenParameter(adminPayUrl,
          "page=$page&query=$query&filter=${filter.name}&order=${order.name}");
      switch (result.$1) {
        case StatusCode.success:
          var adminEventModel = AdminPayModel.fromJson(result.$2);
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

  Future<bool> addPay(Map<String, dynamic> field) async {
    try {
      var result = await postWithTokenField('$adminPayUrl/add', field);
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

  Future<bool> editPay(String? id, Map<String, dynamic> field) async {
    try {
      var result = await patchWithTokenField('$adminPayUrl/$id', field);
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

  Future<bool> deletePay(String? id) async {
    try {
      var result = await delete('$adminPayUrl/$id');
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

  Future<ChartDataModel?> getPayChartData(int year) async {
    try {
      var result =
          await getWithTokenParameter('$adminPayUrl/chart', "year=$year");
      switch (result.$1) {
        case StatusCode.success:
          var dataModel = ChartDataModel.fromJson(result.$2);
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

  Future<bool> postPayData(String id, Map<String, dynamic> data) async {
    try {
      var result = await postWithTokenField('$adminPayUrl/$id', data);
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

  Future<bool> editPayData(String id, Map<String, dynamic> data) async {
    try {
      var result = await patchWithTokenField('$adminPayUrl/$id', data);
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

  Future<bool> editPoints(String id, Map<String, dynamic> data) async {
    try {
      var result = await patchWithTokenField('$adminPointUrl/$id', data);
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

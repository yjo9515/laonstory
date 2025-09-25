import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../../admin/settings/model/admin_setting_model.dart';

class NoticeRepository with CommonRepository {
  static NoticeRepository get to => NoticeRepository();

  Future<Data> getNotices(int page, String query) async {
    try {
      var result = await getWithTokenParameter(noticeUrl, "page=$page&query=$query");
      switch (result.$1) {
        case StatusCode.success:
          var noticeModel = AdminSettingModel.fromJson(result.$2).data;
          return noticeModel ?? Data(items: []);
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

  Future<Notice> detailNotice(String? id) async {
    try {
      var result = await getWithToken('$noticeUrl/$id');
      switch (result.$1) {
        case StatusCode.success:
          var noticeModel = NoticeDetailModel.fromJson(result.$2).data;
          return noticeModel ?? const Notice();
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

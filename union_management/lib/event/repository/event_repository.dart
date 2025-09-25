import '../../../../common/enum/enums.dart';
import '../../../common/api/api_url.dart';
import '../../../common/repository/common_repository.dart';
import '../../admin/event/model/admin_event_model.dart';

class EventRepository with CommonRepository {
  static EventRepository get to => EventRepository();

  Future<Data> getEvents(int page, String query) async {
    try {
      var result = await getWithTokenParameter(eventUrl, "page=$page&query=$query");
      switch (result.$1) {
        case StatusCode.success:
          var eventModel = AdminEventModel.fromJson(result.$2).data;
          return eventModel ?? Data(items: []);
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

  Future<EventDetail> detailEvent(String? id) async {
    try {
      var result = await getWithToken('$eventUrl/$id');
      switch (result.$1) {
        case StatusCode.success:
          var eventDetailModel = EventDetailModel.fromJson(result.$2).data;
          return eventDetailModel ?? const EventDetail(request: false);
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

  Future<bool> requestEvent(String? id) async {
    try {
      var result = await postWithToken('$eventUrl/$id');
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

  Future<bool> cancelRequestEvent(String? id) async {
    try {
      var result = await patchWithToken('$eventUrl/request/$id');
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

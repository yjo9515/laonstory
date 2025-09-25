import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';
import '../../../common/model/meta_model.dart';

part 'admin_event_model.g.dart';

@JsonSerializable()
class AdminEventModel extends BaseModel {
  Data? data;

  AdminEventModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminEventModel.fromJson(Map<String, dynamic> json) => _$AdminEventModelFromJson(json);
}

@JsonSerializable()
class EventDetailModel extends BaseModel {
  final EventDetail? data;

  EventDetailModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory EventDetailModel.fromJson(Map<String, dynamic> json) => _$EventDetailModelFromJson(json);
}

@JsonSerializable()
class EventDetail {
  final Event? event;
  final bool? request;

  const EventDetail({this.event, this.request});
  factory EventDetail.fromJson(Map<String, dynamic> json) => _$EventDetailFromJson(json);
}

@JsonSerializable()
class Data {
  List<Event>? items;
  Meta? meta;

  Data({this.items, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@CopyWith()
@JsonSerializable()
class Event {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? title;
  final String? eventTime;
  final String? content;
  final String? address;
  final int? point;
  final String? eventStatus;

  const Event({this.id, this.createdAt, this.updatedAt, this.content, this.title, this.eventTime, this.point, this.address, this.eventStatus});

  factory Event.fromJson(Map<String, dynamic> json) {
    var data = _$EventFromJson(json);
    final result = data.copyWith(content: data.content?.replaceAll('font-feature-settings: normal;', ''));
    return result;
  }
}

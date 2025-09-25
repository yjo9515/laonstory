import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';
import '../../admin/event/model/admin_event_model.dart';
import '../../admin/settings/model/admin_setting_model.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardModel extends BaseModel {
  Data? data;

  DashboardModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory DashboardModel.fromJson(Map<String, dynamic> json) => _$DashboardModelFromJson(json);
}

@JsonSerializable()
class Data {
  List<Notice>? notices;
  List<Event>? events;

  Data({this.notices, this.events});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:union_management/admin/pay/model/admin_pay_model.dart';

import '../../../common/model/base_model.dart';
import '../../event/model/admin_event_model.dart';
import '../../settings/model/admin_setting_model.dart';
import '../../user/model/chart_data_model.dart';

part 'admin_dashboard_model.g.dart';

@JsonSerializable()
class AdminDashboardModel extends BaseModel {
  Data? data;

  AdminDashboardModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) => _$AdminDashboardModelFromJson(json);
}

@JsonSerializable()
class Data {
  List<Notice>? notices;
  List<Event>? events;
  List<ChartData>? users;
  List<ChartData>? points;
  List<Pay>? pays;

  Data({this.notices, this.events, this.pays, this.users});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
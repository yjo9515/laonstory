import 'package:json_annotation/json_annotation.dart';

import '../../common/model/base_model.dart';
import '../../common/model/meta_model.dart';

part 'alert_model.g.dart';

@JsonSerializable()
class AlertModel extends BaseModel {
  Data? data;

  AlertModel({this.data, int? statusCode, String? message})
      : super(statusCode: statusCode, message: message);

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}

@JsonSerializable()
class Data {
  List<Alert>? items;
  Meta? meta;

  Data({this.items, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Alert {
  String? id;
  String? createdAt;
  String? type;
  String? title;
  String? message;
  String? linkId;
  bool? view;

  Alert(
      {this.id,
      this.createdAt,
      this.type,
      this.title,
      this.message,
      this.view,
      this.linkId});

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  Map<String, dynamic> toJson() => _$AlertToJson(this);
}

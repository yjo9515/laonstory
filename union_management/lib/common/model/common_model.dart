import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part '../generated/common_model.g.dart';

@JsonSerializable()
class DataModel extends BaseModel {
  final dynamic data;

  DataModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';

part '../generated/base_model.g.dart';

@JsonSerializable()
class BaseModel {
  final int? statusCode;
  final String? message;

  const BaseModel({this.statusCode, this.message});

  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);
}

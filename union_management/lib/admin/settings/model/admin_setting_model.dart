import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';
import '../../../common/model/meta_model.dart';

part 'admin_setting_model.g.dart';

@JsonSerializable()
class AdminSettingModel extends BaseModel {
  Data? data;
  Notice? notice;

  AdminSettingModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminSettingModel.fromJson(Map<String, dynamic> json) => _$AdminSettingModelFromJson(json);
}

@JsonSerializable()
class NoticeDetailModel extends BaseModel {
  Notice? data;

  NoticeDetailModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory NoticeDetailModel.fromJson(Map<String, dynamic> json) => _$NoticeDetailModelFromJson(json);
}


@JsonSerializable()
class Data {
  List<Notice>? items;
  Meta? meta;

  Data({this.items, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class Notice {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? title;
  final String? content;

  const Notice({this.id, this.createdAt, this.updatedAt, this.content, this.title});

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';
import '../../../common/model/meta_model.dart';
import '../../event/model/admin_event_model.dart';
import '../../settings/model/admin_setting_model.dart';
import '../../user/model/admin_user_model.dart';

part 'union_model.g.dart';

@JsonSerializable()
class UnionModel extends BaseModel {
  Data? data;

  UnionModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory UnionModel.fromJson(Map<String, dynamic> json) => _$UnionModelFromJson(json);
}

@JsonSerializable()
class UnionDetailModel extends BaseModel {
  Union? data;

  UnionDetailModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory UnionDetailModel.fromJson(Map<String, dynamic> json) => _$UnionDetailModelFromJson(json);
}

@JsonSerializable()
class Data {
  List<Union>? items;
  Meta? meta;

  Data({this.items, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}



@JsonSerializable()
class Union {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? address;
  final List<User>? users;
  final List<Event>? events;
  final List<Notice>? notices;

  const Union({this.id, this.createdAt, this.updatedAt, this.name, this.address, this.users, this.events, this.notices});

  factory Union.fromJson(Map<String, dynamic> json) => _$UnionFromJson(json);
}
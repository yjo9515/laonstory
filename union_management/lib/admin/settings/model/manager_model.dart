import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/meta_model.dart';
part 'manager_model.g.dart';

@JsonSerializable()
class ManagerListResponse {
  @JsonKey(name: "data")
  final Data? data;
  @JsonKey(name: "statusCode")
  final int? statusCode;
  @JsonKey(name: "message")
  final String? message;

  ManagerListResponse({
    this.data,
    this.statusCode,
    this.message,
  });

  factory ManagerListResponse.fromJson(Map<String, dynamic> json) => _$ManagerListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "managers")
  final List<Manager>? managers;
  @JsonKey(name: "meta")
  final Meta? meta;

  Data({
    this.managers,
    this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Manager {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "active")
  final String? active;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "loginId")
  final String? loginId;
  @JsonKey(name: "date")
  final dynamic date;
  @JsonKey(name: "union")
  final Union? union;

  Manager({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.active,
    this.role,
    this.loginId,
    this.date,
    this.union,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => _$ManagerFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerToJson(this);
}

@JsonSerializable()
class Union {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "address")
  final String? address;

  Union({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.address,
  });

  factory Union.fromJson(Map<String, dynamic> json) => _$UnionFromJson(json);

  Map<String, dynamic> toJson() => _$UnionToJson(this);
}

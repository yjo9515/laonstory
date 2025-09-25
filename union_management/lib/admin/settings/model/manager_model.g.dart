// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerListResponse _$ManagerListResponseFromJson(Map<String, dynamic> json) =>
    ManagerListResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ManagerListResponseToJson(
        ManagerListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'statusCode': instance.statusCode,
      'message': instance.message,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      managers: (json['managers'] as List<dynamic>?)
          ?.map((e) => Manager.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'managers': instance.managers,
      'meta': instance.meta,
    };

Manager _$ManagerFromJson(Map<String, dynamic> json) => Manager(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      name: json['name'] as String?,
      active: json['active'] as String?,
      role: json['role'] as String?,
      loginId: json['loginId'] as String?,
      date: json['date'],
      union: json['union'] == null
          ? null
          : Union.fromJson(json['union'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManagerToJson(Manager instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'active': instance.active,
      'role': instance.role,
      'loginId': instance.loginId,
      'date': instance.date,
      'union': instance.union,
    };

Union _$UnionFromJson(Map<String, dynamic> json) => Union(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      name: json['name'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UnionToJson(Union instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'name': instance.name,
      'address': instance.address,
    };

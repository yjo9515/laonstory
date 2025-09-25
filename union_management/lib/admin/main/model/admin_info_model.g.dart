// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminInfoModel _$AdminInfoModelFromJson(Map<String, dynamic> json) =>
    AdminInfoModel(
      data: json['data'] == null
          ? null
          : AdminData.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminInfoModelToJson(AdminInfoModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

AdminData _$AdminDataFromJson(Map<String, dynamic> json) => AdminData(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      registration: json['registration'] as String?,
      ceo: json['ceo'] as String?,
      date: json['date'] as String?,
      active: json['active'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$AdminDataToJson(AdminData instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'email': instance.email,
      'registration': instance.registration,
      'ceo': instance.ceo,
      'date': instance.date,
      'active': instance.active,
      'role': instance.role,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserUploadModel _$AdminUserUploadModelFromJson(
        Map<String, dynamic> json) =>
    AdminUserUploadModel(
      data: json['data'] == null
          ? null
          : StatusData.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminUserUploadModelToJson(
        AdminUserUploadModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

StatusData _$StatusDataFromJson(Map<String, dynamic> json) => StatusData(
      errorData:
          (json['errorData'] as List<dynamic>?)?.map((e) => e as int).toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$StatusDataToJson(StatusData instance) =>
    <String, dynamic>{
      'errorData': instance.errorData,
      'status': instance.status,
    };

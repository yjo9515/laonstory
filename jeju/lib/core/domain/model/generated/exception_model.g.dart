// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../exception_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExceptionModel _$ExceptionModelFromJson(Map<String, dynamic> json) =>
    ExceptionModel(
      json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
    );

Map<String, dynamic> _$ExceptionModelToJson(ExceptionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'errorCode': instance.errorCode,
    };

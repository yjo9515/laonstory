// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model/exception_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExceptionModel _$ExceptionModelFromJson(Map<String, dynamic> json) => ExceptionModel(
      json['success'] as bool?,
      json['statusCode'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$ExceptionModelToJson(ExceptionModel instance) => <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'message': instance.message,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../exception_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExceptionModel _$ExceptionModelFromJson(Map<String, dynamic> json) =>
    ExceptionModel(
      json['success'] as bool?,
      result: json['result'] as int?,
      resultMsg: json['resultMsg'] as String?,
      resultCode: json['resultCode'] as String?,
    );

Map<String, dynamic> _$ExceptionModelToJson(ExceptionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
      'resultMsg': instance.resultMsg,
      'resultCode': instance.resultCode,
    };

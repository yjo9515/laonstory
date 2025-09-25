// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) => BaseModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };

Model<T> _$ModelFromJson<T>(Map<String, dynamic> json) => Model<T>(
      data: Model._dataFromJson(json['data']),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelToJson<T>(Model<T> instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': Model._dataToJson(instance.data),
    };

ListModel<T> _$ListModelFromJson<T>(Map<String, dynamic> json) => ListModel<T>(
      data: json['data'] == null
          ? null
          : Items<T>.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ListModelToJson<T>(ListModel<T> instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

Items<T> _$ItemsFromJson<T>(Map<String, dynamic> json) => Items<T>(
      items: Items._listFromJson(json['items'] as List),
    );

Map<String, dynamic> _$ItemsToJson<T>(Items<T> instance) => <String, dynamic>{
      'items': Items._listToJson(instance.items),
    };

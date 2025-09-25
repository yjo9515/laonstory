// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) => Alert(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      view: json['view'] as bool?,
      linkId: json['linkId'] as int?,
    );

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'type': instance.type,
      'title': instance.title,
      'message': instance.message,
      'linkId': instance.linkId,
      'view': instance.view,
    };

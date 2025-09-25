// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      idx: (json['idx'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'idx': instance.idx,
      'title': instance.title,
      'content': instance.content,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'date': instance.date?.toIso8601String(),
    };

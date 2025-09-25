// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      idx: (json['idx'] as num?)?.toInt(),
      userIdx: (json['user_idx'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'idx': instance.idx,
      'user_idx': instance.userIdx,
      'title': instance.title,
      'content': instance.content,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'date': instance.date?.toIso8601String(),
    };

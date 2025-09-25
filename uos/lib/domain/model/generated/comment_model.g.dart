// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      idx: (json['idx'] as num?)?.toInt(),
      boardIdx: (json['board_idx'] as num?)?.toInt(),
      userIdx: (json['user_idx'] as num?)?.toInt(),
      name: json['name'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'idx': instance.idx,
      'board_idx': instance.boardIdx,
      'user_idx': instance.userIdx,
      'name': instance.name,
      'content': instance.content,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'date': instance.date?.toIso8601String(),
    };

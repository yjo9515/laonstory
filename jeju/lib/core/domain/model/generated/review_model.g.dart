// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int?,
      room: json['room'] == null
          ? null
          : Room.fromJson(json['room'] as Map<String, dynamic>),
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      totalScore: (json['totalScore'] as num?)?.toDouble(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      cleanScore: json['cleanScore'] as int?,
      explainScore: json['explainScore'] as int?,
      kindnessScore: json['kindnessScore'] as int?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'room': instance.room,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'totalScore': instance.totalScore,
      'cleanScore': instance.cleanScore,
      'explainScore': instance.explainScore,
      'kindnessScore': instance.kindnessScore,
      'user': instance.user,
    };

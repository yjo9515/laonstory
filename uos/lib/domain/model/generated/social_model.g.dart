part of '../social_model.dart';

Community _$CommunityFrommJson(Map<String, dynamic> json) => Community(
      idx: json['idx'] as int?,
      content: json['content'] as String?,
      sns: json['sns'] as List<dynamic>?,
    );

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'idx': instance.idx,
      'content': instance.content,
      'sns': instance.sns,
    };

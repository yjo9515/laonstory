// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
      page: json['page'] as int?,
      size: json['size'] as int?,
      totalCount: json['totalCount'] as int?,
      totalPages: json['totalPages'] as int?,
      isFirst: json['isFirst'] as bool?,
      isLast: json['isLast'] as bool?,
    );

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'isFirst': instance.isFirst,
      'isLast': instance.isLast,
    };

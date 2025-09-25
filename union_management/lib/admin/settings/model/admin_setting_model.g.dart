// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminSettingModel _$AdminSettingModelFromJson(Map<String, dynamic> json) =>
    AdminSettingModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    )..notice = json['notice'] == null
        ? null
        : Notice.fromJson(json['notice'] as Map<String, dynamic>);

Map<String, dynamic> _$AdminSettingModelToJson(AdminSettingModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
      'notice': instance.notice,
    };

NoticeDetailModel _$NoticeDetailModelFromJson(Map<String, dynamic> json) =>
    NoticeDetailModel(
      data: json['data'] == null
          ? null
          : Notice.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NoticeDetailModelToJson(NoticeDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Notice.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      content: json['content'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'title': instance.title,
      'content': instance.content,
    };

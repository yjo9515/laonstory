// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminPointModel _$AdminPointModelFromJson(Map<String, dynamic> json) =>
    AdminPointModel(
      data: json['data'] == null
          ? null
          : PointData.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminPointModelToJson(AdminPointModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

PointDetailModel _$PointDetailModelFromJson(Map<String, dynamic> json) =>
    PointDetailModel(
      data: json['data'] == null
          ? null
          : Point.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PointDetailModelToJson(PointDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

PointData _$PointDataFromJson(Map<String, dynamic> json) => PointData(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PointDataToJson(PointData instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Point _$PointFromJson(Map<String, dynamic> json) => Point(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      payTime: json['payTime'] as String?,
      sort: json['sort'] as String?,
      amount: json['amount'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      union: json['union'] == null
          ? null
          : Union.fromJson(json['union'] as Map<String, dynamic>),
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'payTime': instance.payTime,
      'sort': instance.sort,
      'memo': instance.memo,
      'amount': instance.amount,
      'user': instance.user,
      'union': instance.union,
    };

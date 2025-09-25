// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_pay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminPayModel _$AdminPayModelFromJson(Map<String, dynamic> json) =>
    AdminPayModel(
      data: json['data'] == null
          ? null
          : PayData.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminPayModelToJson(AdminPayModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

PayData _$PayDataFromJson(Map<String, dynamic> json) => PayData(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Pay.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayDataToJson(PayData instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Pay _$PayFromJson(Map<String, dynamic> json) => Pay(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      bankAccount: json['bankAccount'] as String?,
      sort: json['sort'] as String?,
      payTime: json['payTime'] as String?,
      account: json['account'] as int?,
      amount: json['amount'] as int?,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$PayToJson(Pay instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'payTime': instance.payTime,
      'bankAccount': instance.bankAccount,
      'account': instance.account,
      'amount': instance.amount,
      'sort': instance.sort,
      'memo': instance.memo,
      'user': instance.user,
    };

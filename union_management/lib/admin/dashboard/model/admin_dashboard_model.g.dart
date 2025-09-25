// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminDashboardModel _$AdminDashboardModelFromJson(Map<String, dynamic> json) =>
    AdminDashboardModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminDashboardModelToJson(
        AdminDashboardModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      notices: (json['notices'] as List<dynamic>?)
          ?.map((e) => Notice.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      pays: (json['pays'] as List<dynamic>?)
          ?.map((e) => Pay.fromJson(e as Map<String, dynamic>))
          .toList(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..points = (json['points'] as List<dynamic>?)
        ?.map((e) => ChartData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'notices': instance.notices,
      'events': instance.events,
      'users': instance.users,
      'points': instance.points,
      'pays': instance.pays,
    };

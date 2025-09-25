// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartData _$ChartDataFromJson(Map<String, dynamic> json) => ChartData(
      month: json['month'] as String?,
      increase: (json['increase'] as num?)?.toDouble(),
      accrue: (json['accrue'] as num?)?.toDouble(),
      number: json['number'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$ChartDataToJson(ChartData instance) => <String, dynamic>{
      'month': instance.month,
      'number': instance.number,
      'increase': instance.increase,
      'accrue': instance.accrue,
      'total': instance.total,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDataModel _$ChartDataModelFromJson(Map<String, dynamic> json) =>
    ChartDataModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ChartDataModelToJson(ChartDataModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ChartData _$ChartDataFromJson(Map<String, dynamic> json) => ChartData(
      month: json['month'] as String?,
      increase: (json['increase'] as num?)?.toDouble(),
      accrue: (json['accrue'] as num?)?.toDouble(),
      decrease: (json['decrease'] as num?)?.toDouble(),
      number: json['number'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$ChartDataToJson(ChartData instance) => <String, dynamic>{
      'month': instance.month,
      'number': instance.number,
      'increase': instance.increase,
      'decrease': instance.decrease,
      'accrue': instance.accrue,
      'total': instance.total,
    };

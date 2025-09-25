import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';

part 'chart_data_model.g.dart';

@JsonSerializable()
class ChartDataModel extends BaseModel {
  final List<ChartData>? data;

  const ChartDataModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory ChartDataModel.fromJson(Map<String, dynamic> json) => _$ChartDataModelFromJson(json);
}

@JsonSerializable()
class ChartData {
  String? month;
  int? number;
  double? increase;
  double? decrease;
  double? accrue;
  int? total;

  ChartData({this.month, this.increase, this.accrue, this.decrease, this.number, this.total});

  factory ChartData.fromJson(Map<String, dynamic> json) => _$ChartDataFromJson(json);
}

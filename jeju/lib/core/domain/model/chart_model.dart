import 'package:json_annotation/json_annotation.dart';

part 'generated/chart_model.g.dart';

@JsonSerializable()
class ChartData {
  String? month;
  int? number;
  double? increase;
  double? accrue;
  int? total;

  ChartData({this.month, this.increase, this.accrue, this.number, this.total});

  factory ChartData.fromJson(Map<String, dynamic> json) => _$ChartDataFromJson(json);
}

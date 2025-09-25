import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';
import '../../../common/model/meta_model.dart';
import '../../etc/model/union_model.dart';
import '../../user/model/admin_user_model.dart';

part 'admin_point_model.g.dart';

@JsonSerializable()
class AdminPointModel extends BaseModel {
  PointData? data;

  AdminPointModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminPointModel.fromJson(Map<String, dynamic> json) => _$AdminPointModelFromJson(json);
}

@JsonSerializable()
class PointDetailModel extends BaseModel {
  Point? data;

  PointDetailModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory PointDetailModel.fromJson(Map<String, dynamic> json) => _$PointDetailModelFromJson(json);
}

@JsonSerializable()
class PointData {
  List<Point>? items;
  Meta? meta;

  PointData({this.items, this.meta});

  factory PointData.fromJson(Map<String, dynamic> json) => _$PointDataFromJson(json);
}



@JsonSerializable()
class Point {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? payTime;
  final String? sort;
  final String? memo;
  final int? amount;
  final User? user;
  final Union? union;

  const Point({this.id, this.createdAt, this.updatedAt, this.payTime, this.sort, this.amount, this.user, this.union, this.memo});

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
}
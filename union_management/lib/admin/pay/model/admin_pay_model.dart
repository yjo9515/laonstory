import 'package:json_annotation/json_annotation.dart';

import '../../../common/model/base_model.dart';
import '../../../common/model/meta_model.dart';
import '../../user/model/admin_user_model.dart';

part 'admin_pay_model.g.dart';

@JsonSerializable()
class AdminPayModel extends BaseModel {
  PayData? data;

  AdminPayModel({this.data, int? statusCode, String? message}) : super(statusCode: statusCode, message: message);

  factory AdminPayModel.fromJson(Map<String, dynamic> json) => _$AdminPayModelFromJson(json);
}

@JsonSerializable()
class PayData {
  List<Pay>? items;
  Meta? meta;

  PayData({this.items, this.meta});

  factory PayData.fromJson(Map<String, dynamic> json) => _$PayDataFromJson(json);
}

@JsonSerializable()
class Pay {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? payTime;
  String? bankAccount;
  int? account;
  int? amount;
  String? sort;
  String? memo;
  User? user;

  Pay({this.id, this.createdAt, this.updatedAt, this.user, this.bankAccount, this.sort, this.payTime, this.account, this.amount, this.memo});

  factory Pay.fromJson(Map<String, dynamic> json) => _$PayFromJson(json);
}
import 'package:union_management/admin/user/model/admin_user_model.dart';

import '../../../common/model/meta_model.dart';

class EventRequestModel {
  Users? data;
  int? statusCode;
  String? message;

  EventRequestModel({this.data, this.statusCode, this.message});

  EventRequestModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Users.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}

class Users {
  List<User>? items;
  Meta? meta;

  Users({this.items, this.meta});

  Users.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <User>[];
      json['items'].forEach((v) {
        items!.add(User.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

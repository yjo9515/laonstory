import 'package:json_annotation/json_annotation.dart';

part 'generated/alert_model.g.dart';

@JsonSerializable()
class Alert {
  String? id;
  String? createdAt;
  String? type;
  String? title;
  String? message;
  int? linkId;
  bool? view;

  Alert({this.id, this.createdAt, this.type, this.title, this.message, this.view, this.linkId});

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  Map<String, dynamic> toJson() => _$AlertToJson(this);
}

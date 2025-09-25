import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'generated/notice_model.g.dart';

@JsonSerializable()
class Notice {
  @JsonKey(name: "idx")
  final int? idx;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "date")
  final DateTime? date;

  Notice({
    this.idx,
    this.title,
    this.content,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}

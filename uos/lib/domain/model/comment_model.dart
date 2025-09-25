// To parse this JSON data, do
//
//     final comment = commentFromMap(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'generated/comment_model.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(name: "idx")
  final int? idx;
  @JsonKey(name: "board_idx")
  final int? boardIdx;
  @JsonKey(name: "user_idx")
  final int? userIdx;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "date")
  final DateTime? date;

  Comment({
    this.idx,
    this.boardIdx,
    this.userIdx,
    this.name,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

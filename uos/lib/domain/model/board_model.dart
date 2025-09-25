// To parse this JSON data, do
//
//     final board = boardFromMap(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'generated/board_model.g.dart';

@JsonSerializable()
class Board {
  @JsonKey(name: "idx")
  final int? idx;
  @JsonKey(name: "user_idx")
  final int? userIdx;
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

  Board({
    this.idx,
    this.userIdx,
    this.title,
    this.content,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);
}

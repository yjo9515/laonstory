import 'package:json_annotation/json_annotation.dart';

import 'room_model.dart';
import 'user_model.dart';

part 'generated/review_model.g.dart';

@JsonSerializable()
class Review {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "room")
  final Room? room;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "totalScore")
  final double? totalScore;
  @JsonKey(name: "cleanScore")
  final int? cleanScore;
  @JsonKey(name: "explainScore")
  final int? explainScore;
  @JsonKey(name: "kindnessScore")
  final int? kindnessScore;
  @JsonKey(name: "user")
  final User? user;

  Review({
    this.id,
    this.room,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.totalScore,
    this.user,
    this.cleanScore,
    this.explainScore,
    this.kindnessScore,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

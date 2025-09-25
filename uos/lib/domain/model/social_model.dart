import 'package:json_annotation/json_annotation.dart';

part 'generated/social_model.g.dart';

@JsonSerializable()
class Community {
  @JsonKey(name: 'idx')
  final int? idx;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'sns')
  final List<dynamic>? sns;

  Community({
    this.idx,
    this.content,
    this.sns,
  });

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFrommJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);
}

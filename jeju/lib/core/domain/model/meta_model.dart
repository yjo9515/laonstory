import 'package:json_annotation/json_annotation.dart';

part 'generated/meta_model.g.dart';

@JsonSerializable()
class PageInfo {
  int? page;
  int? size;
  int? totalCount;
  int? totalPages;
  bool? isFirst;
  bool? isLast;

  PageInfo({this.page, this.size, this.totalCount, this.totalPages, this.isFirst, this.isLast});

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);
}

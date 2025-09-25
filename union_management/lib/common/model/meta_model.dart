import 'package:json_annotation/json_annotation.dart';

part '../generated/meta_model.g.dart';

@JsonSerializable()
class Meta {
  int? totalItems;
  int? itemCount;
  int? itemsPerPage;
  int? totalPages;
  int? currentPage;

  Meta({this.totalItems, this.itemCount, this.itemsPerPage, this.totalPages, this.currentPage});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);

}

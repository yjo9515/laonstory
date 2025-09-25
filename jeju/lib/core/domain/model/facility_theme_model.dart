import 'package:json_annotation/json_annotation.dart';

import 'room_model.dart';

part 'generated/facility_theme_model.g.dart';

@JsonSerializable()
class FacilityThemeData {
  @JsonKey(name: "kind")
  final List<Kind>? kind;

  FacilityThemeData({this.kind});

  FacilityThemeData copyWith({List<Kind>? kind}) => FacilityThemeData(kind: kind ?? this.kind);

  factory FacilityThemeData.fromJson(Map<String, dynamic> json) => _$FacilityThemeDataFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityThemeDataToJson(this);
}

@JsonSerializable()
class Kind {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "type")
  final List<Type>? type;

  Kind({this.name, this.type});

  Kind copyWith({String? name, List<Type>? type}) => Kind(name: name ?? this.name, type: type ?? this.type);

  factory Kind.fromJson(Map<String, dynamic> json) => _$KindFromJson(json);

  Map<String, dynamic> toJson() => _$KindToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "facilityThemeList")
  final List<Facility>? facilityThemeList;
  @JsonKey(name: "name")
  final String? name;

  Type({this.facilityThemeList, this.name});

  Type copyWith({List<Facility>? facilityThemeList, String? name}) => Type(facilityThemeList: facilityThemeList ?? this.facilityThemeList, name: name ?? this.name);

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

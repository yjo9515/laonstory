// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../facility_theme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityThemeData _$FacilityThemeDataFromJson(Map<String, dynamic> json) =>
    FacilityThemeData(
      kind: (json['kind'] as List<dynamic>?)
          ?.map((e) => Kind.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FacilityThemeDataToJson(FacilityThemeData instance) =>
    <String, dynamic>{
      'kind': instance.kind,
    };

Kind _$KindFromJson(Map<String, dynamic> json) => Kind(
      name: json['name'] as String?,
      type: (json['type'] as List<dynamic>?)
          ?.map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KindToJson(Kind instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      facilityThemeList: (json['facilityThemeList'] as List<dynamic>?)
          ?.map((e) => Facility.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'facilityThemeList': instance.facilityThemeList,
      'name': instance.name,
    };

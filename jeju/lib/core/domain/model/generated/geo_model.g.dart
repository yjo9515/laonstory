// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../geo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) => GeoLocation(
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeoLocationToJson(GeoLocation instance) =>
    <String, dynamic>{
      'documents': instance.documents,
    };

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      address: json['address'] == null
          ? null
          : KaKaoAddress.fromJson(json['address'] as Map<String, dynamic>),
      addressName: json['address_name'] as String?,
      addressType: json['address_type'] as String?,
      roadAddress: json['road_address'] == null
          ? null
          : RoadAddress.fromJson(json['road_address'] as Map<String, dynamic>),
      x: json['x'] as String?,
      y: json['y'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'address': instance.address,
      'address_name': instance.addressName,
      'address_type': instance.addressType,
      'road_address': instance.roadAddress,
      'x': instance.x,
      'y': instance.y,
    };

KaKaoAddress _$KaKaoAddressFromJson(Map<String, dynamic> json) => KaKaoAddress(
      addressName: json['address_name'] as String?,
      bCode: json['b_code'] as String?,
      hCode: json['h_code'] as String?,
      mainAddressNo: json['main_address_no'] as String?,
      mountainYn: json['mountain_yn'] as String?,
      region1DepthName: json['region_1depth_name'] as String?,
      region2DepthName: json['region_2depth_name'] as String?,
      region3DepthHName: json['region_3depth_h_name'] as String?,
      region3DepthName: json['region_3depth_name'] as String?,
      subAddressNo: json['sub_address_no'] as String?,
      x: json['x'] as String?,
      y: json['y'] as String?,
    );

Map<String, dynamic> _$KaKaoAddressToJson(KaKaoAddress instance) =>
    <String, dynamic>{
      'address_name': instance.addressName,
      'b_code': instance.bCode,
      'h_code': instance.hCode,
      'main_address_no': instance.mainAddressNo,
      'mountain_yn': instance.mountainYn,
      'region_1depth_name': instance.region1DepthName,
      'region_2depth_name': instance.region2DepthName,
      'region_3depth_h_name': instance.region3DepthHName,
      'region_3depth_name': instance.region3DepthName,
      'sub_address_no': instance.subAddressNo,
      'x': instance.x,
      'y': instance.y,
    };

RoadAddress _$RoadAddressFromJson(Map<String, dynamic> json) => RoadAddress(
      addressName: json['address_name'] as String?,
      buildingName: json['building_name'] as String?,
      mainBuildingNo: json['main_building_no'] as String?,
      region1DepthName: json['region_1depth_name'] as String?,
      region2DepthName: json['region_2depth_name'] as String?,
      region3DepthName: json['region_3depth_name'] as String?,
      roadName: json['road_name'] as String?,
      subBuildingNo: json['sub_building_no'] as String?,
      undergroundYn: json['underground_yn'] as String?,
      x: json['x'] as String?,
      y: json['y'] as String?,
      zoneNo: json['zone_no'] as String?,
    );

Map<String, dynamic> _$RoadAddressToJson(RoadAddress instance) =>
    <String, dynamic>{
      'address_name': instance.addressName,
      'building_name': instance.buildingName,
      'main_building_no': instance.mainBuildingNo,
      'region_1depth_name': instance.region1DepthName,
      'region_2depth_name': instance.region2DepthName,
      'region_3depth_name': instance.region3DepthName,
      'road_name': instance.roadName,
      'sub_building_no': instance.subBuildingNo,
      'underground_yn': instance.undergroundYn,
      'x': instance.x,
      'y': instance.y,
      'zone_no': instance.zoneNo,
    };

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

import 'review_model.dart';

part 'generated/room_model.g.dart';

@CopyWith()
@JsonSerializable()
class Room {
  @JsonKey(name: "createAt")
  final DateTime? createAt;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "standardPeople")
  final int? standardPeople;
  @JsonKey(name: "maximumPeople")
  final int? maximumPeople;
  @JsonKey(name: "isAdditionalPeople")
  final bool? isAdditionalPeople;
  @JsonKey(name: "additionalPeopleCost")
  final int? additionalPeopleCost;
  @JsonKey(name: "roomCount")
  final int? roomCount;
  @JsonKey(name: "floor")
  final int? floor;
  @JsonKey(name: "bathroomCount")
  final int? bathroomCount;
  @JsonKey(name: "squareFeet")
  final int? squareFeet;
  @JsonKey(name: "isPossiblePet")
  final bool? isPossiblePet;
  @JsonKey(name: "singleBed")
  final int? singleBed;
  @JsonKey(name: "superSingleBed")
  final int? superSingleBed;
  @JsonKey(name: "doubleBed")
  final int? doubleBed;
  @JsonKey(name: "queenBed")
  final int? queenBed;
  @JsonKey(name: "kingBed")
  final int? kingBed;
  @JsonKey(name: "checkIn")
  final DateTime? checkIn;
  @JsonKey(name: "checkOut")
  final DateTime? checkOut;
  @JsonKey(name: "minCheckDay")
  final int? minCheckDay;
  @JsonKey(name: "maxCheckDay")
  final int? maxCheckDay;
  @JsonKey(name: "oneDayAmount")
  final int? oneDayAmount;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "days")
  final int? days;
  @JsonKey(name: "disCountPercent")
  final double? disCountPercent;
  @JsonKey(name: "refundRuleTen")
  final int? refundRuleTen;
  @JsonKey(name: "refundRuleSeven")
  final int? refundRuleSeven;
  @JsonKey(name: "refundRuleFive")
  final int? refundRuleFive;
  @JsonKey(name: "refundRuleThree")
  final int? refundRuleThree;
  @JsonKey(name: "refundRuleOne")
  final int? refundRuleOne;
  @JsonKey(name: "possessionClassification")
  final String? possessionClassification;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "address")
  final Address? address;
  @JsonKey(name: "facility")
  final List<Facility> facility;
  @JsonKey(name: "theme")
  final List<Facility> theme;
  @JsonKey(name: "facilityTheme")
  final List<Facility> facilityTheme;
  @JsonKey(name: "imageList")
  final List<Resource> imageList;
  // @JsonKey(name: "imageList")
  // final List<XFile>? imageList;
  @JsonKey(name: "reviewList")
  final List<Review>? reviewList;
  @JsonKey(name: "score")
  final double? score;
  @JsonKey(name: "reviewCount")
  final int? reviewCount;
  @JsonKey(name: "resource")
  final Resource? resource;
  @JsonKey(name: "updateType")
  final String? updateType;
  @JsonKey(name: "rejectReason")
  final String? rejectReason;
  @JsonKey(name: "deleteImageIdList")
  final List<int>? deleteImageIdList;

  const Room({
    this.createAt,
    this.id,
    this.name = '',
    this.possessionClassification,
    this.description = '',
    this.standardPeople = 1,
    this.maximumPeople = 1,
    this.isAdditionalPeople = false,
    this.additionalPeopleCost = 0,
    this.roomCount = 1,
    this.floor = 1,
    this.bathroomCount = 1,
    this.squareFeet = 0,
    this.isPossiblePet = false,
    this.singleBed = 0,
    this.superSingleBed = 0,
    this.doubleBed = 0,
    this.queenBed = 0,
    this.kingBed = 0,
    this.checkIn,
    this.checkOut,
    this.disCountPercent = 0,
    this.minCheckDay = 2,
    this.maxCheckDay = 2,
    this.oneDayAmount = 0,
    this.refundRuleTen = 100,
    this.refundRuleSeven = 70,
    this.refundRuleFive = 50,
    this.refundRuleThree = 30,
    this.refundRuleOne = 0,
    this.status,
    this.address,
    this.facility = const [],
    this.facilityTheme = const [],
    this.theme = const [],
    this.imageList = const [],
    this.reviewList,
    this.score,
    this.reviewCount,
    this.amount,
    this.days,
    this.resource,
    this.updateType,
    this.rejectReason,
    this.deleteImageIdList
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}


@JsonSerializable()
class Address {
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "addressDetail")
  final String? addressDetail;
  @JsonKey(name: "location")
  final Location? location;

  Address({
    this.code,
    this.address,
    this.addressDetail,
    this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Facility {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "facilityThemeId")
  int? facilityThemeId;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "etcFacility")
  final String? etcFacility;

  bool select;

  Facility({
    this.id,
    this.facilityThemeId,
    this.type,
    this.name,
    this.select = false,
    this.etcFacility,
  });

  bool contain(Facility other) {
    return name == other.name;
  }

  factory Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityToJson(this);
}

@JsonSerializable()
class Resource {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "originalFileName")
  final String? originalFileName;
  @JsonKey(name: "path")
  final String? path;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "type")
  final String? type;

  Resource({
    this.id,
    this.originalFileName,
    this.path,
    this.size,
    this.type,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}

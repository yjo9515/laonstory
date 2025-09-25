// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../room_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RoomCWProxy {
  Room createAt(DateTime? createAt);

  Room id(int? id);

  Room name(String? name);

  Room possessionClassification(String? possessionClassification);

  Room description(String? description);

  Room standardPeople(int? standardPeople);

  Room maximumPeople(int? maximumPeople);

  Room isAdditionalPeople(bool? isAdditionalPeople);

  Room additionalPeopleCost(int? additionalPeopleCost);

  Room roomCount(int? roomCount);

  Room floor(int? floor);

  Room bathroomCount(int? bathroomCount);

  Room squareFeet(int? squareFeet);

  Room isPossiblePet(bool? isPossiblePet);

  Room singleBed(int? singleBed);

  Room superSingleBed(int? superSingleBed);

  Room doubleBed(int? doubleBed);

  Room queenBed(int? queenBed);

  Room kingBed(int? kingBed);

  Room checkIn(DateTime? checkIn);

  Room checkOut(DateTime? checkOut);

  Room disCountPercent(double? disCountPercent);

  Room minCheckDay(int? minCheckDay);

  Room maxCheckDay(int? maxCheckDay);

  Room oneDayAmount(int? oneDayAmount);

  Room refundRuleTen(int? refundRuleTen);

  Room refundRuleSeven(int? refundRuleSeven);

  Room refundRuleFive(int? refundRuleFive);

  Room refundRuleThree(int? refundRuleThree);

  Room refundRuleOne(int? refundRuleOne);

  Room status(String? status);

  Room address(Address? address);

  Room facility(List<Facility> facility);

  Room facilityTheme(List<Facility> facilityTheme);

  Room theme(List<Facility> theme);

  Room imageList(List<Resource> imageList);

  Room reviewList(List<Review>? reviewList);

  Room score(double? score);

  Room reviewCount(int? reviewCount);

  Room amount(int? amount);

  Room days(int? days);

  Room resource(Resource? resource);

  Room updateType(String? updateType);

  Room rejectReason(String? rejectReason);

  Room deleteImageIdList(List<int>? deleteImageIdList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Room(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Room(...).copyWith(id: 12, name: "My name")
  /// ````
  Room call({
    DateTime? createAt,
    int? id,
    String? name,
    String? possessionClassification,
    String? description,
    int? standardPeople,
    int? maximumPeople,
    bool? isAdditionalPeople,
    int? additionalPeopleCost,
    int? roomCount,
    int? floor,
    int? bathroomCount,
    int? squareFeet,
    bool? isPossiblePet,
    int? singleBed,
    int? superSingleBed,
    int? doubleBed,
    int? queenBed,
    int? kingBed,
    DateTime? checkIn,
    DateTime? checkOut,
    double? disCountPercent,
    int? minCheckDay,
    int? maxCheckDay,
    int? oneDayAmount,
    int? refundRuleTen,
    int? refundRuleSeven,
    int? refundRuleFive,
    int? refundRuleThree,
    int? refundRuleOne,
    String? status,
    Address? address,
    List<Facility>? facility,
    List<Facility>? facilityTheme,
    List<Facility>? theme,
    List<Resource>? imageList,
    List<Review>? reviewList,
    double? score,
    int? reviewCount,
    int? amount,
    int? days,
    Resource? resource,
    String? updateType,
    String? rejectReason,
    List<int>? deleteImageIdList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRoom.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRoom.copyWith.fieldName(...)`
class _$RoomCWProxyImpl implements _$RoomCWProxy {
  const _$RoomCWProxyImpl(this._value);

  final Room _value;

  @override
  Room createAt(DateTime? createAt) => this(createAt: createAt);

  @override
  Room id(int? id) => this(id: id);

  @override
  Room name(String? name) => this(name: name);

  @override
  Room possessionClassification(String? possessionClassification) =>
      this(possessionClassification: possessionClassification);

  @override
  Room description(String? description) => this(description: description);

  @override
  Room standardPeople(int? standardPeople) =>
      this(standardPeople: standardPeople);

  @override
  Room maximumPeople(int? maximumPeople) => this(maximumPeople: maximumPeople);

  @override
  Room isAdditionalPeople(bool? isAdditionalPeople) =>
      this(isAdditionalPeople: isAdditionalPeople);

  @override
  Room additionalPeopleCost(int? additionalPeopleCost) =>
      this(additionalPeopleCost: additionalPeopleCost);

  @override
  Room roomCount(int? roomCount) => this(roomCount: roomCount);

  @override
  Room floor(int? floor) => this(floor: floor);

  @override
  Room bathroomCount(int? bathroomCount) => this(bathroomCount: bathroomCount);

  @override
  Room squareFeet(int? squareFeet) => this(squareFeet: squareFeet);

  @override
  Room isPossiblePet(bool? isPossiblePet) => this(isPossiblePet: isPossiblePet);

  @override
  Room singleBed(int? singleBed) => this(singleBed: singleBed);

  @override
  Room superSingleBed(int? superSingleBed) =>
      this(superSingleBed: superSingleBed);

  @override
  Room doubleBed(int? doubleBed) => this(doubleBed: doubleBed);

  @override
  Room queenBed(int? queenBed) => this(queenBed: queenBed);

  @override
  Room kingBed(int? kingBed) => this(kingBed: kingBed);

  @override
  Room checkIn(DateTime? checkIn) => this(checkIn: checkIn);

  @override
  Room checkOut(DateTime? checkOut) => this(checkOut: checkOut);

  @override
  Room disCountPercent(double? disCountPercent) =>
      this(disCountPercent: disCountPercent);

  @override
  Room minCheckDay(int? minCheckDay) => this(minCheckDay: minCheckDay);

  @override
  Room maxCheckDay(int? maxCheckDay) => this(maxCheckDay: maxCheckDay);

  @override
  Room oneDayAmount(int? oneDayAmount) => this(oneDayAmount: oneDayAmount);

  @override
  Room refundRuleTen(int? refundRuleTen) => this(refundRuleTen: refundRuleTen);

  @override
  Room refundRuleSeven(int? refundRuleSeven) =>
      this(refundRuleSeven: refundRuleSeven);

  @override
  Room refundRuleFive(int? refundRuleFive) =>
      this(refundRuleFive: refundRuleFive);

  @override
  Room refundRuleThree(int? refundRuleThree) =>
      this(refundRuleThree: refundRuleThree);

  @override
  Room refundRuleOne(int? refundRuleOne) => this(refundRuleOne: refundRuleOne);

  @override
  Room status(String? status) => this(status: status);

  @override
  Room address(Address? address) => this(address: address);

  @override
  Room facility(List<Facility> facility) => this(facility: facility);

  @override
  Room facilityTheme(List<Facility> facilityTheme) =>
      this(facilityTheme: facilityTheme);

  @override
  Room theme(List<Facility> theme) => this(theme: theme);

  @override
  Room imageList(List<Resource> imageList) => this(imageList: imageList);

  @override
  Room reviewList(List<Review>? reviewList) => this(reviewList: reviewList);

  @override
  Room score(double? score) => this(score: score);

  @override
  Room reviewCount(int? reviewCount) => this(reviewCount: reviewCount);

  @override
  Room amount(int? amount) => this(amount: amount);

  @override
  Room days(int? days) => this(days: days);

  @override
  Room resource(Resource? resource) => this(resource: resource);

  @override
  Room updateType(String? updateType) => this(updateType: updateType);

  @override
  Room rejectReason(String? rejectReason) => this(rejectReason: rejectReason);

  @override
  Room deleteImageIdList(List<int>? deleteImageIdList) =>
      this(deleteImageIdList: deleteImageIdList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Room(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Room(...).copyWith(id: 12, name: "My name")
  /// ````
  Room call({
    Object? createAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? possessionClassification = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? standardPeople = const $CopyWithPlaceholder(),
    Object? maximumPeople = const $CopyWithPlaceholder(),
    Object? isAdditionalPeople = const $CopyWithPlaceholder(),
    Object? additionalPeopleCost = const $CopyWithPlaceholder(),
    Object? roomCount = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? bathroomCount = const $CopyWithPlaceholder(),
    Object? squareFeet = const $CopyWithPlaceholder(),
    Object? isPossiblePet = const $CopyWithPlaceholder(),
    Object? singleBed = const $CopyWithPlaceholder(),
    Object? superSingleBed = const $CopyWithPlaceholder(),
    Object? doubleBed = const $CopyWithPlaceholder(),
    Object? queenBed = const $CopyWithPlaceholder(),
    Object? kingBed = const $CopyWithPlaceholder(),
    Object? checkIn = const $CopyWithPlaceholder(),
    Object? checkOut = const $CopyWithPlaceholder(),
    Object? disCountPercent = const $CopyWithPlaceholder(),
    Object? minCheckDay = const $CopyWithPlaceholder(),
    Object? maxCheckDay = const $CopyWithPlaceholder(),
    Object? oneDayAmount = const $CopyWithPlaceholder(),
    Object? refundRuleTen = const $CopyWithPlaceholder(),
    Object? refundRuleSeven = const $CopyWithPlaceholder(),
    Object? refundRuleFive = const $CopyWithPlaceholder(),
    Object? refundRuleThree = const $CopyWithPlaceholder(),
    Object? refundRuleOne = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? facility = const $CopyWithPlaceholder(),
    Object? facilityTheme = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
    Object? imageList = const $CopyWithPlaceholder(),
    Object? reviewList = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? reviewCount = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? days = const $CopyWithPlaceholder(),
    Object? resource = const $CopyWithPlaceholder(),
    Object? updateType = const $CopyWithPlaceholder(),
    Object? rejectReason = const $CopyWithPlaceholder(),
    Object? deleteImageIdList = const $CopyWithPlaceholder(),
  }) {
    return Room(
      createAt: createAt == const $CopyWithPlaceholder()
          ? _value.createAt
          // ignore: cast_nullable_to_non_nullable
          : createAt as DateTime?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      possessionClassification:
          possessionClassification == const $CopyWithPlaceholder()
              ? _value.possessionClassification
              // ignore: cast_nullable_to_non_nullable
              : possessionClassification as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      standardPeople: standardPeople == const $CopyWithPlaceholder()
          ? _value.standardPeople
          // ignore: cast_nullable_to_non_nullable
          : standardPeople as int?,
      maximumPeople: maximumPeople == const $CopyWithPlaceholder()
          ? _value.maximumPeople
          // ignore: cast_nullable_to_non_nullable
          : maximumPeople as int?,
      isAdditionalPeople: isAdditionalPeople == const $CopyWithPlaceholder()
          ? _value.isAdditionalPeople
          // ignore: cast_nullable_to_non_nullable
          : isAdditionalPeople as bool?,
      additionalPeopleCost: additionalPeopleCost == const $CopyWithPlaceholder()
          ? _value.additionalPeopleCost
          // ignore: cast_nullable_to_non_nullable
          : additionalPeopleCost as int?,
      roomCount: roomCount == const $CopyWithPlaceholder()
          ? _value.roomCount
          // ignore: cast_nullable_to_non_nullable
          : roomCount as int?,
      floor: floor == const $CopyWithPlaceholder()
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as int?,
      bathroomCount: bathroomCount == const $CopyWithPlaceholder()
          ? _value.bathroomCount
          // ignore: cast_nullable_to_non_nullable
          : bathroomCount as int?,
      squareFeet: squareFeet == const $CopyWithPlaceholder()
          ? _value.squareFeet
          // ignore: cast_nullable_to_non_nullable
          : squareFeet as int?,
      isPossiblePet: isPossiblePet == const $CopyWithPlaceholder()
          ? _value.isPossiblePet
          // ignore: cast_nullable_to_non_nullable
          : isPossiblePet as bool?,
      singleBed: singleBed == const $CopyWithPlaceholder()
          ? _value.singleBed
          // ignore: cast_nullable_to_non_nullable
          : singleBed as int?,
      superSingleBed: superSingleBed == const $CopyWithPlaceholder()
          ? _value.superSingleBed
          // ignore: cast_nullable_to_non_nullable
          : superSingleBed as int?,
      doubleBed: doubleBed == const $CopyWithPlaceholder()
          ? _value.doubleBed
          // ignore: cast_nullable_to_non_nullable
          : doubleBed as int?,
      queenBed: queenBed == const $CopyWithPlaceholder()
          ? _value.queenBed
          // ignore: cast_nullable_to_non_nullable
          : queenBed as int?,
      kingBed: kingBed == const $CopyWithPlaceholder()
          ? _value.kingBed
          // ignore: cast_nullable_to_non_nullable
          : kingBed as int?,
      checkIn: checkIn == const $CopyWithPlaceholder()
          ? _value.checkIn
          // ignore: cast_nullable_to_non_nullable
          : checkIn as DateTime?,
      checkOut: checkOut == const $CopyWithPlaceholder()
          ? _value.checkOut
          // ignore: cast_nullable_to_non_nullable
          : checkOut as DateTime?,
      disCountPercent: disCountPercent == const $CopyWithPlaceholder()
          ? _value.disCountPercent
          // ignore: cast_nullable_to_non_nullable
          : disCountPercent as double?,
      minCheckDay: minCheckDay == const $CopyWithPlaceholder()
          ? _value.minCheckDay
          // ignore: cast_nullable_to_non_nullable
          : minCheckDay as int?,
      maxCheckDay: maxCheckDay == const $CopyWithPlaceholder()
          ? _value.maxCheckDay
          // ignore: cast_nullable_to_non_nullable
          : maxCheckDay as int?,
      oneDayAmount: oneDayAmount == const $CopyWithPlaceholder()
          ? _value.oneDayAmount
          // ignore: cast_nullable_to_non_nullable
          : oneDayAmount as int?,
      refundRuleTen: refundRuleTen == const $CopyWithPlaceholder()
          ? _value.refundRuleTen
          // ignore: cast_nullable_to_non_nullable
          : refundRuleTen as int?,
      refundRuleSeven: refundRuleSeven == const $CopyWithPlaceholder()
          ? _value.refundRuleSeven
          // ignore: cast_nullable_to_non_nullable
          : refundRuleSeven as int?,
      refundRuleFive: refundRuleFive == const $CopyWithPlaceholder()
          ? _value.refundRuleFive
          // ignore: cast_nullable_to_non_nullable
          : refundRuleFive as int?,
      refundRuleThree: refundRuleThree == const $CopyWithPlaceholder()
          ? _value.refundRuleThree
          // ignore: cast_nullable_to_non_nullable
          : refundRuleThree as int?,
      refundRuleOne: refundRuleOne == const $CopyWithPlaceholder()
          ? _value.refundRuleOne
          // ignore: cast_nullable_to_non_nullable
          : refundRuleOne as int?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as Address?,
      facility: facility == const $CopyWithPlaceholder() || facility == null
          ? _value.facility
          // ignore: cast_nullable_to_non_nullable
          : facility as List<Facility>,
      facilityTheme:
          facilityTheme == const $CopyWithPlaceholder() || facilityTheme == null
              ? _value.facilityTheme
              // ignore: cast_nullable_to_non_nullable
              : facilityTheme as List<Facility>,
      theme: theme == const $CopyWithPlaceholder() || theme == null
          ? _value.theme
          // ignore: cast_nullable_to_non_nullable
          : theme as List<Facility>,
      imageList: imageList == const $CopyWithPlaceholder() || imageList == null
          ? _value.imageList
          // ignore: cast_nullable_to_non_nullable
          : imageList as List<Resource>,
      reviewList: reviewList == const $CopyWithPlaceholder()
          ? _value.reviewList
          // ignore: cast_nullable_to_non_nullable
          : reviewList as List<Review>?,
      score: score == const $CopyWithPlaceholder()
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as double?,
      reviewCount: reviewCount == const $CopyWithPlaceholder()
          ? _value.reviewCount
          // ignore: cast_nullable_to_non_nullable
          : reviewCount as int?,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int?,
      days: days == const $CopyWithPlaceholder()
          ? _value.days
          // ignore: cast_nullable_to_non_nullable
          : days as int?,
      resource: resource == const $CopyWithPlaceholder()
          ? _value.resource
          // ignore: cast_nullable_to_non_nullable
          : resource as Resource?,
      updateType: updateType == const $CopyWithPlaceholder()
          ? _value.updateType
          // ignore: cast_nullable_to_non_nullable
          : updateType as String?,
      rejectReason: rejectReason == const $CopyWithPlaceholder()
          ? _value.rejectReason
          // ignore: cast_nullable_to_non_nullable
          : rejectReason as String?,
      deleteImageIdList: deleteImageIdList == const $CopyWithPlaceholder()
          ? _value.deleteImageIdList
          // ignore: cast_nullable_to_non_nullable
          : deleteImageIdList as List<int>?,
    );
  }
}

extension $RoomCopyWith on Room {
  /// Returns a callable class that can be used as follows: `instanceOfRoom.copyWith(...)` or like so:`instanceOfRoom.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RoomCWProxy get copyWith => _$RoomCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      createAt: json['createAt'] == null
          ? null
          : DateTime.parse(json['createAt'] as String),
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      possessionClassification: json['possessionClassification'] as String?,
      description: json['description'] as String? ?? '',
      standardPeople: json['standardPeople'] as int? ?? 1,
      maximumPeople: json['maximumPeople'] as int? ?? 1,
      isAdditionalPeople: json['isAdditionalPeople'] as bool? ?? false,
      additionalPeopleCost: json['additionalPeopleCost'] as int? ?? 0,
      roomCount: json['roomCount'] as int? ?? 1,
      floor: json['floor'] as int? ?? 1,
      bathroomCount: json['bathroomCount'] as int? ?? 1,
      squareFeet: json['squareFeet'] as int? ?? 0,
      isPossiblePet: json['isPossiblePet'] as bool? ?? false,
      singleBed: json['singleBed'] as int? ?? 0,
      superSingleBed: json['superSingleBed'] as int? ?? 0,
      doubleBed: json['doubleBed'] as int? ?? 0,
      queenBed: json['queenBed'] as int? ?? 0,
      kingBed: json['kingBed'] as int? ?? 0,
      checkIn: json['checkIn'] == null
          ? null
          : DateTime.parse(json['checkIn'] as String),
      checkOut: json['checkOut'] == null
          ? null
          : DateTime.parse(json['checkOut'] as String),
      disCountPercent: (json['disCountPercent'] as num?)?.toDouble() ?? 0,
      minCheckDay: json['minCheckDay'] as int? ?? 2,
      maxCheckDay: json['maxCheckDay'] as int? ?? 2,
      oneDayAmount: json['oneDayAmount'] as int? ?? 0,
      refundRuleTen: json['refundRuleTen'] as int? ?? 100,
      refundRuleSeven: json['refundRuleSeven'] as int? ?? 70,
      refundRuleFive: json['refundRuleFive'] as int? ?? 50,
      refundRuleThree: json['refundRuleThree'] as int? ?? 30,
      refundRuleOne: json['refundRuleOne'] as int? ?? 0,
      status: json['status'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      facility: (json['facility'] as List<dynamic>?)
              ?.map((e) => Facility.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      facilityTheme: (json['facilityTheme'] as List<dynamic>?)
              ?.map((e) => Facility.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      theme: (json['theme'] as List<dynamic>?)
              ?.map((e) => Facility.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      imageList: (json['imageList'] as List<dynamic>?)
              ?.map((e) => Resource.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      reviewList: (json['reviewList'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      score: (json['score'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      amount: json['amount'] as int?,
      days: json['days'] as int?,
      resource: json['resource'] == null
          ? null
          : Resource.fromJson(json['resource'] as Map<String, dynamic>),
      updateType: json['updateType'] as String?,
      rejectReason: json['rejectReason'] as String?,
      deleteImageIdList: (json['deleteImageIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'createAt': instance.createAt?.toIso8601String(),
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'standardPeople': instance.standardPeople,
      'maximumPeople': instance.maximumPeople,
      'isAdditionalPeople': instance.isAdditionalPeople,
      'additionalPeopleCost': instance.additionalPeopleCost,
      'roomCount': instance.roomCount,
      'floor': instance.floor,
      'bathroomCount': instance.bathroomCount,
      'squareFeet': instance.squareFeet,
      'isPossiblePet': instance.isPossiblePet,
      'singleBed': instance.singleBed,
      'superSingleBed': instance.superSingleBed,
      'doubleBed': instance.doubleBed,
      'queenBed': instance.queenBed,
      'kingBed': instance.kingBed,
      'checkIn': instance.checkIn?.toIso8601String(),
      'checkOut': instance.checkOut?.toIso8601String(),
      'minCheckDay': instance.minCheckDay,
      'maxCheckDay': instance.maxCheckDay,
      'oneDayAmount': instance.oneDayAmount,
      'amount': instance.amount,
      'days': instance.days,
      'disCountPercent': instance.disCountPercent,
      'refundRuleTen': instance.refundRuleTen,
      'refundRuleSeven': instance.refundRuleSeven,
      'refundRuleFive': instance.refundRuleFive,
      'refundRuleThree': instance.refundRuleThree,
      'refundRuleOne': instance.refundRuleOne,
      'possessionClassification': instance.possessionClassification,
      'status': instance.status,
      'address': instance.address,
      'facility': instance.facility,
      'theme': instance.theme,
      'facilityTheme': instance.facilityTheme,
      'imageList': instance.imageList,
      'reviewList': instance.reviewList,
      'score': instance.score,
      'reviewCount': instance.reviewCount,
      'resource': instance.resource,
      'updateType': instance.updateType,
      'rejectReason': instance.rejectReason,
      'deleteImageIdList': instance.deleteImageIdList,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      code: json['code'] as String?,
      address: json['address'] as String?,
      addressDetail: json['addressDetail'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'code': instance.code,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Facility _$FacilityFromJson(Map<String, dynamic> json) => Facility(
      id: json['id'] as int?,
      facilityThemeId: json['facilityThemeId'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      select: json['select'] as bool? ?? false,
      etcFacility: json['etcFacility'] as String?,
    );

Map<String, dynamic> _$FacilityToJson(Facility instance) => <String, dynamic>{
      'id': instance.id,
      'facilityThemeId': instance.facilityThemeId,
      'type': instance.type,
      'name': instance.name,
      'etcFacility': instance.etcFacility,
      'select': instance.select,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      id: json['id'] as int?,
      originalFileName: json['originalFileName'] as String?,
      path: json['path'] as String?,
      size: json['size'] as int?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'id': instance.id,
      'originalFileName': instance.originalFileName,
      'path': instance.path,
      'size': instance.size,
      'type': instance.type,
    };

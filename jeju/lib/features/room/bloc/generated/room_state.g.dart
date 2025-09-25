// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../room_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RoomStateCWProxy {
  RoomState status(CommonStatus status);

  RoomState errorMessage(String? errorMessage);

  RoomState filterType(FilterType filterType);

  RoomState hasReachedMax(bool hasReachedMax);

  RoomState orderType(OrderType orderType);

  RoomState page(int page);

  RoomState query(String? query);

  RoomState pageInfo(PageInfo? pageInfo);

  RoomState room(Room room);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    PageInfo? pageInfo,
    Room? room,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRoomState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRoomState.copyWith.fieldName(...)`
class _$RoomStateCWProxyImpl implements _$RoomStateCWProxy {
  const _$RoomStateCWProxyImpl(this._value);

  final RoomState _value;

  @override
  RoomState status(CommonStatus status) => this(status: status);

  @override
  RoomState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  RoomState filterType(FilterType filterType) => this(filterType: filterType);

  @override
  RoomState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  RoomState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  RoomState page(int page) => this(page: page);

  @override
  RoomState query(String? query) => this(query: query);

  @override
  RoomState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  RoomState room(Room room) => this(room: room);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
  }) {
    return RoomState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
    );
  }
}

extension $RoomStateCopyWith on RoomState {
  /// Returns a callable class that can be used as follows: `instanceOfRoomState.copyWith(...)` or like so:`instanceOfRoomState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RoomStateCWProxy get copyWith => _$RoomStateCWProxyImpl(this);
}

abstract class _$AddRoomStateCWProxy {
  AddRoomState status(CommonStatus status);

  AddRoomState errorMessage(String? errorMessage);

  AddRoomState filterType(FilterType filterType);

  AddRoomState hasReachedMax(bool hasReachedMax);

  AddRoomState orderType(OrderType orderType);

  AddRoomState page(int page);

  AddRoomState query(String? query);

  AddRoomState addressStatus(CommonStatus addressStatus);

  AddRoomState document(Document? document);

  AddRoomState documents(List<Document>? documents);

  AddRoomState step(String? step);

  AddRoomState images(List<XFile>? images);

  AddRoomState room(Room room);

  AddRoomState owner(String? owner);

  AddRoomState facilities(Map<String?, List<Facility>?> facilities);

  AddRoomState themes(Map<String?, List<Facility>?> themes);

  AddRoomState paths(List<String>? paths);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddRoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddRoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddRoomState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    CommonStatus? addressStatus,
    Document? document,
    List<Document>? documents,
    String? step,
    List<XFile>? images,
    Room? room,
    String? owner,
    Map<String?, List<Facility>?>? facilities,
    Map<String?, List<Facility>?>? themes,
    List<String>? paths,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddRoomState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddRoomState.copyWith.fieldName(...)`
class _$AddRoomStateCWProxyImpl implements _$AddRoomStateCWProxy {
  const _$AddRoomStateCWProxyImpl(this._value);

  final AddRoomState _value;

  @override
  AddRoomState status(CommonStatus status) => this(status: status);

  @override
  AddRoomState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  AddRoomState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  AddRoomState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  AddRoomState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  AddRoomState page(int page) => this(page: page);

  @override
  AddRoomState query(String? query) => this(query: query);

  @override
  AddRoomState addressStatus(CommonStatus addressStatus) =>
      this(addressStatus: addressStatus);

  @override
  AddRoomState document(Document? document) => this(document: document);

  @override
  AddRoomState documents(List<Document>? documents) =>
      this(documents: documents);

  @override
  AddRoomState step(String? step) => this(step: step);

  @override
  AddRoomState images(List<XFile>? images) => this(images: images);

  @override
  AddRoomState room(Room room) => this(room: room);

  @override
  AddRoomState owner(String? owner) => this(owner: owner);

  @override
  AddRoomState facilities(Map<String?, List<Facility>?> facilities) =>
      this(facilities: facilities);

  @override
  AddRoomState themes(Map<String?, List<Facility>?> themes) =>
      this(themes: themes);

  @override
  AddRoomState paths(List<String>? paths) => this(paths: paths);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddRoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddRoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddRoomState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? addressStatus = const $CopyWithPlaceholder(),
    Object? document = const $CopyWithPlaceholder(),
    Object? documents = const $CopyWithPlaceholder(),
    Object? step = const $CopyWithPlaceholder(),
    Object? images = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
    Object? owner = const $CopyWithPlaceholder(),
    Object? facilities = const $CopyWithPlaceholder(),
    Object? themes = const $CopyWithPlaceholder(),
    Object? paths = const $CopyWithPlaceholder(),
  }) {
    return AddRoomState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      addressStatus:
          addressStatus == const $CopyWithPlaceholder() || addressStatus == null
              ? _value.addressStatus
              // ignore: cast_nullable_to_non_nullable
              : addressStatus as CommonStatus,
      document: document == const $CopyWithPlaceholder()
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as Document?,
      documents: documents == const $CopyWithPlaceholder()
          ? _value.documents
          // ignore: cast_nullable_to_non_nullable
          : documents as List<Document>?,
      step: step == const $CopyWithPlaceholder()
          ? _value.step
          // ignore: cast_nullable_to_non_nullable
          : step as String?,
      images: images == const $CopyWithPlaceholder()
          ? _value.images
          // ignore: cast_nullable_to_non_nullable
          : images as List<XFile>?,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
      owner: owner == const $CopyWithPlaceholder()
          ? _value.owner
          // ignore: cast_nullable_to_non_nullable
          : owner as String?,
      facilities:
          facilities == const $CopyWithPlaceholder() || facilities == null
              ? _value.facilities
              // ignore: cast_nullable_to_non_nullable
              : facilities as Map<String?, List<Facility>?>,
      themes: themes == const $CopyWithPlaceholder() || themes == null
          ? _value.themes
          // ignore: cast_nullable_to_non_nullable
          : themes as Map<String?, List<Facility>?>,
      paths: paths == const $CopyWithPlaceholder()
          ? _value.paths
          // ignore: cast_nullable_to_non_nullable
          : paths as List<String>?,
    );
  }
}

extension $AddRoomStateCopyWith on AddRoomState {
  /// Returns a callable class that can be used as follows: `instanceOfAddRoomState.copyWith(...)` or like so:`instanceOfAddRoomState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddRoomStateCWProxy get copyWith => _$AddRoomStateCWProxyImpl(this);
}

abstract class _$RoomDetailStateCWProxy {
  RoomDetailState status(CommonStatus status);

  RoomDetailState errorMessage(String? errorMessage);

  RoomDetailState filterType(FilterType filterType);

  RoomDetailState hasReachedMax(bool hasReachedMax);

  RoomDetailState orderType(OrderType orderType);

  RoomDetailState page(int page);

  RoomDetailState query(String? query);

  RoomDetailState pageInfo(PageInfo? pageInfo);

  RoomDetailState zoomImage(bool zoomImage);

  RoomDetailState calenderDate(DateTime? calenderDate);

  RoomDetailState dateRange(DateRange? dateRange);

  RoomDetailState showPrice(bool showPrice);

  RoomDetailState room(Room room);

  RoomDetailState guestCount(int guestCount);

  RoomDetailState order(String? order);

  RoomDetailState guestList(List<String> guestList);

  RoomDetailState hostProfile(Profile? hostProfile);

  RoomDetailState stopHosting(List<DateTime>? stopHosting);

  RoomDetailState plusPriceList(List<DateManagement>? plusPriceList);

  RoomDetailState plusPrice(int plusPrice);

  RoomDetailState normalDay(int normalDay);

  RoomDetailState specificDay(int specificDay);

  RoomDetailState report(bool report);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomDetailState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    PageInfo? pageInfo,
    bool? zoomImage,
    DateTime? calenderDate,
    DateRange? dateRange,
    bool? showPrice,
    Room? room,
    int? guestCount,
    String? order,
    List<String>? guestList,
    Profile? hostProfile,
    List<DateTime>? stopHosting,
    List<DateManagement>? plusPriceList,
    int? plusPrice,
    int? normalDay,
    int? specificDay,
    bool? report,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRoomDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRoomDetailState.copyWith.fieldName(...)`
class _$RoomDetailStateCWProxyImpl implements _$RoomDetailStateCWProxy {
  const _$RoomDetailStateCWProxyImpl(this._value);

  final RoomDetailState _value;

  @override
  RoomDetailState status(CommonStatus status) => this(status: status);

  @override
  RoomDetailState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  RoomDetailState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  RoomDetailState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  RoomDetailState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  RoomDetailState page(int page) => this(page: page);

  @override
  RoomDetailState query(String? query) => this(query: query);

  @override
  RoomDetailState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  RoomDetailState zoomImage(bool zoomImage) => this(zoomImage: zoomImage);

  @override
  RoomDetailState calenderDate(DateTime? calenderDate) =>
      this(calenderDate: calenderDate);

  @override
  RoomDetailState dateRange(DateRange? dateRange) => this(dateRange: dateRange);

  @override
  RoomDetailState showPrice(bool showPrice) => this(showPrice: showPrice);

  @override
  RoomDetailState room(Room room) => this(room: room);

  @override
  RoomDetailState guestCount(int guestCount) => this(guestCount: guestCount);

  @override
  RoomDetailState order(String? order) => this(order: order);

  @override
  RoomDetailState guestList(List<String> guestList) =>
      this(guestList: guestList);

  @override
  RoomDetailState hostProfile(Profile? hostProfile) =>
      this(hostProfile: hostProfile);

  @override
  RoomDetailState stopHosting(List<DateTime>? stopHosting) =>
      this(stopHosting: stopHosting);

  @override
  RoomDetailState plusPriceList(List<DateManagement>? plusPriceList) =>
      this(plusPriceList: plusPriceList);

  @override
  RoomDetailState plusPrice(int plusPrice) => this(plusPrice: plusPrice);

  @override
  RoomDetailState normalDay(int normalDay) => this(normalDay: normalDay);

  @override
  RoomDetailState specificDay(int specificDay) =>
      this(specificDay: specificDay);

  @override
  RoomDetailState report(bool report) => this(report: report);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomDetailState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? zoomImage = const $CopyWithPlaceholder(),
    Object? calenderDate = const $CopyWithPlaceholder(),
    Object? dateRange = const $CopyWithPlaceholder(),
    Object? showPrice = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
    Object? guestCount = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
    Object? guestList = const $CopyWithPlaceholder(),
    Object? hostProfile = const $CopyWithPlaceholder(),
    Object? stopHosting = const $CopyWithPlaceholder(),
    Object? plusPriceList = const $CopyWithPlaceholder(),
    Object? plusPrice = const $CopyWithPlaceholder(),
    Object? normalDay = const $CopyWithPlaceholder(),
    Object? specificDay = const $CopyWithPlaceholder(),
    Object? report = const $CopyWithPlaceholder(),
  }) {
    return RoomDetailState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      zoomImage: zoomImage == const $CopyWithPlaceholder() || zoomImage == null
          ? _value.zoomImage
          // ignore: cast_nullable_to_non_nullable
          : zoomImage as bool,
      calenderDate: calenderDate == const $CopyWithPlaceholder()
          ? _value.calenderDate
          // ignore: cast_nullable_to_non_nullable
          : calenderDate as DateTime?,
      dateRange: dateRange == const $CopyWithPlaceholder()
          ? _value.dateRange
          // ignore: cast_nullable_to_non_nullable
          : dateRange as DateRange?,
      showPrice: showPrice == const $CopyWithPlaceholder() || showPrice == null
          ? _value.showPrice
          // ignore: cast_nullable_to_non_nullable
          : showPrice as bool,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
      guestCount:
          guestCount == const $CopyWithPlaceholder() || guestCount == null
              ? _value.guestCount
              // ignore: cast_nullable_to_non_nullable
              : guestCount as int,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as String?,
      guestList: guestList == const $CopyWithPlaceholder() || guestList == null
          ? _value.guestList
          // ignore: cast_nullable_to_non_nullable
          : guestList as List<String>,
      hostProfile: hostProfile == const $CopyWithPlaceholder()
          ? _value.hostProfile
          // ignore: cast_nullable_to_non_nullable
          : hostProfile as Profile?,
      stopHosting: stopHosting == const $CopyWithPlaceholder()
          ? _value.stopHosting
          // ignore: cast_nullable_to_non_nullable
          : stopHosting as List<DateTime>?,
      plusPriceList: plusPriceList == const $CopyWithPlaceholder()
          ? _value.plusPriceList
          // ignore: cast_nullable_to_non_nullable
          : plusPriceList as List<DateManagement>?,
      plusPrice: plusPrice == const $CopyWithPlaceholder() || plusPrice == null
          ? _value.plusPrice
          // ignore: cast_nullable_to_non_nullable
          : plusPrice as int,
      normalDay: normalDay == const $CopyWithPlaceholder() || normalDay == null
          ? _value.normalDay
          // ignore: cast_nullable_to_non_nullable
          : normalDay as int,
      specificDay:
          specificDay == const $CopyWithPlaceholder() || specificDay == null
              ? _value.specificDay
              // ignore: cast_nullable_to_non_nullable
              : specificDay as int,
      report: report == const $CopyWithPlaceholder() || report == null
          ? _value.report
          // ignore: cast_nullable_to_non_nullable
          : report as bool,
    );
  }
}

extension $RoomDetailStateCopyWith on RoomDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfRoomDetailState.copyWith(...)` or like so:`instanceOfRoomDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RoomDetailStateCWProxy get copyWith => _$RoomDetailStateCWProxyImpl(this);
}

abstract class _$RoomManagementStateCWProxy {
  RoomManagementState status(CommonStatus status);

  RoomManagementState errorMessage(String? errorMessage);

  RoomManagementState filterType(FilterType filterType);

  RoomManagementState hasReachedMax(bool hasReachedMax);

  RoomManagementState orderType(OrderType orderType);

  RoomManagementState page(int page);

  RoomManagementState query(String? query);

  RoomManagementState pageInfo(PageInfo? pageInfo);

  RoomManagementState addressStatus(CommonStatus addressStatus);

  RoomManagementState step(String? step);

  RoomManagementState room(Room room);

  RoomManagementState owner(String? owner);

  RoomManagementState facilities(Map<String?, List<Facility>?> facilities);

  RoomManagementState themes(Map<String?, List<Facility>?> themes);

  RoomManagementState images(List<FileDTO>? images);

  RoomManagementState rooms(List<Room> rooms);

  RoomManagementState selectedFacilities(List<Facility> selectedFacilities);

  RoomManagementState selectedThemes(List<Facility> selectedThemes);

  RoomManagementState isInitial(bool? isInitial);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomManagementState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    PageInfo? pageInfo,
    CommonStatus? addressStatus,
    String? step,
    Room? room,
    String? owner,
    Map<String?, List<Facility>?>? facilities,
    Map<String?, List<Facility>?>? themes,
    List<FileDTO>? images,
    List<Room>? rooms,
    List<Facility>? selectedFacilities,
    List<Facility>? selectedThemes,
    bool? isInitial,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRoomManagementState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRoomManagementState.copyWith.fieldName(...)`
class _$RoomManagementStateCWProxyImpl implements _$RoomManagementStateCWProxy {
  const _$RoomManagementStateCWProxyImpl(this._value);

  final RoomManagementState _value;

  @override
  RoomManagementState status(CommonStatus status) => this(status: status);

  @override
  RoomManagementState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  RoomManagementState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  RoomManagementState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  RoomManagementState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  RoomManagementState page(int page) => this(page: page);

  @override
  RoomManagementState query(String? query) => this(query: query);

  @override
  RoomManagementState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  RoomManagementState addressStatus(CommonStatus addressStatus) =>
      this(addressStatus: addressStatus);

  @override
  RoomManagementState step(String? step) => this(step: step);

  @override
  RoomManagementState room(Room room) => this(room: room);

  @override
  RoomManagementState owner(String? owner) => this(owner: owner);

  @override
  RoomManagementState facilities(Map<String?, List<Facility>?> facilities) =>
      this(facilities: facilities);

  @override
  RoomManagementState themes(Map<String?, List<Facility>?> themes) =>
      this(themes: themes);

  @override
  RoomManagementState images(List<FileDTO>? images) => this(images: images);

  @override
  RoomManagementState rooms(List<Room> rooms) => this(rooms: rooms);

  @override
  RoomManagementState selectedFacilities(List<Facility> selectedFacilities) =>
      this(selectedFacilities: selectedFacilities);

  @override
  RoomManagementState selectedThemes(List<Facility> selectedThemes) =>
      this(selectedThemes: selectedThemes);

  @override
  RoomManagementState isInitial(bool? isInitial) => this(isInitial: isInitial);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomManagementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomManagementState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomManagementState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? addressStatus = const $CopyWithPlaceholder(),
    Object? step = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
    Object? owner = const $CopyWithPlaceholder(),
    Object? facilities = const $CopyWithPlaceholder(),
    Object? themes = const $CopyWithPlaceholder(),
    Object? images = const $CopyWithPlaceholder(),
    Object? rooms = const $CopyWithPlaceholder(),
    Object? selectedFacilities = const $CopyWithPlaceholder(),
    Object? selectedThemes = const $CopyWithPlaceholder(),
    Object? isInitial = const $CopyWithPlaceholder(),
  }) {
    return RoomManagementState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      addressStatus:
          addressStatus == const $CopyWithPlaceholder() || addressStatus == null
              ? _value.addressStatus
              // ignore: cast_nullable_to_non_nullable
              : addressStatus as CommonStatus,
      step: step == const $CopyWithPlaceholder()
          ? _value.step
          // ignore: cast_nullable_to_non_nullable
          : step as String?,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
      owner: owner == const $CopyWithPlaceholder()
          ? _value.owner
          // ignore: cast_nullable_to_non_nullable
          : owner as String?,
      facilities:
          facilities == const $CopyWithPlaceholder() || facilities == null
              ? _value.facilities
              // ignore: cast_nullable_to_non_nullable
              : facilities as Map<String?, List<Facility>?>,
      themes: themes == const $CopyWithPlaceholder() || themes == null
          ? _value.themes
          // ignore: cast_nullable_to_non_nullable
          : themes as Map<String?, List<Facility>?>,
      images: images == const $CopyWithPlaceholder()
          ? _value.images
          // ignore: cast_nullable_to_non_nullable
          : images as List<FileDTO>?,
      rooms: rooms == const $CopyWithPlaceholder() || rooms == null
          ? _value.rooms
          // ignore: cast_nullable_to_non_nullable
          : rooms as List<Room>,
      selectedFacilities: selectedFacilities == const $CopyWithPlaceholder() ||
              selectedFacilities == null
          ? _value.selectedFacilities
          // ignore: cast_nullable_to_non_nullable
          : selectedFacilities as List<Facility>,
      selectedThemes: selectedThemes == const $CopyWithPlaceholder() ||
              selectedThemes == null
          ? _value.selectedThemes
          // ignore: cast_nullable_to_non_nullable
          : selectedThemes as List<Facility>,
      isInitial: isInitial == const $CopyWithPlaceholder()
          ? _value.isInitial
          // ignore: cast_nullable_to_non_nullable
          : isInitial as bool?,
    );
  }
}

extension $RoomManagementStateCopyWith on RoomManagementState {
  /// Returns a callable class that can be used as follows: `instanceOfRoomManagementState.copyWith(...)` or like so:`instanceOfRoomManagementState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RoomManagementStateCWProxy get copyWith =>
      _$RoomManagementStateCWProxyImpl(this);
}

abstract class _$RoomListStateCWProxy {
  RoomListState status(CommonStatus status);

  RoomListState errorMessage(String? errorMessage);

  RoomListState filterType(FilterType filterType);

  RoomListState hasReachedMax(bool hasReachedMax);

  RoomListState orderType(OrderType orderType);

  RoomListState page(int page);

  RoomListState query(String? query);

  RoomListState pageInfo(PageInfo? pageInfo);

  RoomListState rooms(List<Room> rooms);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomListState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomListState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    PageInfo? pageInfo,
    List<Room>? rooms,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRoomListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRoomListState.copyWith.fieldName(...)`
class _$RoomListStateCWProxyImpl implements _$RoomListStateCWProxy {
  const _$RoomListStateCWProxyImpl(this._value);

  final RoomListState _value;

  @override
  RoomListState status(CommonStatus status) => this(status: status);

  @override
  RoomListState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  RoomListState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  RoomListState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  RoomListState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  RoomListState page(int page) => this(page: page);

  @override
  RoomListState query(String? query) => this(query: query);

  @override
  RoomListState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  RoomListState rooms(List<Room> rooms) => this(rooms: rooms);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomListState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomListState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? rooms = const $CopyWithPlaceholder(),
  }) {
    return RoomListState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      rooms: rooms == const $CopyWithPlaceholder() || rooms == null
          ? _value.rooms
          // ignore: cast_nullable_to_non_nullable
          : rooms as List<Room>,
    );
  }
}

extension $RoomListStateCopyWith on RoomListState {
  /// Returns a callable class that can be used as follows: `instanceOfRoomListState.copyWith(...)` or like so:`instanceOfRoomListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RoomListStateCWProxy get copyWith => _$RoomListStateCWProxyImpl(this);
}

abstract class _$HostRoomListStateCWProxy {
  HostRoomListState status(CommonStatus status);

  HostRoomListState errorMessage(String? errorMessage);

  HostRoomListState filterType(FilterType filterType);

  HostRoomListState hasReachedMax(bool hasReachedMax);

  HostRoomListState orderType(OrderType orderType);

  HostRoomListState page(int page);

  HostRoomListState query(String? query);

  HostRoomListState pageInfo(PageInfo? pageInfo);

  HostRoomListState rooms(List<Room> rooms);

  HostRoomListState reservations(List<Reservation> reservations);

  HostRoomListState room(Room room);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostRoomListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostRoomListState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostRoomListState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    PageInfo? pageInfo,
    List<Room>? rooms,
    List<Reservation>? reservations,
    Room? room,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostRoomListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostRoomListState.copyWith.fieldName(...)`
class _$HostRoomListStateCWProxyImpl implements _$HostRoomListStateCWProxy {
  const _$HostRoomListStateCWProxyImpl(this._value);

  final HostRoomListState _value;

  @override
  HostRoomListState status(CommonStatus status) => this(status: status);

  @override
  HostRoomListState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  HostRoomListState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  HostRoomListState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  HostRoomListState orderType(OrderType orderType) =>
      this(orderType: orderType);

  @override
  HostRoomListState page(int page) => this(page: page);

  @override
  HostRoomListState query(String? query) => this(query: query);

  @override
  HostRoomListState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  HostRoomListState rooms(List<Room> rooms) => this(rooms: rooms);

  @override
  HostRoomListState reservations(List<Reservation> reservations) =>
      this(reservations: reservations);

  @override
  HostRoomListState room(Room room) => this(room: room);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostRoomListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostRoomListState(...).copyWith(id: 12, name: "My name")
  /// ````
  HostRoomListState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? rooms = const $CopyWithPlaceholder(),
    Object? reservations = const $CopyWithPlaceholder(),
    Object? room = const $CopyWithPlaceholder(),
  }) {
    return HostRoomListState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      rooms: rooms == const $CopyWithPlaceholder() || rooms == null
          ? _value.rooms
          // ignore: cast_nullable_to_non_nullable
          : rooms as List<Room>,
      reservations:
          reservations == const $CopyWithPlaceholder() || reservations == null
              ? _value.reservations
              // ignore: cast_nullable_to_non_nullable
              : reservations as List<Reservation>,
      room: room == const $CopyWithPlaceholder() || room == null
          ? _value.room
          // ignore: cast_nullable_to_non_nullable
          : room as Room,
    );
  }
}

extension $HostRoomListStateCopyWith on HostRoomListState {
  /// Returns a callable class that can be used as follows: `instanceOfHostRoomListState.copyWith(...)` or like so:`instanceOfHostRoomListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostRoomListStateCWProxy get copyWith =>
      _$HostRoomListStateCWProxyImpl(this);
}

abstract class _$RecentRoomStateCWProxy {
  RecentRoomState status(CommonStatus status);

  RecentRoomState errorMessage(String? errorMessage);

  RecentRoomState filterType(FilterType filterType);

  RecentRoomState hasReachedMax(bool hasReachedMax);

  RecentRoomState orderType(OrderType orderType);

  RecentRoomState page(int page);

  RecentRoomState query(String? query);

  RecentRoomState pageInfo(PageInfo? pageInfo);

  RecentRoomState roomList(List<Room> roomList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RecentRoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RecentRoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  RecentRoomState call({
    CommonStatus? status,
    String? errorMessage,
    FilterType? filterType,
    bool? hasReachedMax,
    OrderType? orderType,
    int? page,
    String? query,
    PageInfo? pageInfo,
    List<Room>? roomList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRecentRoomState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRecentRoomState.copyWith.fieldName(...)`
class _$RecentRoomStateCWProxyImpl implements _$RecentRoomStateCWProxy {
  const _$RecentRoomStateCWProxyImpl(this._value);

  final RecentRoomState _value;

  @override
  RecentRoomState status(CommonStatus status) => this(status: status);

  @override
  RecentRoomState errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  RecentRoomState filterType(FilterType filterType) =>
      this(filterType: filterType);

  @override
  RecentRoomState hasReachedMax(bool hasReachedMax) =>
      this(hasReachedMax: hasReachedMax);

  @override
  RecentRoomState orderType(OrderType orderType) => this(orderType: orderType);

  @override
  RecentRoomState page(int page) => this(page: page);

  @override
  RecentRoomState query(String? query) => this(query: query);

  @override
  RecentRoomState pageInfo(PageInfo? pageInfo) => this(pageInfo: pageInfo);

  @override
  RecentRoomState roomList(List<Room> roomList) => this(roomList: roomList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RecentRoomState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RecentRoomState(...).copyWith(id: 12, name: "My name")
  /// ````
  RecentRoomState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? filterType = const $CopyWithPlaceholder(),
    Object? hasReachedMax = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? pageInfo = const $CopyWithPlaceholder(),
    Object? roomList = const $CopyWithPlaceholder(),
  }) {
    return RecentRoomState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CommonStatus,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      filterType:
          filterType == const $CopyWithPlaceholder() || filterType == null
              ? _value.filterType
              // ignore: cast_nullable_to_non_nullable
              : filterType as FilterType,
      hasReachedMax:
          hasReachedMax == const $CopyWithPlaceholder() || hasReachedMax == null
              ? _value.hasReachedMax
              // ignore: cast_nullable_to_non_nullable
              : hasReachedMax as bool,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderType,
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String?,
      pageInfo: pageInfo == const $CopyWithPlaceholder()
          ? _value.pageInfo
          // ignore: cast_nullable_to_non_nullable
          : pageInfo as PageInfo?,
      roomList: roomList == const $CopyWithPlaceholder() || roomList == null
          ? _value.roomList
          // ignore: cast_nullable_to_non_nullable
          : roomList as List<Room>,
    );
  }
}

extension $RecentRoomStateCopyWith on RecentRoomState {
  /// Returns a callable class that can be used as follows: `instanceOfRecentRoomState.copyWith(...)` or like so:`instanceOfRecentRoomState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RecentRoomStateCWProxy get copyWith => _$RecentRoomStateCWProxyImpl(this);
}

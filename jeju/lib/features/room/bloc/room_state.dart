import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/features/room/widget/reorderable_list_widget.dart';

import '../../../core/core.dart';
import '../widget/edit_reorderable_list_widget.dart';

part 'generated/room_state.g.dart';

@CopyWith()
class RoomState extends CommonState {
  const RoomState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.pageInfo,
    this.room = const Room(),
  });

  final Room room;

  @override
  List<Object?> get props => [...super.props, room];
}

@CopyWith()
class AddRoomState extends RoomState {
  const AddRoomState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.addressStatus = CommonStatus.initial,
    this.document,
    this.documents,
    this.step,
    this.images,
    super.room,
    this.owner,
    this.facilities = const {},
    this.themes = const {},
    this.paths

  });

  final CommonStatus addressStatus;
  final Document? document;
  final List<Document>? documents;
  final String? step;
  final List<XFile>? images;
  final String? owner;
  final Map<String?, List<Facility>?> facilities;
  final Map<String?, List<Facility>?> themes;
  final List<String>? paths;

  @override
  List<Object?> get props => [...super.props, document, documents, step, images, addressStatus, owner, facilities, themes, paths];
}

@CopyWith()
class RoomDetailState extends RoomState {
  const RoomDetailState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.pageInfo,
    this.zoomImage = false,
    this.calenderDate,
    this.dateRange,
    this.showPrice = true,
    super.room,
    this.guestCount = 1,
    this.order,
    this.guestList = const [],
    this.hostProfile,
    this.stopHosting,
    this.plusPriceList,
    this.plusPrice = 0,
    this.normalDay = 0,
    this.specificDay = 0,
    this.report = false
  });

  final bool zoomImage;
  final DateTime? calenderDate;
  final DateRange? dateRange;
  final bool showPrice;
  final int guestCount;
  final List<String> guestList;
  final String? order;
  final Profile? hostProfile;
  final List<DateTime>? stopHosting;
  final List<DateManagement>? plusPriceList;
  final int plusPrice;
  final int normalDay;
  final int specificDay;
  final bool report;


  get dateSelected => dateRange != null;

  @override
  List<Object?> get props => [...super.props, order ,zoomImage, calenderDate, dateRange, showPrice, guestCount, guestList, hostProfile, stopHosting, plusPrice, plusPriceList, normalDay, specificDay, report];
}

@CopyWith()
class RoomManagementState extends RoomState {
  const RoomManagementState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.pageInfo,
    this.addressStatus = CommonStatus.initial,
    this.step,
    super.room,
    this.owner,
    this.facilities = const {},
    this.themes = const {},
    this.images = const [],
    this.rooms = const [],
    this.selectedFacilities = const [],
    this.selectedThemes = const [],
    this.isInitial = true,
  });

  final CommonStatus addressStatus;
  final String? step;
  final String? owner;
  final Map<String?, List<Facility>?> facilities;
  final Map<String?, List<Facility>?> themes;
  final List<FileDTO>? images;

  final List<Room> rooms;
  final List<Facility> selectedFacilities;
  final List<Facility> selectedThemes;
  final bool? isInitial;

  @override
  List<Object?> get props => [...super.props, step, room, addressStatus, owner, facilities, themes, images, rooms, selectedFacilities, selectedThemes, isInitial];
}

@CopyWith()
class RoomListState extends RoomState {
  const RoomListState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.pageInfo,
    this.rooms = const [],
  });

  final List<Room> rooms;


  @override
  List<Object?> get props => [...super.props, query, rooms, ];
}

@CopyWith()
class HostRoomListState extends RoomState {
  const HostRoomListState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.pageInfo,
    this.rooms = const [],
    this.reservations = const [],
    super.room,
  });

  final List<Room> rooms;
  final List<Reservation> reservations;

  @override
  List<Object?> get props => [...super.props, query, rooms, reservations];
}

@CopyWith()
class RecentRoomState extends CommonState {
  const RecentRoomState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    super.pageInfo,
    this.roomList = const <Room>[],
  });

  final List<Room> roomList;

  @override
  List<Object?> get props => [...super.props, roomList];
}
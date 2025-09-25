

import 'package:image_picker/image_picker.dart';
import 'package:jeju_host_app/core/domain/model/reservation_model.dart';

import '../../../core/core.dart';
import '../widget/edit_reorderable_list_widget.dart';
import '../widget/reorderable_list_widget.dart';

class RoomEvent extends CommonEvent {
  const RoomEvent();
}

/// add room events

class SearchAddress extends RoomEvent {
  const SearchAddress({required this.address});

  final String address;
}

class SelectAddress extends RoomEvent {
  const SelectAddress({required this.index});

  final int index;
}

class ReTypeAddress extends RoomEvent {
  const ReTypeAddress();
}

class SaveStep extends RoomEvent {
  const SaveStep({this.step});

  final String? step;
}

class CheckOwner extends RoomEvent {
  const CheckOwner({required this.owner});

  final String? owner;
}

class CheckPermission extends RoomEvent {
  const CheckPermission({required this.source});

  final ImageSource source;
}

class ChangeRoom extends RoomEvent {
  const ChangeRoom({required this.room});

  final Room room;
}

class SelectFacility extends RoomEvent {
  const SelectFacility(this.select, {this.facility, this.theme, this.isInitial});

  final bool select;
  final Facility? facility;
  final Facility? theme;
  final bool? isInitial;
}

class PickImage extends RoomEvent {
  const PickImage({required this.source, this.multiImage = false});

  final ImageSource source;
  final bool multiImage;
}

class Reorder extends RoomEvent {
  const Reorder({required this.images, this.paths});

  final List<XFile> images;
  final List<String>? paths;
}

class Remove extends RoomEvent {
  const Remove({required this.images,this.deleteImageIdList,this.index,this.deleteImage, this.paths});

  final List<XFile> images;
  final XFile? deleteImage;
  final List<int>? deleteImageIdList;
  final int? index;
  final List<String>? paths;
}

class EditReorder extends RoomEvent {
  const EditReorder({required this.images, this.paths});

  final List<FileDTO> images;
  final List<String>? paths;
}

class EditRemove extends RoomEvent {
  const EditRemove({required this.images,this.deleteImageIdList,this.index,this.deleteImage, this.paths});

  final List<FileDTO> images;
  final FileDTO? deleteImage;
  final List<int>? deleteImageIdList;
  final int? index;
  final List<String>? paths;
}

/// room detail events

class ZoomImage extends RoomEvent {
  const ZoomImage(this.zoomImage);

  final bool zoomImage;
}

class ChangeCurrentDate extends RoomEvent {
  const ChangeCurrentDate(this.date);

  final DateTime date;
}

class ChangeDateRange extends RoomEvent {
  const ChangeDateRange(this.dateRange);

  final DateRange? dateRange;
}

class ShowPrice extends RoomEvent {
  const ShowPrice(this.showPrice);

  final bool showPrice;
}
class ChangeGuest extends RoomEvent {
  const ChangeGuest({required this.guestCount});

  final int? guestCount;
}

class CreateOrder extends RoomEvent{
  const CreateOrder();
}

class ShowReport extends RoomEvent {
  const ShowReport(this.report);

  final bool report;
}


/// reservation room events
class OnReservation extends RoomEvent {
  const OnReservation({required this.accommodationId,required this.request,});

  final int? accommodationId;
  final Map<String, dynamic> request;
}

/// management room events

class ChangePickRoom extends RoomEvent {
  const ChangePickRoom({required this.room});

  final Room room;
}

class ChangeTab extends RoomEvent {
  const ChangeTab();

  // final Room room;
}



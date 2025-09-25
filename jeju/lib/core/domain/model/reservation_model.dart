import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/reservation_model.g.dart';

@CopyWith()
@JsonSerializable()
class Reservation {
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "days")
  final int? days;
  @JsonKey(name: "endDate")
  final DateTime? endDate;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "people")
  final int? people;
  @JsonKey(name: "startDate")
  final DateTime? startDate;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "totalAmount")
  final int? totalAmount;
  @JsonKey(name: "memo")
  final String? memo;
  @JsonKey(name: "image")
  final ReservationImage? image;
  @JsonKey(name: "room")
  final Room? room;

  const Reservation({
    this.createdAt,
    this.days,
    this.endDate,
    this.id,
    this.name,
    this.orderNumber,
    this.people,
    this.startDate,
    this.status,
    this.totalAmount,
    this.image,
    this.memo,
    this.room
  });



  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}

@JsonSerializable()
class ReservationImage {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "path")
  final String? path;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "originalFileName")
  final String? originalFileName;

  ReservationImage({
    this.id,
    this.path,
    this.size,
    this.type,
    this.originalFileName,
  });

  factory ReservationImage.fromJson(Map<String, dynamic> json) => _$ReservationImageFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationImageToJson(this);
}


@JsonSerializable()
class ReservationRequest {
  @JsonKey(name: "beforeAmount")
  final int? beforeAmount;
  @JsonKey(name: "endDate")
  final DateTime? endDate;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "people")
  final int? people;
  @JsonKey(name: "startDate")
  final DateTime? startDate;

  ReservationRequest({
    this.beforeAmount,
    this.endDate,
    this.orderNumber,
    this.people,
    this.startDate,
  });

  factory ReservationRequest.fromJson(Map<String, dynamic> json) => _$ReservationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationRequestToJson(this);
}

@JsonSerializable()
class DateManagement {
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "date")
  final DateTime? date;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "isHosting")
  final bool? isHosting;
  @JsonKey(name: "memo")
  final String? memo;

  DateManagement({
    this.amount,
    this.date,
    this.id,
    this.isHosting,
    this.memo,
  });

  factory DateManagement.fromJson(Map<String, dynamic> json) => _$DateManagementFromJson(json);

  Map<String, dynamic> toJson() => _$DateManagementToJson(this);
}

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/profit_model.g.dart';

@CopyWith()
@JsonSerializable()
class Profit {
  @JsonKey(name: "bank")
  final String? bank;
  @JsonKey(name: "account")
  final String? account;
  @JsonKey(name: "possibleAmount")
  final int? possibleAmount;
  @JsonKey(name: "anticipateAmount")
  final int? anticipateAmount;
  @JsonKey(name: "successAmount")
  final int? successAmount;
  @JsonKey(name: "reservationList")
  final List<ReservationList> reservationList;
  @JsonKey(name: "hostCalculateList")
  final List<HostCalculateList> hostCalculateList;

  const Profit({
    this.bank,
    this.account,
    this.possibleAmount,
    this.anticipateAmount,
    this.successAmount,
    this.reservationList = const [],
    this.hostCalculateList = const [],
  });

  factory Profit.fromJson(Map<String, dynamic> json) => _$ProfitFromJson(json);

  Map<String, dynamic> toJson() => _$ProfitToJson(this);
}

@JsonSerializable()
class HostCalculateList {
  @JsonKey(name: "completeAmount")
  final int? completeAmount;
  @JsonKey(name: "completeDate")
  final String? completeDate;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "requestAmount")
  final int? requestAmount;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "statusName")
  final String? statusName;

  HostCalculateList({
    this.completeAmount,
    this.completeDate,
    this.createdAt,
    this.id,
    this.requestAmount,
    this.status,
    this.statusName,
  });

  factory HostCalculateList.fromJson(Map<String, dynamic> json) => _$HostCalculateListFromJson(json);

  Map<String, dynamic> toJson() => _$HostCalculateListToJson(this);
}

@JsonSerializable()
class ReservationList {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "totalAmount")
  final int? totalAmount;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "calculateStatus")
  final String? calculateStatus;
  @JsonKey(name: "beforeAmount")
  final int? beforeAmount;

  ReservationList({
    this.id,
    this.orderNumber,
    this.totalAmount,
    this.createdAt,
    this.calculateStatus,
    this.beforeAmount,
  });

  factory ReservationList.fromJson(Map<String, dynamic> json) => _$ReservationListFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationListToJson(this);
}

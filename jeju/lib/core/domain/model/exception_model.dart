import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/exception_model.g.dart';

@JsonSerializable()
class ExceptionModel extends Equatable {
  final bool? success;
  final int? status;
  final String? message;
  final String? errorCode;

  bool? get exceptionSuccess => success;

  int? get exceptionStatusCode => status;

  String? get exceptionMessage => message;

  String? get exceptionErrorCode => errorCode;

  const ExceptionModel(this.success, {this.status, this.message, this.errorCode});

  factory ExceptionModel.fromJson(Map<String, dynamic> json) => _$ExceptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExceptionModelToJson(this);

  @override
  List<Object?> get props => [success, status, message, errorCode];
}

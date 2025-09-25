import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/exception_model.g.dart';

@JsonSerializable()
class ExceptionModel extends Equatable {
  final bool? success;
  final int? result;
  final String? resultMsg;
  final String? resultCode;

  bool? get exceptionSuccess => success;

  int? get exceptionStatusCode => result;

  String? get exceptionMessage => resultMsg;

  String? get exceptionErrorCode => resultCode;

  const ExceptionModel(this.success,
      {this.result, this.resultMsg, this.resultCode});

  factory ExceptionModel.fromJson(Map<String, dynamic> json) =>
      _$ExceptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExceptionModelToJson(this);

  @override
  List<Object?> get props => [success, result, resultMsg, resultCode];
}

part of 'alert_bloc.dart';

class AlertState extends Equatable {
  const AlertState(
      {required this.status,
      this.name,
      this.alert = const [],
      this.meta,
      this.errorMessage,
      this.hasReachedMax = false});

  final String? name;
  final CommonStatus status;
  final List<Alert> alert;
  final Meta? meta;
  final String? errorMessage;
  final bool hasReachedMax;

  AlertState copyWith({
    String? name,
    CommonStatus? status,
    List<Alert>? alert,
    Meta? meta,
    String? errorMessage,
    bool? hasReachedMax,
    int? page,
    int? count,
  }) {
    return AlertState(
        name: name ?? this.name,
        status: status ?? this.status,
        alert: alert ?? this.alert,
        meta: meta ?? this.meta,
        errorMessage: errorMessage ?? this.errorMessage,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object?> get props =>
      [name, status, alert, meta, errorMessage, hasReachedMax];
}

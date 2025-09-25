part of 'alert_bloc.dart';

abstract class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object> get props => [];
}

class Initial extends AlertEvent {
  const Initial();
}

class Show extends AlertEvent {
  const Show(this.id);

  final String id;
}

class ListFetched extends AlertEvent {
  const ListFetched();
}

import '../../../core/core.dart';

class AlertEvent extends CommonEvent {
  const AlertEvent();
}

class ChangeAlert extends AlertEvent {
  const ChangeAlert({required this.type,required this.value});
  final String type;
  final bool value;
}


import '../../../core/core.dart';

class QuestionEvent extends CommonEvent {
  const QuestionEvent();
}

class ChangeValue extends QuestionEvent {
  const ChangeValue({required this.value, required this.type});
  final String type;
  final String value;
}




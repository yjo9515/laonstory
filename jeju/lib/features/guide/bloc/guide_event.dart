part of 'guide_bloc.dart';

class GuideEvent extends CommonEvent {
  const GuideEvent();
}

class Agree extends GuideEvent {
  const Agree({required this.agree});

  final bool agree;
}

class RegisterHost extends GuideEvent {
  const RegisterHost();
}

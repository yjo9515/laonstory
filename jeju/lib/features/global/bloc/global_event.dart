part of 'global_bloc.dart';

class GlobalEvent extends CommonEvent {
  const GlobalEvent();
}

class SetData extends GlobalEvent {
  const SetData();
}

class Logout extends GlobalEvent {
  const Logout();
}

class SwitchHost extends GlobalEvent {
  const SwitchHost(this.hostStatus);

  final UserType hostStatus;
}

class GetUserInfo extends GlobalEvent {
  const GetUserInfo();
}

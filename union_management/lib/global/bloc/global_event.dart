part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object?> get props => [];
}

class InitialConfig extends GlobalEvent {
  const InitialConfig();
}

class InitialToken extends GlobalEvent {
  const InitialToken(this.context);

  final BuildContext context;
}

class SetToken extends GlobalEvent {
  const SetToken();
}

class SetProfile extends GlobalEvent {
  const SetProfile();
}

class Logout extends GlobalEvent {
  const Logout();
}


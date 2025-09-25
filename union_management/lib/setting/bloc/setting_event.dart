part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class InitialSetting extends SettingEvent {
  const InitialSetting();
}

class ChangePermission extends SettingEvent {
  const ChangePermission(this.permission, this.enabled);

  final Permission permission;
  final bool enabled;
}

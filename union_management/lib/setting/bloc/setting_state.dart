part of 'setting_bloc.dart';

class SettingState extends Equatable {
  const SettingState({this.permissionNotification, this.permissionCamera, this.permissionPhotos});

  final PermissionStatus? permissionNotification;
  final PermissionStatus? permissionCamera;
  final PermissionStatus? permissionPhotos;

  SettingState copyWith({PermissionStatus? permissionNotification, PermissionStatus? permissionCamera, PermissionStatus? permissionPhotos}) {
    return SettingState(
      permissionNotification: permissionNotification ?? this.permissionNotification,
      permissionCamera: permissionCamera ?? this.permissionCamera,
      permissionPhotos: permissionPhotos ?? this.permissionPhotos,
    );
  }

  @override
  List<Object?> get props => [permissionNotification, permissionCamera, permissionPhotos];
}

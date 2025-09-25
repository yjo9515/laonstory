import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<InitialSetting>(_onInitialSetting);
    on<ChangePermission>(_onChangePermission);
  }

  _onInitialSetting(InitialSetting event, Emitter<SettingState> emit) async {
    var notificationStatus = await Permission.notification.status;
    var cameraStatus = await Permission.camera.status;
    var photosStatus = await Permission.photos.status;
    emit(state.copyWith(
      permissionNotification: notificationStatus,
      permissionCamera: cameraStatus,
      permissionPhotos: photosStatus,
    ));
  }

  _onChangePermission(ChangePermission event, Emitter<SettingState> emit) async {
    if (event.permission == Permission.notification) {
      // var notificationStatus = event.enabled ? await requestNotificationPermission(AppConfig.to.messaging) : PermissionStatus.denied;
      // emit(state.copyWith(permissionNotification: notificationStatus));
      return;
    }
    if ((await event.permission.isGranted && !event.enabled) || await event.permission.isPermanentlyDenied) await openAppSettings();
    await event.permission.request();
    var notificationStatus = await Permission.notification.status;
    var cameraStatus = await Permission.camera.status;
    var photosStatus = await Permission.photos.status;
    emit(state.copyWith(
      permissionNotification: notificationStatus,
      permissionCamera: cameraStatus,
      permissionPhotos: photosStatus,
    ));
  }

  Future<PermissionStatus> requestNotificationPermission(FirebaseMessaging messaging) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return PermissionStatus.granted;
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      await openAppSettings();
      return PermissionStatus.denied;
    } else {
      return PermissionStatus.denied;
    }
  }
}

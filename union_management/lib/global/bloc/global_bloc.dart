import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_management/common/util/logger.dart';

import '../../common/enum/enums.dart';
import '../../common/model/secure_model.dart';
import '../model/profile_model.dart';
import '../model/response_user_model.dart';
import '../repository/global_repository.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState(secureModel: SecureModel(tokenData: TokenData()))) {
    on<InitialConfig>(_onInitialConfig);
    on<InitialToken>(_onInitialToken);
    on<SetToken>(_onSetToken);
    on<Logout>(_onLogout);
  }

  _onInitialConfig(InitialConfig event, Emitter<GlobalState> emit) async {
    var prefs = await SharedPreferences.getInstance();
    var version = prefs.getString('app_version');

    emit(state.copyWith(appConfig: AppConfig(version: version), secureModel: SecureModel(tokenData: TokenData())));
  }

  _onInitialToken(InitialToken event, Emitter<GlobalState> emit) async {
    try {
      const secureStorage = FlutterSecureStorage();
      var secureString = await secureStorage.read(key: 'secureInfo');
      var fcmToken = await secureStorage.read(key: 'fcmToken');
      var deviceId = await secureStorage.read(key: 'deviceId');
      if (fcmToken == null || kIsWeb) fcmToken = await setWebFcmToken(emit);
      if (secureString != null) {
        /// fcmToken, deviceId 최신화
        var secureModel = SecureModel.fromJson(jsonDecode(secureString));
        secureModel.tokenData.fcmToken = fcmToken;
        secureModel.tokenData.deviceId = deviceId ?? "";
        emit(state.copyWith(secureModel: secureModel));
      } else {
        /// secureData 없을 시 초기화
        await initialSecureStorage(emit);
        return;
      }
      if (state.secureModel.tokenData.accessToken.isEmpty) {
        await initialSecureStorage(emit);
        return;
      }

      var result = StatusCode.forbidden;

      switch (state.secureModel.loginStatus) {
        case LoginStatus.login:
          result = await GlobalRepository.to.checkDataToken();
          break;
        case LoginStatus.logout:
          await initialSecureStorage(emit);
          return;
      }

      switch (result) {
        case StatusCode.success:
          await setFcmToken(fcmToken);
          await getUserInfo(emit);
          return;
        case StatusCode.unAuthorized:
          await setToken(emit);
          break;
        case StatusCode.badRequest:
        case StatusCode.notFound:
        case StatusCode.timeout:
        case StatusCode.forbidden:
          await getUserInfo(emit);
          break;
        case StatusCode.error:
          await initialSecureStorage(emit);
          return;
      }
    } catch (e) {
      await initialSecureStorage(emit);
      return;
    }
  }

  _onSetToken(SetToken event, Emitter<GlobalState> emit) async {
    const secureStorage = FlutterSecureStorage();
    var fcmToken = await secureStorage.read(key: 'fcmToken');
    var secureString = await secureStorage.read(key: 'secureInfo');
    if (secureString != null) {
      var secureModel = SecureModel.fromJson(jsonDecode(secureString));
      if (fcmToken?.isNotEmpty ?? false) await GlobalRepository.to.setFcmToken(fcmToken);
      emit(state.copyWith(tokenStatus: TokenStatus.hasToken, secureModel: secureModel));
      await getUserInfo(emit);
    } else {
      await initialSecureStorage(emit);
    }
  }

  _onLogout(Logout event, Emitter<GlobalState> emit) async {
    await initialSecureStorage(emit);
  }

  setToken(Emitter<GlobalState> emit) async {
    const secureStorage = FlutterSecureStorage();

    var fcmToken = await secureStorage.read(key: 'fcmToken');
    var deviceId = await secureStorage.read(key: 'deviceId') ?? "";

    if (fcmToken == null || kIsWeb) fcmToken = await setWebFcmToken(emit);

    var result = await GlobalRepository.to.refreshToken();
    if (result.$1 == StatusCode.success) {
      var responseUserModel = ResponseUserModel.fromJson(result.$2);
      logger.d(responseUserModel.data?.accessToken);
      var accessToken = responseUserModel.data?.accessToken;
      var refreshToken = responseUserModel.data?.refreshToken;
      if (accessToken != null && refreshToken != null) {
        var secureModel = SecureModel(
          loginStatus: LoginStatus.login,
          tokenData: TokenData(
            fcmToken: fcmToken,
            deviceId: deviceId,
            accessToken: accessToken,
            refreshToken: refreshToken,
          ),
        );
        await secureStorage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));
        // await setFcmToken(fcmToken);
        emit(state.copyWith(tokenStatus: TokenStatus.hasToken, secureModel: secureModel));
      } else {
        await initialSecureStorage(emit);
      }
    } else {
      await initialSecureStorage(emit);
    }
  }

  initialSecureStorage(Emitter<GlobalState> emit) async {
    const secureStorage = FlutterSecureStorage();
    var fcmToken = await secureStorage.read(key: 'fcmToken') ?? "";
    var deviceId = await secureStorage.read(key: 'deviceId') ?? "";
    var secureModel = SecureModel(tokenData: TokenData());
    secureModel.tokenData.accessToken = '';
    secureModel.tokenData.fcmToken = fcmToken;
    secureModel.tokenData.deviceId = deviceId;
    secureModel.loginStatus = LoginStatus.logout;
    await secureStorage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));
    logger.d(jsonEncode(secureModel.toJson()));
    emit(state.copyWith(secureModel: secureModel, tokenStatus: TokenStatus.noToken, profileModel: ProfileModel(data: Profile(role: 'ROLE_GUEST', name: ""))));
  }

  setFcmToken(String fcmToken) async {
    if (fcmToken.isNotEmpty) await GlobalRepository.to.setFcmToken(fcmToken);
  }

  Future<String> setWebFcmToken(Emitter<GlobalState> emit) async {
    try {
      /// 모바일 웹으로 접속 시 fcmToken 을 발급받지 못함
      const secureStorage = FlutterSecureStorage();
      var deviceId = await secureStorage.read(key: 'deviceId') ?? "";
      var encode = base64.encode(utf8.encode(deviceId));
      await secureStorage.write(key: 'fcmToken', value: encode);
      return encode;
    } catch (e) {
      await initialSecureStorage(emit);
      throw "error";
    }
  }

  getUserInfo(Emitter<GlobalState> emit) async {
    var profile = await GlobalRepository.to.getUserInfo();
    emit(state.copyWith(profileModel: profile, tokenStatus: TokenStatus.hasToken));
  }
}

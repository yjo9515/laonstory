import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:jeju_host_app/core/usecases/mypage_usecase.dart';

import '../../../core/core.dart';
import '../../../core/usecases/room_usecase.dart';
import '../../../main.dart';
import '../repository/global_repository.dart';

part 'generated/global_bloc.g.dart';
part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<CommonEvent, GlobalState> {
  GlobalBloc() : super(GlobalState(tokenStatus: TokenStatus.initial, secureModel: SecureModel(tokenData: TokenData()))) {
    on<Initial>(_onInitial);
    on<Logout>(_onLogout);
    on<SetData>(_onSetData);
    on<SwitchHost>(_onSwitchHost);
    on<GetUserInfo>(_onGetUserInfo);
  }

  _onInitial(Initial event, Emitter<GlobalState> emit) async {
    try {
      emit(state.copyWith(status: CommonStatus.initial));
      var version = AppConfig.to.shared.getString('app_version');
      var secureString = await AppConfig.to.storage.read(key: 'secureInfo');
      var secureModel = SecureModel.fromJson(jsonDecode(secureString ?? ''));
      emit(state.copyWith(appData: AppData(version: version), secureModel: SecureModel(tokenData: secureModel.tokenData, loginStatus: secureModel.loginStatus, hostStatus: secureModel.hostStatus)));
      var fcmToken = await AppConfig.to.storage.read(key: 'fcmToken');
      var deviceId = await AppConfig.to.storage.read(key: 'deviceId');
      if (secureString != null && state.secureModel.tokenData.authToken.isNotEmpty && state.secureModel.loginStatus == LoginStatus.login) {
        /// fcmToken, deviceId 최신화
        secureModel.tokenData.fcmToken = fcmToken ?? '';
        secureModel.tokenData.deviceId = deviceId ?? '';
        emit(state.copyWith(secureModel: secureModel));
      } else {
        /// secureData 없거나 token이 없을 시 초기화
        throw const NotFoundException(message: 'none SecureData');
      }
      // await RoomUseCase.to.getHostRoomList().then((value) {
      //   emit(state.copyWith(rooms: value?.data?.items ?? [], pageInfo: value?.pageInfo));
      //   if (state.rooms.isNotEmpty) {
      //     add(ChangePickRoom(room: value?.data?.items?.first ?? const Room()));
      //   }
      // });
      switch (state.secureModel.loginStatus) {
        case LoginStatus.login:
          await _setToken(emit);
          return;
        case LoginStatus.logout:
          await _initialSecureStorage(emit);
          return;
      }


    } catch (e) {
      await _initialSecureStorage(emit);
      return;
    }
  }

  _onLogout(Logout event, Emitter<GlobalState> emit) async {
    logger.d('로그아웃');
    await _initialSecureStorage(emit);
  }

  _setToken(Emitter<GlobalState> emit) async {
    var fcmToken = await AppConfig.to.storage.read(key: 'fcmToken') ?? '';
    var deviceId = await AppConfig.to.storage.read(key: 'deviceId') ?? '';
    await GlobalRepository.to.refreshToken().then((value) async {
      var loginInfo = Model<LoginInfo>.fromJson(value.$2);
      var authToken = loginInfo.data?.authToken;
      var refreshToken = loginInfo.data?.refreshToken;
      if (authToken == null || refreshToken == null) {
        throw const NotFoundException(message: 'setToken Error');
      }

      var secureString = await AppConfig.to.storage.read(key: 'secureInfo');
      var secureModel = SecureModel.fromJson(jsonDecode(secureString ?? ''));
      secureModel.tokenData = TokenData(
        fcmToken: fcmToken,
        deviceId: deviceId,
        authToken: authToken,
        refreshToken: refreshToken,
      );
      await AppConfig.to.storage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));

      emit(state.copyWith(tokenStatus: TokenStatus.hasToken, secureModel: secureModel));
      add(GetUserInfo());
    }).catchError((error) async {
      return await _initialSecureStorage(emit);
    });
  }

  _initialSecureStorage(Emitter<GlobalState> emit) async {
    var fcmToken = await AppConfig.to.storage.read(key: 'fcmToken') ?? "";
    var deviceId = await AppConfig.to.storage.read(key: 'deviceId') ?? "";
    var secureModel = SecureModel(
      tokenData: TokenData(
        fcmToken: fcmToken,
        deviceId: deviceId,
      ),
      loginStatus: LoginStatus.logout,
    );
    AppConfig.to.secureModel = secureModel;
    await AppConfig.to.storage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));
    emit(state.copyWith(secureModel: secureModel, tokenStatus: TokenStatus.noToken));
  }

  _onGetUserInfo(GetUserInfo event, Emitter<GlobalState> emit) async {
    await MypageUsecase.to.getProfile(userType: state.secureModel.hostStatus).then((value) => emit(state.copyWith(profile: value?.data)));
  }

  _onSwitchHost(SwitchHost event, Emitter<GlobalState> emit) async {
    // try {
    //   var secureString = await AppConfig.to.storage.read(key: 'secureInfo');
    //   var secureModel = SecureModel.fromJson(jsonDecode(secureString ?? ''))..hostStatus = event.hostStatus;
    //   await AppConfig.to.storage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));
    //   emit(state.copyWith(secureModel: secureModel));
    // } catch (e) {
    //   logger.e(e);
    //   emit(state.copyWith(secureModel: SecureModel(tokenData: TokenData(), loginStatus: LoginStatus.logout, hostStatus: UserType.guest)));
    // }
    // if(state.secureModel.hostStatus == UserType.host) {
    //
    // }
    if(event.hostStatus == UserType.host){
      await MypageUsecase.to.getProfile(userType:UserType.host).then((value){
        emit(state.copyWith(profile: value?.data,secureModel: SecureModel(hostStatus: UserType.host, tokenData: TokenData(), loginStatus: LoginStatus.login)));
      }).catchError((e){
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString(),secureModel: SecureModel(hostStatus: UserType.guest, tokenData: TokenData(), loginStatus: LoginStatus.login)));
      });


    }else{
      await MypageUsecase.to.getProfile(userType:UserType.guest).then((value){
        emit(state.copyWith(profile: value?.data,secureModel: SecureModel(hostStatus: UserType.guest, tokenData: TokenData(),loginStatus: LoginStatus.login)));
      } )
          .catchError((e){
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString(),secureModel: SecureModel(hostStatus: UserType.host, tokenData: TokenData(), loginStatus: LoginStatus.login)));
      });
    }

  }

  _onSetData(SetData event, Emitter<GlobalState> emit) async {
    try {
      await AppConfig.to.storage.write(key: 'secureInfo', value: jsonEncode(AppConfig.to.secureModel.toJson()));
      emit(state.copyWith(secureModel: AppConfig.to.secureModel));
    } catch (e) {
      emit(state.copyWith(secureModel: SecureModel(tokenData: TokenData(), loginStatus: LoginStatus.logout, hostStatus: UserType.guest)));
    }
  }
}

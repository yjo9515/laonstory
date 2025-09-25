import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/enum/enums.dart';
import '../../../common/util/logger.dart';
import '../../../env/env.dart';
import '../model/response_login_model.dart';
import '../repository/admin_login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState(status: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<Login>(_onLogin);
  }

  Future<FutureOr<void>> _onInitial(Initial event, Emitter<LoginState> emit) async {
    // const secureStorage = FlutterSecureStorage();
    // await secureStorage.delete(key: 'accessToken');
    // await secureStorage.delete(key: 'refreshToken');
  }

  Future<FutureOr<void>> _onLogin(Login event, Emitter<LoginState> emit) async {
    try {
      final key = Key.fromUtf8(Env.pwPrivateKey);
      final iv = IV.fromUtf8(Env.pwPrivateIv);
      final encryptedData = Encrypter(AES(key, mode: AESMode.cbc)).encrypt(event.pw, iv: iv);
      var result = await AdminLoginRepository.to.login(event.id, encryptedData.base64);
      if (result.$1) {
        var loginModel = ResponseLoginModel.fromJson(result.$2);
        var prefs = await SharedPreferences.getInstance();
        final tokenKey = Key.fromUtf8(Env.tokenPrivateKey);
        final tokenIv = IV.fromUtf8(Env.tokenPrivateIv);
        final accessToken = Encrypter(AES(tokenKey, mode: AESMode.cbc)).encrypt(loginModel.data?.accessToken ?? "", iv: tokenIv);
        await prefs.setString('accessToken', accessToken.base64);
        final refreshToken = Encrypter(AES(tokenKey, mode: AESMode.cbc)).encrypt(loginModel.data?.refreshToken ?? "", iv: tokenIv);
        await prefs.setString('refreshToken', refreshToken.base64);
        emit(state.copyWith(status: CommonStatus.success));
      } else {
        emit(state.copyWith(status: CommonStatus.initial));
        emit(state.copyWith(status: CommonStatus.failure, message: result.$2));
      }
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(status: CommonStatus.initial));
      emit(state.copyWith(status: CommonStatus.failure, message: "오류가 발생하였습니다. 다시 시도해주세요\n$e"));
    }
  }
}

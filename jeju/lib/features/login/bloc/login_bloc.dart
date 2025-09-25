import 'dart:async';
import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/core.dart';
import '../../../main.dart';
import '../../global/bloc/global_bloc.dart';
import '../repository/login_repository.dart';

part 'generated/login_bloc.g.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<CommonEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<Initial>(_onInitial);
    on<Login>(_onLogin);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<LoginState> emit) async {
    await Future.delayed(const Duration(seconds: 1)).then((_) => emit(state.copyWith(status: CommonStatus.ready)));
  }

  _onLogin(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading));
    try {
      var status = switch (event.method) {
        LoginMethod.kakao => await _kakao(),
        LoginMethod.naver => await _naver(),
        LoginMethod.google => await _google(),
        LoginMethod.apple => await _apple(),
      };
      emit(state.copyWith(status: status?.$1));
      BlocProvider.of<GlobalBloc>(navigatorKey.currentContext!).add(const SetData());
    } on ServiceException catch (e) {
      add(Error(e));
    }
  }

  Future<Model<LoginInfo>?> _login(String? authToken, String? email, {String? userId, required LoginMethod loginMethod}) async {
    try {
      var fcmToken = await AppConfig.to.storage.read(key: 'fcmToken');
      var deviceId = await AppConfig.to.storage.read(key: 'deviceId');
      final userModel = await LoginRepository.to.login(authToken, email, userId: userId, fcmToken: fcmToken, deviceId: deviceId, loginMethod: loginMethod);
      var secureModel = SecureModel(
        loginStatus: LoginStatus.login,
        hostStatus: UserType.guest,
        tokenData: TokenData(
          fcmToken: fcmToken ?? '',
          deviceId: deviceId ?? '',
          authToken: userModel.data?.authToken ?? '',
          refreshToken: userModel.data?.refreshToken ?? '',
        ),
      );
      AppConfig.to.secureModel = secureModel;
      await AppConfig.to.storage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));
      return userModel;
    // } on Exception {
    //   rethrow;
    // }
    } on ExceptionModel catch (e) {
      add(Error(LogicalException(code:e.errorCode ,message: e.message)));
    }
  }

  /// kakao Logic

  Future<(CommonStatus, String?)> _kakao() async {
    final installed = await isKakaoTalkInstalled();
    // final keyHash = Utility.getKeyHash(this)

    final result = installed ? await _loginWithTalk() : await _loginWithKakao();
    try {
      final tokenStatus = await LoginRepository.to.setUserToken(result?.data?.authToken, result?.data?.refreshToken);
      if (tokenStatus) {
        return (CommonStatus.success, '');
      } else {
        return (CommonStatus.failure, result?.message);
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Model<LoginInfo>?> _loginWithKakao() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount().catchError((error) {
        throw 'kakao error : ${error}';
      });
      return await _isUseAuthToken(token);
    } on LogicalException {
      rethrow;
    }
  }

  Future<Model<LoginInfo>?> _loginWithTalk() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk().catchError((error) {
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: error.toString()));
        throw 'kakao error : ${error}';
      });
      return await _isUseAuthToken(token);
    } on ServiceException catch (model, e) {
      logger.d(e);
      if (e.toString() == "PlatformException(NotSupportError, KakaoTalk is installed but not connected to Kakao account., null, null)") {
        return _loginWithKakao();
      }
      rethrow;
    }
  }

  Future<Model<LoginInfo>?> _isUseAuthToken(OAuthToken token) async {
    try {
      TokenManagerProvider.instance.manager.setToken(token);
      final user = await UserApi.instance.me();
      await UserApi.instance.accessTokenInfo();
      return await _login(token.accessToken, user.kakaoAccount?.email ?? '', userId: user.id.toString(), loginMethod: LoginMethod.kakao);
    } on Exception {
      rethrow;
    }
  }

  /// naver logic

  Future<(CommonStatus, String?)> _naver() async {
    return await FlutterNaverLogin.logIn().then((value) async {
      try {
        final authToken = value.accessToken.accessToken;
        final email = value.account.email;
        final result = await _login(authToken, email, userId: value.account.id, loginMethod: LoginMethod.naver);
        final tokenStatus = await LoginRepository.to.setUserToken(result?.data?.authToken, result?.data?.refreshToken);
        if (tokenStatus) {
          return (CommonStatus.success, '');
        } else {
          return (CommonStatus.failure, result?.message);
        }
      } on Exception {
        rethrow;
      }
    });
  }

  /// google logic

  Future<(CommonStatus, String?)?> _google() async {
    final google = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    final data = await google.signIn();
    return await google.currentUser?.authentication.then((value) async {
      try {
        final result = await _login(value.accessToken, data?.email, userId: data?.id, loginMethod: LoginMethod.google);
        final tokenStatus = await LoginRepository.to.setUserToken(result?.data?.authToken, result?.data?.refreshToken);
        if (tokenStatus) {
          return (CommonStatus.success, '');
        } else {
          return (CommonStatus.failure, result?.message);
        }
      } on Exception {
        rethrow;
      }
    });
  }

  /// apple logic

  Future<(CommonStatus, String?)> _apple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
      ],
    ).catchError((error) {
      throw (CommonStatus.failure, 'error');
    });
    var email = credential.email;

    if (credential.email == null) {
      List<String> jwt = credential.identityToken?.split('.') ?? [];
      String payload = jwt[1];
      payload = base64.normalize(payload);
      final List<int> jsonData = base64.decode(payload);
      final userInfo = jsonDecode(utf8.decode(jsonData));
      email = userInfo['email'];
    }
    try {
      final result = await _login(credential.identityToken, email, userId: credential.userIdentifier, loginMethod: LoginMethod.apple);
      final tokenStatus = await LoginRepository.to.setUserToken(result?.data?.authToken, result?.data?.refreshToken);
      if (tokenStatus) {
        return (CommonStatus.success, '');
      } else {
        return (CommonStatus.failure, result?.message);
      }
    } on Exception {
      rethrow;
    }
  }

  _onError(Error event, Emitter<LoginState> emit) {
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }
}

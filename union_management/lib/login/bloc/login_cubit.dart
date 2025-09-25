import 'package:bloc/bloc.dart';
import 'package:encrypt/encrypt.dart';
import 'package:union_management/common/model/secure_model.dart';
import 'package:union_management/common/util/static_logic.dart';

import '../../common/bloc/common_state.dart';
import '../../common/enum/enums.dart';
import '../../env/env.dart';
import '../repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login(String id, String pw) async {
    final key = Key.fromUtf8(Env.pwPrivateKey);
    final iv = IV.fromUtf8(Env.pwPrivateIv);
    final encryptedPassword = Encrypter(AES(key, mode: AESMode.cbc)).encrypt(pw, iv: iv);
    await LoginRepository.to
        .login(encryptData(id), encryptedPassword.base64)
        .then((userModel) async => {
              await LoginRepository.to.setUserToken(userModel.data?.accessToken, userModel.data?.refreshToken, false).then(
                    (data) => emit(state.loginWith(status: CommonStatus.success, secureModel: data)),
                  )
            })
        .catchError((e) => {
              emit(state.loginWith(status: CommonStatus.failure, message: e)),
              emit(state.loginWith(status: CommonStatus.initial)),
            });
  }
}

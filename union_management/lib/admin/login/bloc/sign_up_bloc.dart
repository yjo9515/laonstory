import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../common/enum/enums.dart';
import '../model/create_admin_model.dart';
import '../repository/admin_login_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState(status: SignUpStatus.initial)) {
    on<Initial>(_onInitial);
    on<Oauth>(_onOauth);
    on<CheckEmail>(_onCheckEmail);
    on<GetBrand>(_onGetBrand);
    on<Upload>(_onUpload);
    on<Pick>(_onPick);
    on<SignUp>(_onSignUp);
  }

  Future<FutureOr<void>> _onInitial(Initial event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(page: 1));
  }

  FutureOr<void> _onOauth(Oauth event, Emitter<SignUpState> emit) {
    AdminLoginRepository.to.emailAuth(event.email);
    if (event.resend ?? false) {
      emit(state.copyWith(status: SignUpStatus.initial));
    }
    emit(state.copyWith(status: SignUpStatus.oauth));
  }

  Future<FutureOr<void>> _onCheckEmail(CheckEmail event, Emitter<SignUpState> emit) async {
    var result = await AdminLoginRepository.to.checkEmail(event.email, event.code);
    if (result.$1) {
      emit(state.copyWith(status: SignUpStatus.oauthSuccess, isEmailDone: true));
    } else {
      emit(state.copyWith(status: SignUpStatus.initial, message: "${result.$2}"));
      emit(state.copyWith(status: SignUpStatus.failure, message: "${result.$2}"));
    }
  }

  Future<FutureOr<void>> _onGetBrand(GetBrand event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(page: event.page));
  }

  Future<FutureOr<void>> _onUpload(Upload event, Emitter<SignUpState> emit) async {
    var file = await event.file;
    emit(state.copyWith(file: file));
  }

  FutureOr<void> _onPick(Pick event, Emitter<SignUpState> emit) {}

  FutureOr<void> _onSignUp(SignUp event, Emitter<SignUpState> emit) async {
    try {
      var bytes = await state.file?.readStream?.first ?? [];
      final result = await AdminLoginRepository.to.signUp(event.createAdminModel, bytes);
      if (result.$1) {
        emit(state.copyWith(status: SignUpStatus.success));
      } else {
        emit(state.copyWith(status: SignUpStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: SignUpStatus.failure));
    }
  }
}

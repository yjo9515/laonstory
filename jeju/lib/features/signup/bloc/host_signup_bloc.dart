import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/core.dart';
import '../repository/host_signup_repository.dart';
import 'host_signup_state.dart';
part 'host_signup_event.dart';


class HostSignUpBloc extends Bloc<CommonEvent, HostSignUpState> {
  HostSignUpBloc() : super(const HostSignUpState()) {
    on<HostSignUpEvent>(_onHostSignUpEvent);
    on<Initial>(_onInitial);
    on<Error>(_onError);
    on<SearchFile>(_onSearchFile);
    on<Remove>(_onRemoveFile);
    on<ChangeHostSignUp>(_onChangeHostSignUp);
    on<SecondHostSignUp>(_onSecondHostSignUpEvent);
    on<Auth>(_onAuth);
  }

  _onInitial(Initial event, Emitter<HostSignUpState> emit) async {

  }
  _onChangeHostSignUp(ChangeHostSignUp event, Emitter<HostSignUpState> emit) {
    emit(state.copyWith(status: CommonStatus.loading));
    emit(state.copyWith(dto: event.dto));
  }

  _onSecondHostSignUpEvent(SecondHostSignUp event, Emitter<HostSignUpState> emit) async{
    // emit(state.copyWith(dto: event.dto));
    logger.d('전송');
    await HostSignUpRepository.to.secondSignupHost(state.dto,state.businessLicense).then((value) => emit(state.copyWith(status: CommonStatus.success))).catchError((e) => add(Error(e)));
  }

  _onAuth(Auth event, Emitter<HostSignUpState> emit) async {
    await HostSignUpRepository.to.authHost(event).then((value) => emit(state.copyWith(status: CommonStatus.success))).catchError((e) => add(Error(e)));
  }

  _onHostSignUpEvent(HostSignUpEvent event, Emitter<HostSignUpState> emit) async {
    await HostSignUpRepository.to.signupHost().then((value) => emit(state.copyWith(status: CommonStatus.success))).catchError((e) => add(Error(e)));
  }


  _onError(Error event, Emitter<HostSignUpState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }

  _onSearchFile(SearchFile event, Emitter<HostSignUpState> emit) async {
    try {
      emit(state.copyWith(status: CommonStatus.loading));
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.any
      );
      List<File> files;
      List<String> fileName = [];
        fileName?.add(result!.files.single.name) ;
          files = result?.paths.map((path) => File(path!)).toList() ?? [];
        print(fileName?.length);
       emit(state.copyWith(status: CommonStatus.initial,businessLicense: files,fileName:fileName));
    } catch (e) {
      add(const Error(LogicalException(message: '파일 선택 오류가 발생했습니다.')));
    }}

  _onRemoveFile(Remove event, Emitter<HostSignUpState> emit){
    emit(state.copyWith(status: CommonStatus.loading));
    state.businessLicense?.clear();
    state.fileName.clear();
    emit(state.copyWith(fileName: event.fileName,businessLicense: event.files ));
  }
}



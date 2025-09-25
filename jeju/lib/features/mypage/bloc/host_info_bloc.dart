import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jeju_host_app/features/mypage/repository/host_repository.dart';

import '../../../core/core.dart';
import '../../signup/repository/host_signup_repository.dart';
import 'host_info_state.dart';

part 'host_info_event.dart';

class HostInfoBloc extends Bloc<CommonEvent, HostInfoState> {
  HostInfoBloc() : super(const HostInfoState()) {
    on<Initial>(_onInitial);
    on<SearchFile>(_onSearchFile);
    on<Error>(_onError);
    on<SecondHostSignUp>(_onSecondHostSignUp);
    on<ChangeHostSignUp>(_onChangeHostSignUp);
    on<Remove>(_onRemove);
  }

  _onInitial(Initial event, Emitter<HostInfoState> emit) async {

    await HostRepository.to.getData().then((value) {
      emit(state.copyWith(dto: Dto.fromJson(value['data']),licenseData: value['data']['businessLicense'] ,status: CommonStatus.success,));
        logger.d(value['data']);}

    );

  }

  _onChangeHostSignUp(ChangeHostSignUp event, Emitter<HostInfoState> emit) {
    emit(state.copyWith(dto:event.dto ,status: CommonStatus.loading));
  }

  _onSearchFile(SearchFile event, Emitter<HostInfoState> emit) async {
    try {
      // emit(state.copyWith(status: CommonStatus.loading));
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

  _onError(Error event, Emitter<HostInfoState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }

  _onSecondHostSignUp(SecondHostSignUp event, Emitter<HostInfoState> emit) async{
    await HostSignUpRepository.to.secondSignupHost(state.dto,state.businessLicense).then((value) => emit(state.copyWith(status: CommonStatus.ready))).catchError((e){
      add(Error(e));
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });

  }

  _onRemove(Remove event, Emitter<HostInfoState> emit) {
    emit(state.copyWith(status: CommonStatus.loading));
    state.businessLicense?.clear();
    state.fileName.clear();
    emit(state.copyWith(fileName: event.fileName,businessLicense: event.files ));
  }

}

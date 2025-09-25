import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/setting/repository/edit_info_repository.dart';

import '../../../core/core.dart';
import 'edit_info_state.dart';

part 'edit_info_event.dart';

class EditInfoBloc extends Bloc<CommonEvent, EditInfoState> {
  EditInfoBloc() : super(EditInfoState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
    on<ChangeInfo>(_onChangeInfo);
    on<SendEmail>(_onSendEmail);
    on<ConfirmEmail>(_onConfirmEmail);
    on<ConfirmPhone>(_onConfirmPhone);
  }

  _onInitial(Initial event, Emitter<EditInfoState> emit) async {
    // await EditInfoRepository.to.getUserInfo().then((value){
    //   logger.d(value.profile);
    //   emit(state.copyWith(profile: value, status: CommonStatus.success));}).catchError((e) {
    //     logger.d(e);
    //   // add(Error(e));
    // });
    try{
      emit(state.copyWith(profile: event.data, status: CommonStatus.success));
    }catch(e){
      add(Error(LogicalException(message: e.toString())));
    }
  }

  _onError(Error event, Emitter<EditInfoState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }

  _onChangeInfo(ChangeInfo event, Emitter<EditInfoState> emit) {
    emit(state.copyWith(profile: event.profile));
  }

  _onSendEmail(SendEmail event, Emitter<EditInfoState> emit) async{
    emit(state.copyWith(status: CommonStatus.loading));

    // try{
    //   emit(state.copyWith(status: CommonStatus.loading));
    //   await EditInfoRepository.to.sendEmail(event.email).then((value){
    //     emit(state.copyWith(sendEmail: true,status: CommonStatus.success));
    //   });
    // } on ExceptionModel catch (e){
    //   add(Error(LogicalException(message: e.message)));
    // }
    // emit(state.copyWith(sendEmail: true,status: CommonStatus.success));
  }

  _onConfirmEmail(ConfirmEmail event, Emitter<EditInfoState> emit) async {
    try{
      logger.d(event.code);
      await EditInfoRepository.to.confirmEmail(event.code).then((value){
        emit(state.copyWith(emailConfirm: true,status: CommonStatus.success));
      });
    } on ExceptionModel catch (e){
      add(Error(LogicalException(message: e.message)));
    }
  }

  _onConfirmPhone(ConfirmPhone event, Emitter<EditInfoState> emit) {
    emit(state.copyWith(phoneConfirm: true,status: CommonStatus.success));
  }
}

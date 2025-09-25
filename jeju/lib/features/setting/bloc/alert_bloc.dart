import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jeju_host_app/features/setting/bloc/alert_event.dart';
import 'package:jeju_host_app/features/setting/bloc/alert_state.dart';
import 'package:jeju_host_app/features/setting/repository/alert_repository.dart';


import '../../../core/core.dart';


class AlertBloc extends Bloc<CommonEvent,AlertState> {
  AlertBloc() : super(const AlertState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
    on<ChangeAlert>(_onChangeAlert);
  }

  _onInitial(Initial event, Emitter<AlertState> emit) async {
    await AlertRepository.to.getSetting().then((value){
      emit(state.copyWith(isOneToOneInquiry:value['data']['isOneToOneInquiry']??false,isReservation:value['data']['isReservation']??false,isMessage:value['data']['isMessage']??false,));
      if(state.isOneToOneInquiry == true && state.isReservation == true && state.isMessage == true){
        emit(state.copyWith(isAll: true));
      }else if(state.isOneToOneInquiry == false && state.isReservation == false && state.isMessage == false){
        emit(state.copyWith(isAll: false));
      }
    }).catchError((e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    });
  }
  _onChangeAlert(ChangeAlert event, Emitter<AlertState> emit) async{
    try{
      logger.d(event.type);
      logger.d(event.value);
      switch(event.type){
        case 'all':
           emit(state.copyWith(isAll:event.value ,isOneToOneInquiry:event.value,isReservation:event.value,isMessage:event.value));
        case 'isOneToOneInquiry':
           emit(state.copyWith(isOneToOneInquiry:event.value));
        case 'isReservation':
           emit(state.copyWith(isReservation:event.value));
        case 'isMessage':
           emit(state.copyWith(isMessage:event.value));
      }

      await AlertRepository.to.patchSetting({'isMessage':state.isMessage,'isOneToOneInquiry':state.isOneToOneInquiry,'isReservation':state.isReservation}).then((value) async {
        emit(state.copyWith(status: CommonStatus.success));
        final FirebaseMessaging firebase = FirebaseMessaging.instance;
        switch(event.type){
          case 'all':
            if(event.value == true){
              firebase.subscribeToTopic('question');
              firebase.subscribeToTopic('reservation');
              firebase.subscribeToTopic('message');
            }else{
              firebase.unsubscribeFromTopic('question');
              firebase.unsubscribeFromTopic('reservation');
              firebase.unsubscribeFromTopic('message');
            }
          case 'isOneToOneInquiry':
            if(event.value == true){
              firebase.subscribeToTopic('question');
            }else{
              firebase.unsubscribeFromTopic('question');
            }
          case 'isReservation':
            if(event.value == true){
              firebase.subscribeToTopic('reservation');
            }else{
              firebase.unsubscribeFromTopic('reservation');
            }
          case 'isMessage':
            if(event.value == true){
              firebase.subscribeToTopic('message');
            }else{
              firebase.unsubscribeFromTopic('message');
            }
        }
        if(state.isOneToOneInquiry == true && state.isReservation == true && state.isMessage == true){
          emit(state.copyWith(isAll: true));
        }else if(state.isOneToOneInquiry == false && state.isReservation == false && state.isMessage == false){
          emit(state.copyWith(isAll: false));
        }
      }).catchError((e){
        emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
      });

    }catch(e){
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: e.toString()));
    }
  }


  _onError(Error event, Emitter<AlertState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }



}

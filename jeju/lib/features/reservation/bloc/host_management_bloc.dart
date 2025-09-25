import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_event.dart';
import 'package:jeju_host_app/features/reservation/bloc/reservation_state.dart';


import '../../../core/core.dart';
import '../repository/reservation_repository.dart';


class HostManagementBloc extends Bloc<CommonEvent, HostManagementState> {
  HostManagementBloc() : super(const HostManagementState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
    on<ChangeAmount>(_onChangeAmount);
    on<SetAmount>(_onSetAmount);
    on<SwitchToggle>(_onSwitchToggle);
    on<Host>(_onHost);
  }

  _onInitial(Initial event, Emitter<HostManagementState> emit) async {
    await ReservationRepository.to.getHostReservationData(event.id,
        DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0))
        ,DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, 1))
    ).then((value){
      logger.d(value['data']['dateManagementList']);
      for(var r in value['data']['dateManagementList']){
        if(r['date'] == DateFormat('yyyy-MM-dd').format(event.data)){
          emit(state.copyWith(amount: r['amount'], isHosting: r['isHosting']));
          break;
        }
      }
    });

  }

  _onError(Error event, Emitter<HostManagementState> emit) {
    // emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    // emit(state.copyWith(status: CommonStatus.initial));
  }

  _onSetAmount(SetAmount event,Emitter<HostManagementState> emit ){
    emit(state.copyWith(amount: event.amount));
  }

  _onChangeAmount(ChangeAmount event,Emitter<HostManagementState> emit ){
    switch(event.menu){
      case '-10%':
        emit(state.copyWith(enable: false, amount: ((state.amount ?? 0) * 0.9).toInt()));
        logger.d(state.amount);
        break;
      case '-20%':
        emit(state.copyWith(enable: false, amount: ((state.amount ?? 0) * 0.8).toInt()));
        break;
      case '+10%':
        emit(state.copyWith(enable: false, amount: ((state.amount ?? 0) * 1.1).toInt()));
        break;
      case '직접입력':
        emit(state.copyWith(enable: true));
        break;
    }
  }

  _onSwitchToggle(SwitchToggle event,Emitter<HostManagementState> emit){
    emit(state.copyWith(isHosting: event.toggle ));
  }

  _onHost(Host event, Emitter<HostManagementState> emit) async {
    await ReservationRepository.to.postHostManagement(event.id,
               {
                 "amount" : state.amount ?? 0,
                 "date" : DateFormat("yyyy-MM-dd").format(event.date),
                 "isHosting" : state.isHosting ?? false
               }
    ).then((value){
      if(value['status'] == 200){
        emit(state.copyWith(status:  CommonStatus.success));
      }else{
        emit(state.copyWith(status:  CommonStatus.failure));
      }

    }).catchError((e){
      emit(state.copyWith(status:  CommonStatus.failure, errorMessage: e.toString()));
    }

    );
  }


}

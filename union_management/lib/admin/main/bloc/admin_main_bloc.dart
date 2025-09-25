import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../common/enum/enums.dart';
import '../model/admin_info_model.dart';
import '../repository/admin_main_repository.dart';

part 'admin_main_event.dart';
part 'admin_main_state.dart';

class AdminMainBloc extends Bloc<AdminMainEvent, AdminMainState> {
  AdminMainBloc() : super(const AdminMainState(tokenStatus: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<LogOut>(_onLogOut);
  }

  Future<FutureOr<void>> _onInitial(Initial event, Emitter<AdminMainState> emit) async {
    emit(state.copyWith(tokenStatus: CommonStatus.success));
    var result = await AdminMainRepository.to.getAdminInfo().catchError((error) {
      if (error == StatusCode.unAuthorized) {
        emit(state.copyWith(message: error.$2, tokenStatus: CommonStatus.failure));
      }
      return error;
    });
    emit(state.copyWith(adminInfo: result));
  }

  Future<FutureOr<void>> _onLogOut(LogOut event, Emitter<AdminMainState> emit) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'refreshToken');
    emit(state.copyWith(tokenStatus: CommonStatus.failure));
  }
}

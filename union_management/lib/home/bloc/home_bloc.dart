import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:union_management/common/enum/enums.dart';
import 'package:union_management/common/util/routes.dart';
import 'package:union_management/home/repository/home_repository.dart';

import '../../admin/event/model/admin_event_model.dart';
import '../../admin/settings/model/admin_setting_model.dart';
import '../../common/bloc/common_state.dart';
import '../../common/model/meta_model.dart';

part 'home_bloc.g.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<Initial>(_onInitial);
  }

  Future<void> _onInitial(Initial event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading));
    await HomeRepository.to.getDashboard().then((dashboard) async {
      return emit(state.copyWith(status: CommonStatus.success, events: dashboard.data?.events, notices: dashboard.data?.notices));
    }).catchError((e) {
      if ('$e'.contains('로그인이 필요합니다.')) navigatorKey.currentContext!.go('/login');
    });
  }
}

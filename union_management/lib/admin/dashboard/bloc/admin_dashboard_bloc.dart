import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_management/admin/pay/model/admin_pay_model.dart';

import '../../../common/enum/enums.dart';
import '../../event/model/admin_event_model.dart';
import '../../settings/model/admin_setting_model.dart';
import '../../user/model/chart_data_model.dart';
import '../repository/admin_dashboard_repository.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc() : super(const AdminDashboardState(status: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<YearChanged>(_onYearChanged);
  }

  Future<FutureOr<void>> _onInitial(Initial event, Emitter<AdminDashboardState> emit) async {
    try {
      final dashboard = await AdminDashboardRepository.to.getDashboard(DateTime.now().year, DateTime.now().year);
      emit(state.copyWith(
          status: CommonStatus.success,
          userChartData: dashboard.data?.users,
          pointChartData: dashboard.data?.points,
          pays: dashboard.data?.pays,
          notices: dashboard.data?.notices,
          events: dashboard.data?.events,
          userYear: DateTime.now().year,
          pointYear: DateTime.now().year));
    } on String catch (e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
    }
  }

  Future<FutureOr<void>> _onYearChanged(YearChanged event, Emitter<AdminDashboardState> emit) async {
    final dashboard =
    await AdminDashboardRepository.to.getDashboard(event.userYear?.year ?? state.userYear ?? DateTime.now().year, event.pointYear?.year ?? state.pointYear ?? DateTime.now().year).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(
        status: CommonStatus.success,
        userChartData: dashboard.data?.users,
        pays: dashboard.data?.pays,
        pointChartData: dashboard.data?.points,
        userYear: event.userYear?.year ?? state.userYear,
        pointYear: event.pointYear?.year ?? state.pointYear));
  }
}

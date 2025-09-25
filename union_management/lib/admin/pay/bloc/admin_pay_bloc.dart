import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/enum/enums.dart';
import '../../../common/model/meta_model.dart';
import '../../user/model/admin_user_model.dart';
import '../../user/model/chart_data_model.dart';
import '../../user/repository/admin_user_repository.dart';
import '../model/admin_pay_model.dart';
import '../repository/admin_pay_repository.dart';

part 'admin_pay_event.dart';
part 'admin_pay_state.dart';

class AdminPayBloc extends Bloc<AdminPayEvent, AdminPayState> {
  AdminPayBloc() : super(const AdminPayState(status: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<PageChanged>(_onPageChanged);
    on<Search>(_onSearch);
    on<ChangeYear>(_onChangeYear);
    on<EditUser>(_onEditUser);
    on<DeleteUser>(_onDeleteUser);
    on<AddPay>(_onAddPay);
  }

  Future<FutureOr<void>> _onInitial(Initial event, Emitter<AdminPayState> emit) async {
    try {
      final pays = await AdminPayRepository.to.getPays(1, "");
      emit(state.copyWith(meta: pays.data?.meta, status: CommonStatus.success, items: pays.data?.items, year: DateTime.now().year));
    } on String catch (e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
    }
  }

  Future<FutureOr<void>> _onPageChanged(PageChanged event, Emitter<AdminPayState> emit) async {
    final pays = await AdminPayRepository.to.getPays(event.page, event.query).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: pays.data?.meta, status: CommonStatus.success, items: pays.data?.items, searchText: event.query));
  }

  Future<FutureOr<void>> _onSearch(Search event, Emitter<AdminPayState> emit) async {
    final pays = await AdminPayRepository.to.getPays(1, event.query, filter: event.filter, order: event.order).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: pays.data?.meta, status: CommonStatus.success, searchText: event.query, items: pays.data?.items));
  }

  Future<FutureOr<void>> _onChangeYear(ChangeYear event, Emitter<AdminPayState> emit) async {
    emit(state.copyWith(year: event.date.year));
    final chart = await AdminPayRepository.to.getPayChartData(state.year ?? DateTime.now().year);
    emit(state.copyWith(chartData: chart));
  }

  Future<FutureOr<void>> _onEditUser(EditUser event, Emitter<AdminPayState> emit) async {
    final data = event.userData.toJson();
    await AdminUserRepository.to.editUser(event.id, data);
  }

  Future<FutureOr<void>> _onDeleteUser(DeleteUser event, Emitter<AdminPayState> emit) async {
    await AdminUserRepository.to.deleteUser(event.id);
  }

  Future<void> _onAddPay(AddPay event, Emitter<AdminPayState> emit) async {
    await AdminPayRepository.to.postPayData(event.id, event.data);
  }
}

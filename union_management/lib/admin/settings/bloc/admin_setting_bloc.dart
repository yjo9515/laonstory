import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_management/admin/settings/model/manager_model.dart';

import '../../../common/enum/enums.dart';
import '../../../common/model/meta_model.dart';
import '../../user/model/chart_data_model.dart';
import '../model/admin_setting_model.dart';
import '../repository/admin_setting_repository.dart';

part 'admin_setting_event.dart';
part 'admin_setting_state.dart';

class AdminSettingBloc extends Bloc<AdminSettingEvent, AdminSettingState> {
  AdminSettingBloc() : super(const AdminSettingState(status: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<PageChanged>(_onPageChanged);
    on<PageChangedManager>(_onPageChangedManager);
    on<SearchNotice>(_onSearch);
    on<SearchManager>(_onSearchManager);
    on<Update>(_onUpdate);
  }

  _onInitial(Initial event, Emitter<AdminSettingState> emit) async {
    try {
      final notices = await AdminSettingRepository.to.getSettings(1, "");
      final managers = await AdminSettingRepository.to.getManagers(1, '');
      emit(state.copyWith(meta: notices.data?.meta, managerMeta: managers.data?.meta, managers: managers.data?.managers, status: CommonStatus.success, items: notices.data?.items, year: DateTime.now().year));
    } on String catch (e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
    }
  }

  _onPageChanged(PageChanged event, Emitter<AdminSettingState> emit) async {
    final settings = await AdminSettingRepository.to.getSettings(event.page, event.query).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: settings.data?.meta, status: CommonStatus.success, items: settings.data?.items, searchText: event.query));
  }

  _onSearch(SearchNotice event, Emitter<AdminSettingState> emit) async {
    final events = await AdminSettingRepository.to.getSettings(1, event.query).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: events.data?.meta, status: CommonStatus.success, searchText: event.query, items: events.data?.items));
  }

  _onUpdate(Update event, Emitter<AdminSettingState> emit) async {
    final events = await AdminSettingRepository.to.getSettings(state.meta?.currentPage ?? 1, state.searchText ?? "").catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: events.data?.meta, status: CommonStatus.success, items: events.data?.items));
  }

  _onSearchManager(SearchManager event, Emitter<AdminSettingState> emit) async {
    final result = await AdminSettingRepository.to.getManagers(1, event.query).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(managerMeta: result.data?.meta, status: CommonStatus.success, managerSearchText: event.query, managers: result.data?.managers));
  }

  _onPageChangedManager(PageChangedManager event, Emitter<AdminSettingState> emit) async {
    final result = await AdminSettingRepository.to.getManagers(event.page, event.query).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(managerMeta: result.data?.meta, status: CommonStatus.success, managers: result.data?.managers, managerSearchText: event.query));
  }

}

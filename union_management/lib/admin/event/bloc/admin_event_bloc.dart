import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_management/admin/event/model/admin_event_model.dart';
import 'package:union_management/admin/event/repository/admin_event_repository.dart';

import '../../../common/enum/enums.dart';
import '../../../common/model/meta_model.dart';
import '../../user/model/admin_user_model.dart';
import '../../user/model/chart_data_model.dart';

part 'admin_event_event.dart';
part 'admin_event_state.dart';

class AdminEventBloc extends Bloc<AdminEventEvent, AdminEventState> {
  AdminEventBloc() : super(const AdminEventState(status: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<PageChanged>(_onPageChanged);
    on<Search>(_onSearch);
    on<Update>(_onUpdate);
    on<Request>(_onRequest);
  }

  Future<void> _onInitial(Initial event, Emitter<AdminEventState> emit) async {
    try {
      final events = await AdminEventRepository.to.getEvents(1, "");
      emit(state.copyWith(meta: events.data?.meta, status: CommonStatus.success, items: events.data?.items, year: DateTime.now().year));
    } on String catch (e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
    }
  }

  Future<void> _onPageChanged(PageChanged event, Emitter<AdminEventState> emit) async {
    final events = await AdminEventRepository.to.getEvents(event.page, event.query).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: events.data?.meta, status: CommonStatus.success, items: events.data?.items, searchText: event.query));
  }

  Future<void> _onSearch(Search event, Emitter<AdminEventState> emit) async {
    final events = await AdminEventRepository.to.getEvents(1, event.query).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: events.data?.meta, status: CommonStatus.success, searchText: event.query, items: events.data?.items));
  }

  Future<void> _onUpdate(Update event, Emitter<AdminEventState> emit) async {
    final events = await AdminEventRepository.to.getEvents(state.meta?.currentPage ?? 1, state.searchText ?? "").catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: events.data?.meta, status: CommonStatus.success, items: events.data?.items));
  }

  Future<void> _onRequest(Request event, Emitter<AdminEventState> emit) async {
    final users = await AdminEventRepository.to.getRequest(event.id).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(userMeta: users?.meta, status: CommonStatus.success, users: users?.items ?? [], event: event.event));
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../common/enum/enums.dart';
import '../../common/model/meta_model.dart';
import '../../common/util/stream_transform.dart';
import '../model/alert_model.dart';
import '../repository/alert_repository.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> with StreamTransform {
  AlertBloc() : super(const AlertState(status: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<ListFetched>(
      _onListFetched,
      transformer: throttleDroppable(),
    );
    on<Show>(_onShow);
  }

  Future<FutureOr<void>> _onInitial(Initial event, Emitter<AlertState> emit) async {
    try {
      var alert = await AlertRepository.to.getAlertList(1);
      emit(state.copyWith(status: CommonStatus.success, alert: alert.data?.items, meta: alert.data?.meta));
    } catch (e) {
      emit(state.copyWith(status: CommonStatus.failure, errorMessage: "오류가 발생하였습니다. 다시 시도해주세요"));
    }
  }

  Future<FutureOr<void>> _onShow(Show event, Emitter<AlertState> emit) async {
    await AlertRepository.to.showAlert(event.id);
    final index = state.alert.indexWhere((element) => element.id == event.id);
    state.alert[index].view = true;
    emit(state.copyWith(alert: state.alert));
  }

  Future<void> _onListFetched(ListFetched event, Emitter<AlertState> emit) async {
    if (state.hasReachedMax) return;
    try {
      final page = (state.meta?.currentPage ?? 1) + 1;
      final alerts = await AlertRepository.to.getAlertList(page);
      alerts.data?.items?.isEmpty ?? true
          ? emit(state.copyWith(hasReachedMax: true, meta: alerts.data?.meta, status: CommonStatus.success))
          : emit(state.copyWith(status: CommonStatus.success, alert: List.of(state.alert)..addAll(alerts.data?.items ?? []), hasReachedMax: (state.meta?.itemCount ?? 0) < 10));
    } catch (_) {
      emit(state.copyWith(status: CommonStatus.failure));
    }
  }
}

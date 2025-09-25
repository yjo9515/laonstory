import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:union_management/common/util/stream_transform.dart';

import '../../admin/event/model/admin_event_model.dart';
import '../../common/bloc/common_state.dart';
import '../../common/enum/enums.dart';
import '../../common/model/meta_model.dart';
import '../repository/event_repository.dart';

part 'event_bloc.g.dart';
part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> with StreamTransform {
  EventBloc() : super(const EventState()) {
    on<Initial>(_onInitial);
    on<Page>(_onPageChanged, transformer: throttleDroppable());
    on<Detail>(_onDetail);
    on<Request>(_onRequest);
    on<CancelRequest>(_onCancelRequest);
  }

  Future<void> _onInitial(Initial event, Emitter<EventState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading));
    final notices = await EventRepository.to.getEvents(1, "");
    emit(state.copyWith(status: CommonStatus.success, events: notices.items, meta: notices.meta, page: 1, query: ""));
  }

  Future<void> _onPageChanged(Page event, Emitter<EventState> emit) async {
    if (state.hasReachedMax) return;
    try {
      var page = state.page + 1;
      final notices = await EventRepository.to.getEvents(page, "");
      if (notices.meta?.currentPage == notices.meta?.totalPages) {
        emit(state.copyWith(hasReachedMax: true, status: CommonStatus.success, meta: notices.meta));
      } else {
        emit(
          state.copyWith(status: CommonStatus.success, events: List.of(state.events)..addAll(notices.items ?? []), hasReachedMax: (notices.meta?.itemCount ?? 0) < 10, page: page, meta: notices.meta),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: CommonStatus.failure));
    }
  }

  Future<void> _onDetail(Detail event, Emitter<EventState> emit) async {
    await EventRepository.to.detailEvent(event.id).then((value) {
      return emit(state.copyWith(detailEvent: value));
    });
  }

  Future<void> _onRequest(Request event, Emitter<EventState> emit) async {
    await EventRepository.to.requestEvent(event.id).then((value) async {
      emit(state.copyWith(message: '신청 완료되었습니다.'));
      return await EventRepository.to.detailEvent(event.id).then((value) {
        return emit(state.copyWith(detailEvent: value));
      });
    }).catchError((e) {
      return emit(state.copyWith(message: '이미 신청한 행사입니다.'));
    }).whenComplete(() {
      return emit(state.copyWith(message: ''));
    });
  }

  Future<void> _onCancelRequest(CancelRequest event, Emitter<EventState> emit) async {
    await EventRepository.to.cancelRequestEvent(event.id).then((value) async {
      emit(state.copyWith(message: '취소가 완료되었습니다.'));
      return await EventRepository.to.detailEvent(event.id).then((value) {
        return emit(state.copyWith(detailEvent: value));
      });
    }).catchError((e) {
      return emit(state.copyWith(message: '신청 취소에 오류가 발생하였습니다.'));
    }).whenComplete(() {
      return emit(state.copyWith(message: ''));
    });
  }
}

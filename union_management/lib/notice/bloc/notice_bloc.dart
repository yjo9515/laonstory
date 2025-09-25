import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:union_management/admin/settings/model/admin_setting_model.dart';
import 'package:union_management/common/util/stream_transform.dart';
import 'package:union_management/notice/repository/notice_repository.dart';

import '../../common/bloc/common_state.dart';
import '../../common/enum/enums.dart';
import '../../common/model/meta_model.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> with StreamTransform {
  NoticeBloc() : super(const NoticeState()) {
    on<Initial>(_onInitial);
    on<Page>(_onPageChanged, transformer: throttleDroppable());
    on<Detail>(_onDetail);
  }

  Future<void> _onInitial(Initial event, Emitter<NoticeState> emit) async {
    emit(state.copyWith(status: CommonStatus.loading));
    final notices = await NoticeRepository.to.getNotices(1, "");
    emit(state.copyWith(status: CommonStatus.success, notices: notices.items, meta: notices.meta, page: 1, query: ""));
  }

  Future<void> _onPageChanged(Page event, Emitter<NoticeState> emit) async {
    if (state.hasReachedMax) return;
    try {
      var page = state.page + 1;
      final notices = await NoticeRepository.to.getNotices(page, "");
      if (notices.meta?.currentPage == notices.meta?.totalPages) {
        emit(state.copyWith(hasReachedMax: true, status: CommonStatus.success, meta: notices.meta));
      } else {
        emit(
          state.copyWith(
              status: CommonStatus.success, notices: List.of(state.notices)..addAll(notices.items ?? []), hasReachedMax: (notices.meta?.itemCount ?? 0) < 10, page: page, meta: notices.meta),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: CommonStatus.failure));
    }
  }

  Future<void> _onDetail(Detail event, Emitter<NoticeState> emit) async {
    final notices = await NoticeRepository.to.detailNotice(event.id);
    emit(state.copyWith(detailNotice: notices));
  }
}

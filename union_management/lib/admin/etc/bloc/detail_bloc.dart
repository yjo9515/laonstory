
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:union_management/admin/event/model/admin_point_model.dart';
import 'package:union_management/admin/user/model/admin_user_model.dart';
import 'package:union_management/common/bloc/common_state.dart';
import 'package:union_management/common/util/routes.dart';

import '../../../common/enum/enums.dart';
import '../../../common/model/meta_model.dart';
import '../../../common/style.dart';
import '../../../common/util/dialog_logic.dart';
import '../../event/repository/admin_event_repository.dart';
import '../../pay/model/admin_pay_model.dart';
import '../../pay/repository/admin_pay_repository.dart';
import '../../settings/repository/admin_setting_repository.dart';
import '../../user/repository/admin_user_repository.dart';
import '../repository/detail_repository.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailState()) {
    on<Initial>(_onInitial);
    on<AddEvent>(_onAddEvent);
    on<AddPoint>(_onAddPoint);
    on<AddNotice>(_onAddNotice);
    on<EditPoint>(_onEditPoint);
    on<EditEvent>(_onEditEvent);
    on<AddPay>(_onAddPay);
    on<EditPay>(_onEditPay);
    on<AddUser>(_onAddUser);
    on<EditUser>(_onEditUser);
    on<DeleteUser>(_onDeleteUser);
    on<EditNotice>(_onEditNotice);
    on<DeleteNotice>(_onDeleteNotice);
    on<DeleteEvent>(_onDeleteEvent);
    on<PointPaginate>(_onPointPaginate);
    on<PayPaginate>(_onPayPaginate);
    on<AddManager>(_onAddManager);
    on<EditManager>(_onEditManager);
    on<DeleteManager>(_onDeleteManager);
  }

  _onInitial(Initial event, Emitter<DetailState> emit) async {
    if (event.isAdmin) {
      final pays = await DetailRepository.to.getPays(1, event.id, state.paySearchText);
      emit(state.copyWith(pays: pays.data?.items, payMeta: pays.data?.meta));
    }
    final points = await DetailRepository.to.getPoints(1, event.id, state.paySearchText);
    emit(state.copyWith(points: points.data?.items, pointMeta: points.data?.meta));
  }

  _onPointPaginate(PointPaginate event, Emitter<DetailState> emit) async {
    final points = await DetailRepository.to.getPoints(event.page, event.id ?? '1', event.query);
    emit(state.copyWith(points: points.data?.items, pointSearchText: event.query, pointMeta: points.data?.meta));
  }

  _onPayPaginate(PayPaginate event, Emitter<DetailState> emit) async {
    final points = await DetailRepository.to.getPays(event.page, event.id ?? '1', event.query);
    emit(state.copyWith(pays: points.data?.items, paySearchText: event.query, payMeta: points.data?.meta));
  }

  _onAddEvent(AddEvent event, Emitter<DetailState> emit) async {
    await AdminEventRepository.to.addEvent(event.eventData);
  }

  _onAddPay(AddPay event, Emitter<DetailState> emit) async {
    await AdminPayRepository.to.postPayData(event.id, event.data).then((value) => emit(state));
  }

  _onAddPoint(AddPoint event, Emitter<DetailState> emit) async {
    await DetailRepository.to.postPoints(event.id, event.data).then((value) => emit(state));
  }

  _onAddUser(AddUser event, Emitter<DetailState> emit) async {
    final user = User.fromJson(event.userData);
    await AdminUserRepository.to.addUser(user.toJson());
  }

  _onEditUser(EditUser event, Emitter<DetailState> emit) async {
    final user = User.fromJson(event.userData);
    await AdminUserRepository.to.editUser(event.id, user.toJson());
  }

  _onDeleteUser(DeleteUser event, Emitter<DetailState> emit) async {
    await AdminUserRepository.to.deleteUser(event.id);
  }

  _onEditNotice(EditNotice event, Emitter<DetailState> emit) async {
    await AdminSettingRepository.to.editSetting(event.id, event.noticeData);
  }

  _onDeleteNotice(DeleteNotice event, Emitter<DetailState> emit) async {
    await AdminSettingRepository.to.deleteSetting(event.id);
  }

  _onEditEvent(EditEvent event, Emitter<DetailState> emit) async {
    await AdminEventRepository.to.editEvent(event.id, event.eventData);
  }

  _onDeleteEvent(DeleteEvent event, Emitter<DetailState> emit) async {
    await AdminEventRepository.to.deleteEvent(event.id);
  }

  _onAddNotice(AddNotice event, Emitter<DetailState> emit) async {
    await AdminSettingRepository.to.addSetting(event.data);
  }

  _onEditPay(EditPay event, Emitter<DetailState> emit) async {
    await AdminPayRepository.to.editPayData(event.id, event.payData).then((value) => emit(state));
  }

  _onEditPoint(EditPoint event, Emitter<DetailState> emit) async {
    await AdminPayRepository.to.editPoints(event.id, event.pointData).then((value) => emit(state));
  }

  _onAddManager(AddManager event, Emitter<DetailState> emit) async {
    await AdminSettingRepository.to.addManager(event.data).then((value) {
      emit(state.copyWith(status: CommonStatus.success));
    }).catchError((e) {
      showAdaptiveDialog(
          context: navigatorKey.currentContext!,
          builder: (ctx) {
            return AlertDialog.adaptive(
              title: const Text(
                '알림',
              ),
              content: Text(
                '$e',
                style: textTheme(navigatorKey.currentContext!).krBody1,
              ),
              actions: <Widget>[
                adaptiveAction(
                  context: navigatorKey.currentContext!,
                  onPressed: () {
                    Navigator.pop(navigatorKey.currentContext!);
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          });
      emit(state.copyWith(status: CommonStatus.failure));
    });
  }

  _onEditManager(EditManager event, Emitter<DetailState> emit) async {
    await AdminSettingRepository.to.editManager(event.id, event.data).then((value) {
      emit(state.copyWith(status: CommonStatus.success));
    }).catchError((e) {
      showAdaptiveDialog(
          context: navigatorKey.currentContext!,
          builder: (ctx) {
            return AlertDialog.adaptive(
              title: const Text(
                '알림',
              ),
              content: Text(
                '$e',
                style: textTheme(navigatorKey.currentContext!).krBody1,
              ),
              actions: <Widget>[
                adaptiveAction(
                  context: navigatorKey.currentContext!,
                  onPressed: () {
                    Navigator.pop(navigatorKey.currentContext!);
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          });
      emit(state.copyWith(status: CommonStatus.failure));
    });
  }

  _onDeleteManager(DeleteManager event, Emitter<DetailState> emit) async {
    await AdminSettingRepository.to.deleteManager(event.id).then((value) {
      emit(state.copyWith(status: CommonStatus.success));
    }).catchError((e) {
      showAdaptiveDialog(
          context: navigatorKey.currentContext!,
          builder: (ctx) {
            return AlertDialog.adaptive(
              title: const Text(
                '알림',
              ),
              content: Text(
                '$e',
                style: textTheme(navigatorKey.currentContext!).krBody1,
              ),
              actions: <Widget>[
                adaptiveAction(
                  context: navigatorKey.currentContext!,
                  onPressed: () {
                    Navigator.pop(navigatorKey.currentContext!);
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          });
      emit(state.copyWith(status: CommonStatus.failure));
    });
  }
}

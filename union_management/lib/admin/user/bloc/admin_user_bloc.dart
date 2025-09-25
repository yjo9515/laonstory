import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/bloc/common_state.dart';
import '../../../common/enum/enums.dart';
import '../../../common/model/meta_model.dart';
import '../../../common/style.dart';
import '../../../common/util/routes.dart';
import '../model/admin_user_model.dart';
import '../model/user_data_model.dart';
import '../repository/admin_user_repository.dart';

part 'admin_user_event.dart';
part 'admin_user_state.dart';

class AdminUserBloc extends Bloc<AdminUserEvent, AdminUserState> {
  AdminUserBloc() : super(const AdminUserState(status: CommonStatus.initial)) {
    on<Initial>(_onInitial);
    on<PageChanged>(_onPageChanged);
    on<Search>(_onSearch);
    on<ChangeYear>(_onChangeYear);
    on<UploadExcel>(_onUploadExcel);
    on<DownloadExcel>(_onDownloadExcel);
    on<Update>(_onUpdate);
  }

  Future<FutureOr<void>> _onInitial(Initial event, Emitter<AdminUserState> emit) async {
    try {
      final users = await AdminUserRepository.to.getUsers(1, "");
      emit(state.copyWith(meta: users.data?.meta, status: CommonStatus.success, items: users.data?.items, year: DateTime.now().year));
      final chart = await AdminUserRepository.to.getUserChartData();
      emit(state.copyWith(chartData: chart));
    } on String catch (e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
    }
  }

  Future<FutureOr<void>> _onPageChanged(PageChanged event, Emitter<AdminUserState> emit) async {
    final users = await AdminUserRepository.to.getUsers(event.page, event.query, filter: state.filterType, order: state.orderType).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(meta: users.data?.meta, status: CommonStatus.success, items: users.data?.items, searchText: event.query));
  }

  _onSearch(Search event, Emitter<AdminUserState> emit) async {
    final users = await AdminUserRepository.to.getUsers(1, event.query, filter: event.filter, order: event.order, position: event.position, birthDay: event.birthDay ?? 0).catchError((e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
      return e;
    });
    emit(state.copyWith(
      meta: users.data?.meta,
      status: CommonStatus.success,
      searchText: event.query,
      items: users.data?.items,
      filterType: event.filter,
      orderType: event.order,
    ));
  }

  Future<FutureOr<void>> _onChangeYear(ChangeYear event, Emitter<AdminUserState> emit) async {
    emit(state.copyWith(year: event.date.year));
    final chart = await AdminUserRepository.to.getUserChartData();
    emit(state.copyWith(chartData: chart));
  }

  Future<FutureOr<void>> _onUploadExcel(UploadExcel event, Emitter<AdminUserState> emit) async {
    final file = await _selectFile();
    if (file == null) {
      return '';
    }
    try {
      showDialog<void>(
          barrierDismissible: true,
          barrierColor: black.withOpacity(0.1),
          context: navigatorKey.currentContext!,
          builder: (BuildContext ctx) {
            return Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          });
      emit(state.copyWith(status: CommonStatus.loading));
      final result = await AdminUserRepository.to.uploadFile(file);
      Navigator.pop(navigatorKey.currentContext!);
      showDialog<void>(
        barrierDismissible: true,
        barrierColor: black.withOpacity(0.1),
        context: navigatorKey.currentContext!,
        builder: (BuildContext ctx) {
          return AlertDialog(
            actions: [
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              ),
            ],
            content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    result.data?.status ?? "",
                    style: textTheme(navigatorKey.currentContext!).krBody1,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        children: (result.data?.errorData ?? [])
                            .asMap()
                            .entries
                            .map((e) => Container(
                                  margin: const EdgeInsets.all(4),
                                  child: Text('${e.value}', style: textTheme(navigatorKey.currentContext!).krSubtext1),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      final users = await AdminUserRepository.to.getUsers(1, "");
      emit(state.copyWith(meta: users.data?.meta, status: CommonStatus.success, searchText: "", items: users.data?.items));
    } catch (e) {
      emit(state.copyWith(message: '오류가 발생하였습니다.'));
    }
  }

  _onDownloadExcel(DownloadExcel event, Emitter<AdminUserState> emit) async {
    await AdminUserRepository.to.getExcelData();
  }

  Future<PlatformFile?> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: false, withReadStream: true, allowedExtensions: ['xlsx']);
    return result?.files.first;
  }

  _onUpdate(Update event, Emitter<AdminUserState> emit) async {
    try {
      final users = await AdminUserRepository.to.getUsers(state.meta?.currentPage ?? 1, state.searchText ?? "");
      emit(state.copyWith(meta: users.data?.meta, status: CommonStatus.success, items: users.data?.items));
    } on String catch (e) {
      emit(state.copyWith(message: e, status: CommonStatus.failure));
    }
  }
}

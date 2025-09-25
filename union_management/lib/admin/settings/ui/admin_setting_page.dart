import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:union_management/common/widget/common_table_data.dart';

import '../../../common/enum/enums.dart';
import '../../../common/style.dart';
import '../../../common/util/static_logic.dart';
import '../../widget/binding.dart';
import '../bloc/admin_setting_bloc.dart';
import '../model/admin_setting_model.dart';
import '../model/manager_model.dart';

class AdminSettingPage extends StatelessWidget {
  const AdminSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminSettingBloc()..add(const Initial()),
      child: BlocConsumer<AdminSettingBloc, AdminSettingState>(
        listener: (context, state) {
          switch (state.uploadStatus) {
            case UploadStatus.success:
              IconDialog.show(
                context: context,
                content: "저장되었습니다.",
                width: 300,
                iconTitle: true,
                buttonTheme: CustomButtonTheme(backgroundColor: Theme.of(context).primaryColorDark, iconColor: Theme.of(context).primaryColor, contentStyle: textTheme(context).krBody1),
                title: '',
              );
            default:
          }
          switch (state.status) {
            case CommonStatus.loading:
              showDialog<void>(
                  barrierDismissible: false,
                  barrierColor: black.withOpacity(0.1),
                  context: context,
                  builder: (BuildContext ctx) {
                    return Container(
                      color: Colors.black.withOpacity(0.1),
                      child: const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  });
            case CommonStatus.initial:
            case CommonStatus.success:
            case CommonStatus.failure:
              break;
          }
        },
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            final bool wideView = constraints.maxWidth > 1366;
            final double width = (wideView ? constraints.maxWidth / 2 : constraints.maxWidth) - 64;
            final double minHeight = wideView ? constraints.maxWidth / 2 - 64 : constraints.maxWidth / 1.5;
            return StatsTitleWidget(
                text: '서비스 설정',
                buttons: [
                  InkWell(
                    onTap: () => NoticeDialog.add(context, onChange: () => context.read<AdminSettingBloc>().add(const Update())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: black),
                      child: Text(
                        '공지사항 등록',
                        style: textTheme(context).krBody2.copyWith(color: white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () => ManagerDialog.add(context, onChange: () => context.read<AdminSettingBloc>().add(const Initial())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: black),
                      child: Text(
                        '하위 관리자 등록',
                        style: textTheme(context).krBody2.copyWith(color: white),
                      ),
                    ),
                  ),
                ],
                child: Wrap(
                  spacing: 32,
                  runSpacing: 32,
                  children: [
                    DataTileContainer(
                      width: width,
                      minHeight: minHeight,
                      child: ListDataWidget(
                        onPaginate: (page, data) => context.read<AdminSettingBloc>().add(PageChanged(page, data)),
                        onSearch: (data) => context.read<AdminSettingBloc>().add(SearchNotice(data)),
                        meta: state.meta,
                        searchText: state.searchText,
                        title: '공지사항',
                        columns: const [
                          CommonColumn('등록일자'),
                          CommonColumn('제목'),
                        ],
                        rows: dataToRows(
                          state.items ?? [],
                          context,
                          constraints,
                          onClick: (value) => NoticeDialog.show(context, value: value, onChange: () => context.read<AdminSettingBloc>().add(const Update())),
                        ),
                      ),
                    ),
                    DataTileContainer(
                      width: width,
                      minHeight: minHeight,
                      child: ListDataWidget(
                        onPaginate: (page, data) => context.read<AdminSettingBloc>().add(PageChangedManager(page, data)),
                        onSearch: (data) => context.read<AdminSettingBloc>().add(SearchManager(data)),
                        meta: state.managerMeta,
                        searchText: state.managerSearchText,
                        title: '하위 관리자',
                        columns: const [
                          CommonColumn('번호'),
                          CommonColumn('등록일자'),
                          CommonColumn('이름'),
                          CommonColumn('아이디'),
                        ],
                        rows: mangerRows(
                          state.managers,
                          context,
                          constraints,
                          onClick: (value) => ManagerDialog.edit(context, manager: value, onChange: () => context.read<AdminSettingBloc>().add(const Initial())),
                        ),
                      ),
                    ),
                  ],
                ));
          });
        },
      ),
    );
  }

  List<DataRow> dataToRows(List<Notice> items, BuildContext context, BoxConstraints constraints, {required Function(Notice) onClick}) {
    return items
        .asMap()
        .entries
        .map((element) => DataRow(
                onSelectChanged: (selected) {
                  if (selected ?? false) {
                    onClick(element.value);
                  }
                },
                cells: [
                  CommonCell(dateParser(element.value.createdAt, true)),
                  CommonCell(element.value.title ?? '-'),
                ]))
        .toList();
  }

  List<DataRow> mangerRows(List<Manager> items, BuildContext context, BoxConstraints constraints, {required Function(Manager) onClick}) {
    return items
        .asMap()
        .entries
        .map((element) => DataRow(
                onSelectChanged: (selected) {
                  if (selected ?? false) onClick(element.value);
                },
                cells: [
                  CommonCell(element.value.id ?? '-'),
                  CommonCell(dateParser(element.value.createdAt, true)),
                  CommonCell(element.value.name ?? '-'),
                  CommonCell(element.value.loginId ?? '-'),
                ]))
        .toList();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/enum/enums.dart';
import '../../../common/style.dart';
import '../../../common/util/static_logic.dart';
import '../../../common/widget/common_table_data.dart';
import '../../main/bloc/admin_main_bloc.dart' hide Initial;
import '../../widget/binding.dart';
import '../bloc/admin_user_bloc.dart';
import '../model/admin_user_model.dart';

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminUserBloc()..add(const Initial()),
      child: BlocSelector<AdminMainBloc, AdminMainState, String?>(
        selector: (state) => state.adminInfo?.role,
        builder: (context, role) {
          return BlocBuilder<AdminUserBloc, AdminUserState>(
            builder: (context, state) {
              return LayoutBuilder(builder: (context, constraints) {
                return StatsTitleWidget(
                  text: '조합원 관리',
                  buttons: [
                    const SizedBox(width: 32),
                    if (role == 'ROLE_ADMIN' || role == 'ROLE_UNION')
                      InkWell(
                          onTap: () => context
                              .read<AdminUserBloc>()
                              .add(const DownloadExcel()),
                          child: Image.asset(
                            'assets/icons/ic_excel_download.png',
                            height: 56,
                          )),
                    const SizedBox(width: 32),
                    if (role == 'ROLE_ADMIN' || role == 'ROLE_UNION')
                      InkWell(
                          onTap: () => context
                              .read<AdminUserBloc>()
                              .add(const UploadExcel()),
                          child: Image.asset(
                            'assets/icons/ic_excel_upload.png',
                            height: 56,
                          )),
                    const SizedBox(width: 32),
                    if (role == 'ROLE_ADMIN' || role == 'ROLE_UNION')
                      InkWell(
                        onTap: () => UserDialog.add(context, onChange: () {}),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: black,
                          ),
                          child: Text(
                            '조합원 직접 등록',
                            style: textTheme(context)
                                .krBody2
                                .copyWith(color: white),
                          ),
                        ),
                      ),
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (role == 'ROLE_ADMIN' || role == 'ROLE_UNION')
                        DataTileContainer(
                          width: constraints.maxWidth,
                          child: UserTableWidget(
                            isVertical: true,
                            data: state.chartData,
                            year: state.year ?? DateTime.now().year,
                            onClick: (position) => context
                                .read<AdminUserBloc>()
                                .add(Search("", position: position)),
                          ),
                        ),
                      const SizedBox(height: 32),
                      DataTileContainer(
                        width: constraints.maxWidth,
                        minHeight: constraints.maxWidth / 2,
                        child: ListDataWidget<(String, FilterType, OrderType)>(
                            showCalender:
                                role == 'ROLE_ADMIN' || role == 'ROLE_UNION',
                            onPaginate: (page, data) => context
                                .read<AdminUserBloc>()
                                .add(PageChanged(page, data)),
                            onSearch: (data) =>
                                context.read<AdminUserBloc>().add(Search(data)),
                            onBirthDaySearch: (data) => context
                                .read<AdminUserBloc>()
                                .add(Search("", birthDay: data)),
                            filters:
                                role == 'ROLE_ADMIN' || role == 'ROLE_UNION'
                                    ? const [
                                        (
                                          "전체 보기",
                                          FilterType.createdAt,
                                          OrderType.asc
                                        ),
                                        (
                                          "가입일자 최신 순",
                                          FilterType.createdAt,
                                          OrderType.desc
                                        ),
                                        (
                                          "가입일자 오래된 순",
                                          FilterType.createdAt,
                                          OrderType.asc
                                        ),
                                        (
                                          "출자금액 높은 순",
                                          FilterType.price,
                                          OrderType.desc
                                        ),
                                        (
                                          "출자금액 낮은 순",
                                          FilterType.price,
                                          OrderType.asc
                                        ),
                                        (
                                          "조합원번호 오름차순",
                                          FilterType.serialNumber,
                                          OrderType.asc
                                        ),
                                        (
                                          "조합원번호 내림차순",
                                          FilterType.serialNumber,
                                          OrderType.desc
                                        ),
                                        (
                                          "탈퇴 회원 보기",
                                          FilterType.out,
                                          OrderType.desc
                                        ),
                                        (
                                          "정상 회원 보기",
                                          FilterType.active,
                                          OrderType.desc
                                        ),
                                      ]
                                    : [],
                            filterChanged: (data) => context
                                .read<AdminUserBloc>()
                                .add(Search(state.searchText ?? "",
                                    filter: data?.$2 ?? FilterType.createdAt,
                                    order: data?.$3 ?? OrderType.asc)),
                            searchText: state.searchText,
                            meta: state.meta,
                            title: '조합원 리스트',
                            columns: role == 'ROLE_ADMIN' ||
                                    role == 'ROLE_UNION'
                                ? [
                                    const CommonColumn('조합원 번호'),
                                    const CommonColumn('가입일자'),
                                    const CommonColumn('이름'),
                                    const CommonColumn('연락처'),
                                    const CommonColumn('주민등록번호'),
                                    const CommonColumn('성별/연령'),
                                    const CommonColumn('주소'),
                                    const CommonColumn('구좌', isNumber: true),
                                    const CommonColumn('출자금(원)',
                                        isNumber: true),
                                  ]
                                : [
                                    const CommonColumn('조합원 번호'),
                                    const CommonColumn('이름'),
                                    const CommonColumn('주민등록번호'),
                                    const CommonColumn('성별/연령'),
                                    const CommonColumn('포인트', isNumber: true),
                                  ],
                            rows: role == 'ROLE_ADMIN' || role == 'ROLE_UNION'
                                ? dataRowsAdmin(
                                    state.items ?? [], context, constraints, true, (value) {
                                    UserDialog.show(
                                      context,
                                      value: value,
                                      onChange: () => context
                                          .read<AdminUserBloc>()
                                          .add(const Update()),
                                    );
                                  })
                                : dataRowsManager(state.items ?? [], context, constraints, true, (value) {
                                    UserDialog.show(
                                      context,
                                      value: value,
                                      onChange: () => context
                                          .read<AdminUserBloc>()
                                          .add(const Update()),
                                      isManager: true
                                    );
                                  })),
                      ),
                    ],
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }

  List<DataRow> dataRowsAdmin(List<User> items, BuildContext context,
      BoxConstraints constraints, bool isVertical, Function(User) onClick) {
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
                  CommonCell(element.value.serialNumber),
                  CommonCell((dateParser(element.value.createdAt ?? "", true))),
                  CommonCell(element.value.name),
                  CommonCell(element.value.phoneNumber),
                  CommonCell((element.value.registrationNumber
                                  ?.split('-')[0]
                                  .length ??
                              0) <=
                          1
                      ? '-'
                      : '${element.value.registrationNumber?.split('-')[0] ?? ""} - *******'),
                  CommonCell(
                      '${changeGenderToString(element.value.gender) ?? ""}/${element.value.age ?? ""}'),
                  CommonCell(element.value.address,
                      maxWidth: constraints.maxWidth / 4),
                  CommonCell(element.value.account),
                  CommonCell(element.value.price),
                ]))
        .toList();
  }

  List<DataRow> dataRowsManager(List<User> items, BuildContext context,
      BoxConstraints constraints, bool isVertical, Function(User) onClick) {
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
                  CommonCell(element.value.serialNumber),
                  CommonCell(element.value.name),
                  CommonCell((element.value.registrationNumber
                                  ?.split('-')[0]
                                  .length ??
                              0) <=
                          1
                      ? '-'
                      : '${element.value.registrationNumber?.split('-')[0] ?? ""} - *******'),
                  CommonCell(
                      '${changeGenderToString(element.value.gender) ?? ""}/${element.value.age ?? ""}'),
                  CommonCell(element.value.point),
                ]))
        .toList();
  }
}

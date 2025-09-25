import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_management/admin/dashboard/bloc/admin_dashboard_bloc.dart';

import '../../../common/enum/enums.dart';
import '../../../common/util/dialog_logic.dart';
import '../../../common/util/static_logic.dart';
import '../../../common/widget/common_table_data.dart';
import '../../event/model/admin_event_model.dart';
import '../../pay/model/admin_pay_model.dart';
import '../../settings/model/admin_setting_model.dart';
import '../../widget/binding.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminDashboardBloc()..add(const Initial()),
      child: BlocConsumer<AdminDashboardBloc, AdminDashboardState>(
        listener: (context, state) {
          switch (state.status) {
            case CommonStatus.loading:
              dialog(
                  context,
                  Container(
                    color: Colors.black.withOpacity(0.1),
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ));
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
            final double? height = wideView ? constraints.maxWidth / 3 - 64 : null;
            final double minHeight = wideView ? 0 : constraints.maxWidth / 2 - 64;
            final double chartHeight = wideView ? constraints.maxWidth / 3 - 64 : constraints.maxWidth / 2 - 64;
            return StatsTitleWidget(
                text: '대시보드',
                buttons: const [],
                child: Wrap(
                  spacing: 32,
                  runSpacing: 32,
                  children: [
                    DataTileContainer(
                        width: width,
                        height: chartHeight,
                        child: ChartDataWidget(
                          title: "연도별 조합원 등록 현황",
                          data: state.userChartData,
                          year: state.userYear ?? DateTime.now().year,
                          onPick: (date) => context.read<AdminDashboardBloc>().add(YearChanged(userYear: date)),
                        )),
                    DataTileContainer(
                        width: width,
                        height: chartHeight,
                        child: ChartDataWidget(
                          title: "연도별 포인트 이용 현황",
                          data: state.pointChartData,
                          chartType: ChartType.point,
                          year: state.pointYear ?? DateTime.now().year,
                          onPick: (date) => context.read<AdminDashboardBloc>().add(YearChanged(pointYear: date)),
                        )),
                    DataTileContainer(
                      width: width,
                      height: height,
                      minHeight: minHeight,
                      child: ListDataWidget(
                        title: '출자금 내역 리스트',
                        columns: const [
                          CommonColumn('납부일시'),
                          CommonColumn('이름'),
                          CommonColumn('구분'),
                          CommonColumn('금액(원)', isNumber: true),
                        ],
                        rows: payToRows(state.pays.asMap().entries, (value) {
                          UserDialog.show(
                            context,
                            value: value.user,
                            onChange: () => context.read<AdminDashboardBloc>().add(const Initial()),
                          );
                        }),
                      ),
                    ),
                    DataTileContainer(
                      width: width,
                      height: height,
                      minHeight: minHeight,
                      child: ListDataWidget(
                        title: '공지사항',
                        columns: const [CommonColumn('등록일자'), CommonColumn('제목')],
                        rows: noticeToRows(
                          state.notices.asMap().entries,
                          (value) => NoticeDialog.show(context, value: value),
                        ),
                      ),
                    ),
                    DataTileContainer(
                      width: width,
                      height: height,
                      minHeight: minHeight,
                      child: ListDataWidget(
                        meta: null,
                        searchText: state.searchText,
                        title: '행사 리스트',
                        columns: const [
                          CommonColumn('등록일자'),
                          CommonColumn('행사 제목'),
                          CommonColumn('진행일자'),
                          CommonColumn('상태'),
                          CommonColumn('참여 지급포인트', isNumber: true),
                        ],
                        rows: eventToRows(
                          state.events.asMap().entries,
                          (value) => EventDialog.show(context, value: value, onChange: () => context.read<AdminDashboardBloc>().add(const Initial())),
                        ),
                      ),
                    )
                  ],
                ));
          });
        },
      ),
    );
  }

  List<DataRow> payToRows(Iterable<MapEntry<int, Pay>> pays, Function(Pay) onClick) {
    return pays
        .map((element) => DataRow(onSelectChanged: (selected) => onClick(element.value), cells: [
              CommonCell(dateParser(element.value.payTime, true)),
              CommonCell(element.value.user?.name ?? '-'),
              CommonCell(element.value.sort ?? '-'),
              CommonCell(element.value.amount),
            ]))
        .toList();
  }

  List<DataRow> noticeToRows(Iterable<MapEntry<int, Notice>> items, Function(Notice) onClick) {
    return items
        .map((element) => DataRow(onSelectChanged: (selected) => onClick(element.value), cells: [
              CommonCell(dateParser(element.value.createdAt, false)),
              CommonCell(element.value.title ?? '-'),
            ]))
        .toList();
  }

  List<DataRow> eventToRows(Iterable<MapEntry<int, Event>> items, Function(Event) onClick) {
    return items
        .map((element) => DataRow(onSelectChanged: (selected) => onClick(element.value), cells: [
              CommonCell(dateParser(element.value.createdAt, false)),
              CommonCell(element.value.title, maxWidth: 200),
              CommonCell(dateParser(element.value.eventTime, false)),
              CommonCell('${eventStatusToString(element.value.eventStatus)}'),
              CommonCell(element.value.point),
            ]))
        .toList();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_management/common/widget/common_table_data.dart';

import '../../../common/enum/enums.dart';
import '../../../common/style.dart';
import '../../../common/util/static_logic.dart';
import '../../widget/binding.dart';
import '../bloc/admin_pay_bloc.dart';
import '../model/admin_pay_model.dart';

class AdminPayPage extends StatelessWidget {
  const AdminPayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminPayBloc()..add(const Initial()),
      child: BlocConsumer<AdminPayBloc, AdminPayState>(
        listener: (context, state) {
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
            final double width = constraints.maxWidth - 96;
            final double minHeight = wideView
                ? constraints.maxWidth / 2 - 64
                : constraints.maxWidth / 1.5;
            return StatsTitleWidget(
              text: '출자금 관리',
              buttons: const [],
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataTileContainer(
                      width: width,
                      minHeight: minHeight,
                      child: ListDataWidget(
                        onPaginate: (page, data) {
                          BlocProvider.of<AdminPayBloc>(context)
                              .add(PageChanged(page, data));
                        },
                        onSearch: (data) {
                          BlocProvider.of<AdminPayBloc>(context)
                              .add(Search(data));
                        },
                        filters: const [
                          ("전체 보기", FilterType.payTime, OrderType.asc),
                          ("최신 순", FilterType.payTime, OrderType.desc),
                          ("오래된 순", FilterType.payTime, OrderType.asc),
                          ("출자금액 높은 순", FilterType.amount, OrderType.desc),
                          ("출자금액 낮은 순", FilterType.amount, OrderType.asc),
                        ],
                        filterChanged: (data) {
                          context.read<AdminPayBloc>().add(Search(
                              state.searchText ?? "",
                              filter: data?.$2 ?? FilterType.createdAt,
                              order: data?.$3 ?? OrderType.asc));
                        },
                        meta: state.meta,
                        searchText: state.searchText,
                        title: '출자금 내역 리스트',
                        columns: const [
                          CommonColumn('납부일시'),
                          CommonColumn('이름'),
                          CommonColumn('납부 계좌'),
                          CommonColumn('구분'),
                          CommonColumn('금액(원)', isNumber: true),
                        ],
                        rows: dataToRows(
                            state.items ?? [], context, constraints, false,
                            (value) {
                          UserDialog.show(context,
                              value: value.user, onChange: () {});
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  List<DataRow> dataToRows(List<Pay> items, BuildContext context,
      BoxConstraints constraints, bool isVertical, Function(Pay) onClick) {
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
                  CommonCell((timeParser(element.value.payTime, true))),
                  CommonCell(element.value.user?.name),
                  CommonCell(element.value.bankAccount),
                  CommonCell(element.value.sort),
                  CommonCell(element.value.amount),
                ]))
        .toList();
  }
}

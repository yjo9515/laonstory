import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_management/admin/event/bloc/admin_event_bloc.dart';
import 'package:union_management/common/widget/common_table_data.dart';

import '../../../common/enum/enums.dart';
import '../../../common/style.dart';
import '../../../common/util/static_logic.dart';
import '../../user/model/admin_user_model.dart';
import '../../widget/binding.dart';
import '../model/admin_event_model.dart';

class AdminEventPage extends StatelessWidget {
  const AdminEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminEventBloc()..add(const Initial()),
      child: BlocConsumer<AdminEventBloc, AdminEventState>(
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
            final double width = (constraints.maxWidth) - 64;
            final double minHeight = wideView ? constraints.maxWidth / 2 - 64 : constraints.maxWidth / 1.5;

            return StatsTitleWidget(
              text: '행사',
              buttons: [
                InkWell(
                  onTap: () {
                    EventDialog.add(context, onChange: () {
                      context.read<AdminEventBloc>().add(const Update());
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: black,
                    ),
                    child: Text(
                      '행사 등록',
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
                      onPaginate: (page, data) {
                        context.read<AdminEventBloc>().add(PageChanged(page, data));
                      },
                      onSearch: (data) {
                        context.read<AdminEventBloc>().add(Search(data));
                      },
                      meta: state.meta,
                      searchText: state.searchText,
                      title: '행사 리스트',
                      columns: const [
                        CommonColumn('등록일자'),
                        CommonColumn('행사 제목'),
                        CommonColumn('진행일자'),
                        CommonColumn('상태'),
                        CommonColumn('지급포인트', isNumber: true),
                      ],
                      rows: dataToRows(
                        state.items ?? [],
                        context,
                        constraints,
                        !wideView,
                        (value) {
                          EventDialog.show(context, value: value, onChange: () {
                            context.read<AdminEventBloc>().add(const Update());
                          });
                        },
                        onSelect: (event) {
                          context.read<AdminEventBloc>().add(Request(event.id ?? '', event));
                        },
                      ),
                    ),
                  ),
                  // DataTileContainer(
                  //   width: width,
                  //   minHeight: minHeight,
                  //   child: ListDataWidget(
                  //     onPaginate: (page, data) => context.read<AdminEventBloc>().add(PageChanged(page, data)),
                  //     onSearch: (data) => context.read<AdminEventBloc>().add(Search(data)),
                  //     meta: state.userMeta,
                  //     searchText: state.userSearchText,
                  //     title: '행사 참여자 리스트',
                  //     columns: const [
                  //       CommonColumn('신청일자'),
                  //       CommonColumn('행사제목'),
                  //       CommonColumn('이름'),
                  //       CommonColumn('전화번호'),
                  //       CommonColumn('보유포인트', isNumber: true),
                  //     ],
                  //     rows: dataToUserRows(state.users, state.event ?? const Event(), context, constraints, !wideView, (value) {
                  //       UserDialog.show(
                  //         context,
                  //         value: value,
                  //         onChange: () => context.read<AdminEventBloc>().add(Request(state.event?.id ?? '', state.event ?? const Event())),
                  //       );
                  //     }),
                  //   ),
                  // ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  List<DataRow> dataToRows(List<Event> items, BuildContext context, BoxConstraints constraints, bool isVertical, Function(Event) onClick, {Function(Event)? onSelect}) {
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
                  CommonCell((dateParser(element.value.createdAt, true))),
                  CommonCell(element.value.title ?? '-'),
                  CommonCell(dateParser(element.value.eventTime, true)),
                  CommonCell('${eventStatusToString(element.value.eventStatus)}'),
                  CommonCell(element.value.point),
                  // CommonCell(IconButton(
                  //   splashRadius: 20,
                  //   onPressed: () {
                  //     if (onSelect != null) {
                  //       onSelect(element.value);
                  //     }
                  //   },
                  //   icon: const Icon(Icons.open_in_new),
                  // )),
                ]))
        .toList();
  }

  List<DataRow> dataToUserRows(List<User> items, Event event, BuildContext context, BoxConstraints constraints, bool isVertical, Function(User) onClick) {
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
                  CommonCell((dateParser(element.value.createdAt, true))),
                  CommonCell(event.title ?? '-'),
                  CommonCell(element.value.name),
                  CommonCell(element.value.phoneNumber),
                  CommonCell(element.value.point),
                ]))
        .toList();
  }
}

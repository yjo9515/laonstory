import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/enum/enums.dart';
import '../../common/model/meta_model.dart';
import '../../common/style.dart';
import '../../common/util/static_logic.dart';
import '../../common/widget/edit_text_field_widget.dart';
import '../../common/widget/popup_menu_widget.dart';

class ListDataWidget<T> extends StatelessWidget {
  const ListDataWidget({
    Key? key,
    required this.title,
    required this.columns,
    this.rows = const [],
    this.onSearch,
    this.meta,
    this.onPaginate,
    this.searchText,
    this.filters = const [],
    this.filterChanged,
    this.showCalender = false,
    this.onBirthDaySearch,
  }) : super(key: key);

  final String title;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final Function(String)? onSearch;
  final Function(int)? onBirthDaySearch;
  final Meta? meta;
  final Function(int, String)? onPaginate;
  final String? searchText;
  final List<T> filters;
  final ValueChanged<T?>? filterChanged;
  final bool showCalender;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: searchText);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: textTheme(context).krSubtitle1),
              const Spacer(),
              if (showCalender)
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: white,
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: Column(
                              children: [
                                Expanded(
                                  child: GridView(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 1.5,
                                    ),
                                    children: [
                                      for (int i = 1; i < 13; i++)
                                        TextButton(
                                            onPressed: () {
                                              if (onBirthDaySearch != null) {
                                                onBirthDaySearch!(i);
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Text('$i월'))
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.all(16),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('취소')),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text('월 별 생일 조회', style: textTheme(context).krBody1),
                ),
              if (showCalender) const SizedBox(width: 16),
              if (meta != null) Text('검색 결과 수 ${meta?.totalItems}건', style: textTheme(context).krBody1),
              if (meta != null) const SizedBox(width: 16),
              if (meta != null)
                SizedBox(
                    width: 340,
                    child: EditTextFieldWidget(
                        controller: textController,
                        onFieldSubmitted: (text) {
                          if (onSearch != null) onSearch!(textController.text);
                        },
                        suffixWidget: IconButton(
                            onPressed: () {
                              if (onSearch != null) {
                                onSearch!(textController.text);
                              }
                            },
                            icon: SvgPicture.asset('assets/icons/ic_search.svg')))),
              if (filters.isNotEmpty)
                PopupMenuWidget(
                    dropdownList: filters,
                    onChanged: (value) {
                      if (filterChanged != null) {
                        filterChanged!(value);
                      }
                    }),
            ],
          ),
          SizedBox(height: meta == null ? 16 : 40),
          rows.isEmpty
              ? Center(child: Text("데이터가 없습니다.", style: textTheme(context).krSubtext2.copyWith(fontWeight: FontWeight.bold, fontSize: 16)))
              : Flexible(
                  child: DataTable(
                    showCheckboxColumn: false,
                    headingTextStyle: textTheme(context).krSubtext1B,
                    dataTextStyle: textTheme(context).krSubtext1,
                    dividerThickness: 0,
                    sortColumnIndex: 0,
                    horizontalMargin: 0,
                    columnSpacing: 0,
                    showBottomBorder: false,
                    columns: columns,
                    rows: rows,
                  ),
                ),
          const SizedBox(height: 16),
          rows.isEmpty || meta == null
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (onPaginate != null) {
                            onPaginate!(1, textController.text);
                          }
                        },
                        icon: const Icon(Icons.keyboard_double_arrow_left_outlined)),
                    IconButton(
                        onPressed: () {
                          var page = paginateNumber(meta?.currentPage ?? 1, meta?.totalPages ?? 1, Path.left);
                          if (page != 0) {
                            if (onPaginate != null) {
                              onPaginate!(page, textController.text);
                            }
                          }
                        },
                        icon: const Icon(Icons.keyboard_arrow_left_outlined)),
                    for (int page = getMinPage(meta?.currentPage ?? 1, meta?.totalPages ?? 1); page <= getMaxPage(meta?.currentPage ?? 1, meta?.totalPages ?? 1); page++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextButton(
                            style: TextButton.styleFrom(backgroundColor: page == (meta?.currentPage ?? 1) ? black : white),
                            onPressed: () {
                              if (onPaginate != null) {
                                onPaginate!(page, textController.text);
                              }
                            },
                            child: Text(
                              '$page',
                              style: textTheme(context).krBody1.copyWith(color: page == (meta?.currentPage ?? 1) ? white : black),
                            )),
                      ),
                    IconButton(
                        onPressed: () {
                          var page = paginateNumber(meta?.currentPage ?? 1, meta?.totalPages ?? 1, Path.right);
                          if (page != 0) {
                            if (onPaginate != null) {
                              onPaginate!(page, textController.text);
                            }
                          }
                        },
                        icon: const Icon(Icons.keyboard_arrow_right_outlined)),
                    IconButton(
                        onPressed: () {
                          if (onPaginate != null) {
                            onPaginate!(meta?.totalPages ?? 1, textController.text);
                          }
                        },
                        icon: const Icon(Icons.keyboard_double_arrow_right_outlined)),
                  ],
                )
        ],
      ),
    );
  }
}

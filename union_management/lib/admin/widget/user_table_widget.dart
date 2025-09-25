import 'package:flutter/material.dart';

import '../../common/enum/enums.dart';
import '../../common/style.dart';
import '../user/model/chart_data_model.dart';
import '../user/model/user_data_model.dart';

class UserTableWidget extends StatelessWidget {
  const UserTableWidget({Key? key, this.isVertical = false, this.data, required this.year, this.title = "총 등록 조합원 수 ", this.isMoney = false, this.onClick}) : super(key: key);

  final bool isVertical;
  final String title;
  final UserDataModel? data;
  final int year;
  final bool isMoney;
  final Function(PositionEnum)? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft, child: Text("$title($year년 현재 기준)", style: textTheme(context).krSubtitle2)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (onClick != null) onClick!(PositionEnum.all);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.blueAccent),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('총 가입자', style: textTheme(context).krSubtitle1R.copyWith(color: white)),
                        Text("${data?.data?.total ?? 0} ${isMoney ? '원' : "명"}", style: textTheme(context).krTitle1.copyWith(color: white)),
                      ],
                    )),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  if (onClick != null) onClick!(PositionEnum.member);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.deepOrange),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('조합원', style: textTheme(context).krSubtitle1R.copyWith(color: white)),
                        Text("${data?.data?.member ?? 0} ${isMoney ? '원' : "명"}", style: textTheme(context).krTitle1.copyWith(color: white)),
                      ],
                    )),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  if (onClick != null) onClick!(PositionEnum.delegate);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.orangeAccent),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('대의원', style: textTheme(context).krSubtitle1R.copyWith(color: white)),
                        Text("${data?.data?.delegate ?? 0} ${isMoney ? '원' : "명"}", style: textTheme(context).krTitle1.copyWith(color: white)),
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<DataColumn> monthLabelWidget(BuildContext context, TextStyle style) {
    return [
      DataColumn(label: Expanded(child: Center(child: Text('1월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('2월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('3월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('4월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('5월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('6월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('7월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('8월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('9월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('10월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('11월', style: style)))),
      DataColumn(label: Expanded(child: Center(child: Text('12월', style: style)))),
    ];
  }

  // List<DataRow> monthUserWidget(BuildContext context, List<ChartData> data) {
  //   return [DataRow(cells: data.asMap().entries.map((e) => DataCell(Center(child: Text('+ ${e.value.increase ?? 0} ${isMoney ? '원' : "명"}')))).toList())];
  // }
}

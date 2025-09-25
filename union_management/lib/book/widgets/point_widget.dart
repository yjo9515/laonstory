import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../common/style.dart';
import 'binding.dart';

class PointWidget extends StatelessWidget {
  const PointWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: TrapezoidPainter(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.pinkAccent,
                child: Text(
                  '건강 포인트',
                  style: textTheme(context).krTitle1.copyWith(color: white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '◉',
                    style: textTheme(context).krSubtitle2,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: AutoSizeText(
                      '조합 활동에 참여하신 만큼 "건강포인트"를 적립해드립니다. 적립한 포인트는 시민의원과 123한의원에서 사용하실 수 있습니다.',
                      style: textTheme(context).krBody1,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- 조합활동 예시 :',
                    style: textTheme(context).krSubtitle2.copyWith(color: Colors.pinkAccent),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: AutoSizeText(
                      '건강강좌, 봉사활동, 조합 소모임,\n기타 (조합이 인정하는 활동)',
                      style: textTheme(context).krBody1,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                dataTextStyle: textTheme(context).krSubtext1.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
                dividerThickness: 3,
                showBottomBorder: true,
                columnSpacing: 0,
                horizontalMargin: 0,
                border: const TableBorder(
                  verticalInside: BorderSide(width: 1, color: black),
                  horizontalInside: BorderSide(width: 1, color: black),
                ),
                decoration: BoxDecoration(border: Border.all(width: 2.5, color: black), color: white),
                columns: monthLabelWidget(context, textTheme(context).krBody2),
                rows: monthDataWidget(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> monthLabelWidget(BuildContext context, TextStyle style) {
    return [
      DataColumn(
        label: Expanded(
          child: Container(
            color: const Color(0xFFFF9ABB),
            child: Center(
                child: Text(
              '일자',
              style: style,
            )),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
            child: Container(
          color: const Color(0xFFFF9ABB),
          child: Center(
              child: Text(
            '활동 내용',
            style: style,
          )),
        )),
      ),
      DataColumn(
        label: Expanded(
            child: Container(
          color: const Color(0xFFFF9ABB),
          child: Center(
              child: Text(
            '활동 시간',
            style: style,
          )),
        )),
      ),
      DataColumn(
        label: Expanded(child: Container(color: const Color(0xFFFF9ABB), child: Center(child: Text('건강포인트', style: style)))),
      ),
      DataColumn(
        label: Expanded(
          child: Container(
            color: const Color(0xFFFF9ABB),
            child: Center(
                child: Text(
              '확인',
              style: style,
            )),
          ),
        ),
      ),
    ];
  }

  List<DataRow> monthDataWidget(BuildContext context) {
    return [
      const DataRow(cells: [
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
      ]),
      const DataRow(cells: [
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
      ]),
      const DataRow(cells: [
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
      ]),
      const DataRow(cells: [
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
      ]),
      const DataRow(cells: [
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
      ]),
    ];
  }
}

import 'package:flutter/material.dart';

import '../../common/style.dart';
import 'binding.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({Key? key}) : super(key: key);

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
                color: Colors.deepPurple,
                child: Text(
                  '혈당, 혈압 기록란',
                  style: textTheme(context).krTitle1.copyWith(color: white),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
            color: const Color(0xFFB39DDB),
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
          color: const Color(0xFFB39DDB),
          child: Center(
              child: Text(
            '식전 혈당',
            style: style,
          )),
        )),
      ),
      DataColumn(
        label: Expanded(
            child: Container(
          color: const Color(0xFFB39DDB),
          child: Center(
              child: Text(
            '식후 혈당',
            style: style,
          )),
        )),
      ),
      DataColumn(
        label: Expanded(child: Container(color: const Color(0xFFB39DDB), child: Center(child: Text('혈압', style: style)))),
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
      ]),
      const DataRow(cells: [
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
      ]),
      const DataRow(cells: [
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
      ]),
      const DataRow(cells: [
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
        DataCell(Center(child: Text(''))),
      ]),
    ];
  }
}

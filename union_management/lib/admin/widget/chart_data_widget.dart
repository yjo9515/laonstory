import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:union_management/admin/user/model/chart_data_model.dart';
import 'package:union_management/common/enum/enums.dart';

import '../../common/style.dart';
import 'binding.dart';

class ChartDataWidget extends StatelessWidget {
  const ChartDataWidget(
      {Key? key,
      this.data = const [],
      this.year,
      required this.onPick,
      required this.title,
      this.lineOne = false,
      this.chartType = ChartType.user})
      : super(key: key);

  final List<ChartData>? data;
  final int? year;
  final Function(DateTime) onPick;
  final String title;
  final bool lineOne;
  final ChartType chartType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: dataTypeWidget(context)),
          const SizedBox(height: 40),
          if (data != null && (data ?? []).isNotEmpty)
            Flexible(
              child: switch (chartType) {
                ChartType.user => chartWidget,
                ChartType.point => pointChartWidget
              }(data, context),
            )
        ],
      ),
    );
  }

  Widget chartWidget(List<ChartData>? model, BuildContext context) {
    return lineChart([
      if (!lineOne)
        LineChartBarData(
          spots: model
              ?.asMap()
              .entries
              .map(
                (element) => FlSpot(element.value.number?.toDouble() ?? 0.0,
                    (element.value.accrue ?? 0 / (lineOne ? 10000 : 1))),
              )
              .toList(),
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withOpacity(0.3),
                Colors.blueAccent.withOpacity(0.2),
                Colors.blueAccent.withOpacity(0.1),
              ],
            ),
          ),
        ),
      if (!lineOne)
        LineChartBarData(
          spots: model
              ?.asMap()
              .entries
              .map((element) => FlSpot(element.value.number?.toDouble() ?? 0.0, element.value.increase ?? 0))
              .toList(),
          isCurved: false,
          color: lineOne ? Colors.black : Colors.deepOrange,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      if (lineOne)
        LineChartBarData(
          spots: model
              ?.asMap()
              .entries
              .map((element) => FlSpot(element.value.number?.toDouble() ?? 0.0,
                  ((element.value.accrue ?? 0))))
              .toList(),
          isCurved: false,
          color: lineOne ? Colors.black : Colors.deepOrange,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
    ], context);
  }

  Widget pointChartWidget(List<ChartData>? model, BuildContext context) {
    return barChart(
        model
            ?.asMap()
            .entries
            .map(
              (element) =>
                  BarChartGroupData(x: element.value.number ?? 0, barRods: [
                BarChartRodData(toY: element.value.increase ?? 0, color: Colors.blue),
                    BarChartRodData(toY: element.value.decrease ?? 0, color: Colors.red)
              ]),
            )
            .toList(),
        context);
  }

  List<Widget> dataTypeWidget(BuildContext context) {
    return [
      Text(title, style: textTheme(context).krSubtitle1),
      const SizedBox(width: 24),
      LabelWidget(text: chartType == ChartType.point ? '지급' : "누적", color: Colors.blueAccent),
      const SizedBox(width: 16),
      LabelWidget(text: chartType == ChartType.point ? '사용' : "증감", color: Colors.deepOrange),
      const Spacer(),
      TextButton(
        child: Text(
          '$year 년',
          style: textTheme(context)
              .krBody2
              .copyWith(decoration: TextDecoration.underline),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SizedBox(
                  width: 300,
                  height: 300,
                  child: YearPicker(
                      currentDate: DateTime(year ?? DateTime.now().year),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      selectedDate: DateTime(year ?? DateTime.now().year),
                      onChanged: (date) {
                        Navigator.pop(context);
                        onPick(date);
                      }),
                ),
              );
            },
          );
        },
      ),
    ];
  }

  Widget barChart(List<BarChartGroupData>? barGroups, BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 56,
                getTitlesWidget: (data, meta) {
                  return Container(
                      margin: const EdgeInsets.only(top: 16),
                      child:
                          Text("$data월", style: textTheme(context).krSubtext1));
                }),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 64,
              interval: 200000,
              getTitlesWidget: (data, meta) {
                return data == meta.max ? Container() : data == meta.min
                    ? Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Text("$year년",
                            style: textTheme(context).krSubtext2))
                    : Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Text(
                        "${chartType == ChartType.point ? data ~/ 10000 : data}${chartType == ChartType.point ? '만 점' : '명'}",

                        style: textTheme(context).krSubtext2));
              },
            ),
          ),
        ),
        barGroups: barGroups,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (data) {
              return FlLine(strokeWidth: 0.7, color: gray5);
            }),
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOut,
    );
  }

  Widget lineChart(List<LineChartBarData>? lines, BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 56,
                getTitlesWidget: (data, meta) {
                  return Container(
                      margin: const EdgeInsets.only(top: 16),
                      child:
                          Text("$data월", style: textTheme(context).krSubtext1));
                }),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1000,
              reservedSize: 64,
              getTitlesWidget: (data, meta) {
                return data == meta.min
                    ? Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Text("$year년",
                            style: textTheme(context).krSubtext2))
                    : data == meta.max
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Text(
                                "$data명",
                                style: textTheme(context).krSubtext2));
                // : Container();
              },
            ),
          ),
        ),
        lineBarsData: lines,
        borderData: FlBorderData(show: false),
        maxY: double.parse(((data?.last.accrue ?? 0) * 1.2).toStringAsFixed(0)),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (data) {
            return FlLine(strokeWidth: 1, color: gray5);
          },
          getDrawingVerticalLine: (data) {
            return FlLine(strokeWidth: 1, color: gray5);
          },
        ),
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOut,
    );
  }

  Widget pieChart(List<PieChartSectionData>? sections, BuildContext context) {
    return PieChart(
      PieChartData(
        borderData: FlBorderData(show: false),
        sections: sections,
        sectionsSpace: 0,
        centerSpaceRadius: 50,
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOut,
    );
  }
}

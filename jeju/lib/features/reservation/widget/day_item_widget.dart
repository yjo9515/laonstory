import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';

class DayItemWidget extends StatelessWidget {
  const DayItemWidget({
    super.key,
    required this.properties,
    required this.disabledDate,
    required this.calendarDate,
    required this.onSelected,
    required this.dateAmount,
  });

  final DateTime calendarDate;
  final DayItemProperties properties;
  final List<DateTime> disabledDate;
  final Function(DateTime) onSelected;
  final List<DateManagement> dateAmount;

  @override
  Widget build(BuildContext context) {
    final data = disabledDate.where((e) => DateTime(calendarDate.year, calendarDate.month, properties.dayNumber) == e);
    var amount;
    for(var r in dateAmount){
      if(properties.dayNumber == r.date?.day){
        amount = r.amount;
      }
    }
    return InkWell(
      onTap: () {
        onSelected(DateTime(calendarDate.year,properties.isInMonth ? calendarDate.month : properties.dayNumber < 20 ? calendarDate.month + 1 : calendarDate.month - 1, properties.dayNumber));
      },
      child: Container(
        decoration: BoxDecoration(
          color: data.isNotEmpty ? Colors.transparent : white,
          border: Border.all(color: properties.isCurrentDay ? black2 : black5, width: 0.25),
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: data.isNotEmpty && properties.isInMonth
                  ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: List.generate(66, (index) {
                  if (index % 4 == 0 || index % 4 == 1) {
                    return Colors.transparent;
                  } else {
                    return black4.withOpacity(0.3);
                  }
                }),
                stops: () {
                  final List<double> stops = [];
                  double i = 0;
                  double increment = 0.05;
                  while (i < 1) {
                    stops.add(i);
                    i += increment;
                    if (i >= 1) {
                      stops.add(1);
                      break;
                    }
                    increment = increment == 0.05 ? 0.01 : 0.05;
                    stops.add(i);
                  }
                  return stops;
                }(),
              )
                  : null,
            ),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('${properties.dayNumber}',
                      style: context.textTheme.krSubtext2.copyWith(
                          decoration: data.isNotEmpty && properties.isInMonth ? TextDecoration.lineThrough : TextDecoration.none,
                          color: data.isNotEmpty
                              ? black4
                              : properties.isInMonth
                                  ? black
                                  : black4)),
                ),
                const Spacer(),
                if (properties.notFittedEventsCount == 0 && properties.isInMonth)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(data.isNotEmpty || amount == null ? '' : NumberFormat('###,###,###,###').format(amount), style: context.textTheme.krBottom),
                  )
              ],
            )),
      ),
    );
  }
}

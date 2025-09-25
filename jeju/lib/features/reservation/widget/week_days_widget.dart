import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

/// Widget that represents week days in row above calendar month view.
class WeekDaysWidget extends StatelessWidget {
  const WeekDaysWidget({
    required this.day,
    super.key,
  });

  /// [WeekDay] value from [WeekDaysBuilder].
  final WeekDay day;

  @override
  Widget build(BuildContext context) {
    final weekDay = switch (day) {
      WeekDay.sunday => '일',
      WeekDay.monday => '월',
      WeekDay.tuesday => '화',
      WeekDay.wednesday => '수',
      WeekDay.thursday => '목',
      WeekDay.friday => '금',
      WeekDay.saturday => '토',
    };

    final weekDayColor = switch (day) {
      WeekDay.sunday => Colors.red,
      WeekDay.saturday => Colors.blue,
      _ => Colors.black,
    };

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: black5,
              width: 0.25,
            ),
          ),
        ),
        height: 40,
        child: Center(
          child: Text(
            weekDay,
            style: context.textTheme.krBody1.copyWith(color: weekDayColor),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../features.dart';
import '../bloc/room_detail_bloc.dart';
import '../bloc/room_event.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key, required this.onDateRangeChanged, required this.calenderDate,required this.stopHosting,required this.plusPrice}) : super(key: key);

  final Function(DateRange?) onDateRangeChanged;
  final DateTime? calenderDate;
  final List<DateTime>? stopHosting;
  final List<DateManagement>? plusPrice;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const SvgImage('assets/icons/ic_arrow_left.svg'),
                onPressed: () {
                  context.read<RoomDetailBloc>().add(ChangeCurrentDate(DateTime(calenderDate!.year, calenderDate!.month - 1, calenderDate!.day)));
                },
              ),
              Text('${calenderDate?.year}/${calenderDate?.month}', style: context.textTheme.krSubtitle1),
              IconButton(
                icon: const SvgImage('assets/icons/ic_arrow_right.svg'),
                onPressed: () {
                  context.read<RoomDetailBloc>().add(ChangeCurrentDate(DateTime(calenderDate!.year, calenderDate!.month + 1, calenderDate!.day)));
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DateRangePickerWidget(
            doubleMonth: false,
            initialDisplayedDate: calenderDate,
            minDate: DateTime.now().subtract(const Duration(days: 1)),
            onDateRangeChanged: (DateRange? value) => onDateRangeChanged(value),
            disabledDates: stopHosting ?? [],
            plusPrice : plusPrice ?? []
            // disabledDates: [DateTime(2024,03,30)],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: mainJeJuBlue),
              ),
              const SizedBox(width: 8),
              Text(
                '선택된날짜',
                style: context.textTheme.krBody1.copyWith(color: black3),
              ),
              const SizedBox(width: 24),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: gray5),
              ),
              const SizedBox(width: 8),
              Text(
                '예약불가',
                style: context.textTheme.krBody1.copyWith(color: black3),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/core.dart';

class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget({
    Key? key,
    required this.onDateRangeChanged,
    this.initialDisplayedDate,
    this.minimumDateRangeLength,
    this.initialDateRange,
    this.minDate,
    this.maxDate,
    this.maximumDateRangeLength,
    this.disabledDates = const [],
    this.quickDateRanges = const [],
    this.doubleMonth = true,
    this.plusPrice = const [],
  }) : super(key: key);

  /// Called whenever the selected date range is changed.
  final ValueChanged<DateRange?> onDateRangeChanged;

  /// A list of quick selection dateRanges displayed at the top of the picker.
  final List<QuickDateRange> quickDateRanges;

  /// The initial selected date range.
  final DateRange? initialDateRange;

  /// The maximum length of the selected date range.
  final int? maximumDateRangeLength;

  /// The minimum length of the selected date range.
  final int? minimumDateRangeLength;

  /// Set to true to display two months at a time.
  final bool doubleMonth;

  /// The earliest selectable date.
  final DateTime? minDate;

  /// The latest selectable date.
  final DateTime? maxDate;

  /// The date that is initially displayed when the picker is opened.
  final DateTime? initialDisplayedDate;

  /// A list of dates that are disabled and cannot be selected.
  final List<DateTime> disabledDates;

  final List<DateManagement> plusPrice;

  @override
  State<DateRangePickerWidget> createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late final controller = RangePickerController(
    dateRange: widget.initialDateRange,
    minDate: widget.minDate,
    maxDate: widget.maxDate,
    onDateRangeChanged: widget.onDateRangeChanged,
    disabledDates: widget.disabledDates,
    minimumDateRangeLength: widget.minimumDateRangeLength,
    maximumDateRangeLength: widget.maximumDateRangeLength,
    plusPrice: widget.plusPrice
  );

  late final calendarController = CalendarWidgetController(
    controller: controller,
    currentMonth: widget.initialDisplayedDate ?? widget.initialDateRange?.start ?? DateTime.now(),
  );

  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = calendarController.updateStream.listen((event) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    calendarController.currentMonth = widget.initialDisplayedDate ?? widget.initialDateRange?.start ?? DateTime.now();
    return Center(
      child: EnrichedMonthWrapWidget(
        stopHosting:calendarController.controller.disabledDates,
        onDateChanged: calendarController.onDateChanged,
        days: calendarController.retrieveDatesForMonth(),
        delta: calendarController.retrieveDeltaForMonth(),
        plusPrice: calendarController.controller.plusPrice ?? [],
      ),
    );
  }
}

/// A widget that displays a vertical column of days in a month grid, along with the day names row.
class EnrichedMonthWrapWidget extends StatelessWidget {
  const EnrichedMonthWrapWidget({
    Key? key,
    required this.onDateChanged,
    required this.days,
    required this.delta,
    required this.stopHosting,
    required this.plusPrice
  }) : super(key: key);

  /// A callback that is called when the selected date changes.
  final ValueChanged<DateTime> onDateChanged;

  /// The days to display in the month grid.
  final List<DayModel> days;

  /// The number of days to pad at the beginning of the grid.
  final int delta;

  final List<DateTime> stopHosting;

  final List<DateManagement> plusPrice;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: DayNamesRow(
              textStyle: context.textTheme.krBody1,
              weekDays: const ['일', '월', '화', '수', '목', '금', '토'],
            ),
          ),
          MonthWrapWidget(
            days: days,
            delta: delta,
            dayTileBuilder: (dayModel) => kDayTileBuilder(
              context,
              dayModel,
              onDateChanged,
              stopHosting,
              plusPrice
            ),
            placeholderBuilder: (index) => const SizedBox(),
          ),
        ],
      ),
    );
  }
}

/// A widget that displays a wrap of a month's worth of day tiles.
class MonthWrapWidget extends StatelessWidget {
  /// Constructs a [MonthWrapWidget] widget.
  const MonthWrapWidget({
    Key? key,
    required this.days,
    required this.delta,
    required this.dayTileBuilder,
    required this.placeholderBuilder,
  }) : super(key: key);

  /// The list of [DayModel]s to display.
  final List<DayModel> days;

  /// The offset of the first day to display.
  final int delta;

  /// A builder that builds a day tile given a [DayModel].
  final Widget Function(DayModel dayModel) dayTileBuilder;

  /// A builder that builds a placeholder widget given a delta index.
  final Widget Function(int deltaIndex) placeholderBuilder;


  @override
  Widget build(BuildContext context) {
    int column = 7;
    int row = (days.length / column).ceil() + 1;
    return Column(
      children: List.generate(row, (rowIndex) {
        return Row(
          children: List.generate(column, (columnIndex) {
            if (rowIndex * column + columnIndex < delta) {
              return Expanded(child: AspectRatio(aspectRatio: 1, child: placeholderBuilder(columnIndex)));
            }
            if (rowIndex * column + columnIndex - delta >= days.length) {
              return Expanded(child: AspectRatio(aspectRatio: 1, child: placeholderBuilder(columnIndex)));
            }

            var dayModel = days[rowIndex * column + columnIndex - delta];

            return Expanded(child: AspectRatio(aspectRatio: 1, child: dayTileBuilder(dayModel)));
          }),
        );
      }),
    );
  }
}

/// A widget that represents a day tile for a calendar.
///
/// A day tile can be used to display a day of the month, and allows users to select a specific day in a calendar. This widget
/// is typically used within a larger calendar widget to represent individual days.
class DayTileWidget extends StatelessWidget {
  /// Creates a day tile widget.
  ///
  /// [size] is the size of the day tile.
  /// [text] is the text that will be displayed on the day tile.
  /// [value] is the date that the day tile represents.
  /// [radius] is the radius of the day tile.
  /// [backgroundRadius] is the radius of the day tile's background.
  /// [backgroundColor] is the background color of the day tile.
  /// [color] is the color of the day tile.
  /// [textStyle] is the style of the text on the day tile.
  /// [borderColor] is the color of the day tile's border.
  /// [onTap] is the function that will be called when the day tile is tapped.
  const DayTileWidget({
    Key? key,
    this.backgroundColor,
    this.color,
    this.textStyle,
    this.borderColor,
    required this.text,
    required this.value,
    required this.onTap,
    required this.radius,
    required this.price
  }) : super(key: key);

  /// The background color of the day tile.
  final Color? backgroundColor;

  /// The color of the day tile.
  final Color? color;

  /// The style of the text on the day tile.
  final TextStyle? textStyle;

  /// The color of the day tile's border.
  final Color? borderColor;

  /// The text that will be displayed on the day tile.
  final String text;

  /// The date that the day tile represents.
  final DateTime value;

  /// The function that will be called when the day tile is tapped.
  final ValueChanged<DateTime>? onTap;

  /// The radius of the day tile.
  final BorderRadius radius;

  final int price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: radius,
      onTap: () => onTap?.call(value),
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          children: [
            Container(
              padding : const EdgeInsets.symmetric(vertical: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: borderColor ?? Colors.transparent),
                borderRadius: radius,
              ),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
            Spacer(),
            price == null || price == 0 ?
                Container()
                :
            Text(
              numberFormatter(price),
              style: TextStyle(
                fontSize: 10
              ),
            )
          ],
        )
      ),
    );
  }
}

/// A controller that handles the logic of the date range picker.
class RangePickerController {
  RangePickerController(
      {DateRange? dateRange,
      required this.onDateRangeChanged,
      this.minDate,
      this.maxDate,
      this.startDate,
      this.endDate,
      this.plusPrice,
      this.minimumDateRangeLength,
      this.maximumDateRangeLength,
      this.disabledDates = const []}) {
    if (dateRange != null) {
      startDate = dateRange.start;
      endDate = dateRange.end;
    }
  }

  int? maximumDateRangeLength;
  int? minimumDateRangeLength;

  List<DateTime> disabledDates;

  final ValueChanged<DateRange?> onDateRangeChanged;

  /// The minimum date that can be selected. (inclusive)
  DateTime? minDate;

  /// The maximum date that can be selected. (inclusive)
  DateTime? maxDate;

  /// The start date of the selected range.
  DateTime? startDate;

  /// The end date of the selected range.
  DateTime? endDate;

  List<DateManagement>? plusPrice;

  DateRange? get dateRange {
    if (startDate == null || endDate == null) {
      return null;
    }

    return DateRange(startDate!, endDate!);
  }

  /// Called when the user selects a date in the calendar.
  /// If the [startDate] is null, it will be set to the [date] parameter.
  /// If the [startDate] is not null and the [endDate] is null, it will be set to the [date]
  /// parameter except if the [date] is before the [startDate]. In this case, the [startDate]
  /// will be set to the [date] parameter and the [endDate] will be set to null.
  /// If the [startDate] is not null and the [endDate] is not null, the [startDate] will be set
  /// to the [date] parameter and the [endDate] will be set to null.
  void onDateChanged(DateTime date) {
    for (var element in disabledDates) {
      if (startDate == null) {
        continue;
      }
      if (element.isAfter(startDate!) && element.isBefore(date)) {
        startDate = date;
        endDate = null;
        return;
      }
    }

    if (startDate == null) {
      startDate = date;
      onDateRangeChanged(DateRange(startDate!, startDate!));
    } else if (endDate == null) {
      if (date.isBefore(startDate!)) {
        startDate = date;
        endDate = null;
      } else {
        endDate = date;
        onDateRangeChanged(DateRange(startDate!, endDate!));
      }
    } else {
      startDate = date;
      endDate = null;
    }
  }

  /// Returns whether the [date] is in the selected range or not.
  bool dateInSelectedRange(DateTime date) {
    if (startDate == null || endDate == null) {
      return false;
    }
    return dateIsStartOrEnd(date) || (date.isAfter(startDate!) && date.isBefore(endDate!));
  }

  bool areSameDay(DateTime one, DateTime two) {
    return one.year == two.year && one.month == two.month && one.day == two.day;
  }

  /// Returns whether the [date] is selectable or not. (i.e. if it is between the [minDate] and the [maxDate])
  bool dateIsSelectable(DateTime date) {
    for (final DateTime disabledDay in disabledDates) {
      if (areSameDay(disabledDay, date)) {
        return false;
      }
    }

    if (startDate != null && endDate == null) {
      var dateDifference = date.difference(startDate!).inDays;
      if (maximumDateRangeLength != null && dateDifference + 1 > maximumDateRangeLength!) {
        return false;
      }

      if (minimumDateRangeLength != null && dateDifference > 0 && dateDifference + 1 < minimumDateRangeLength!) {
        return false;
      }
    }

    if (minDate != null && date.isBefore(minDate!)) {
      return false;
    }
    if (maxDate != null && date.isAfter(maxDate!)) {
      return false;
    }
    return true;
  }

  /// Returns whether the [date] is the start of the selected range or not.
  bool dateIsStart(DateTime date) {
    if (startDate == null) {
      return false;
    }

    return areSameDay(date, startDate!);
  }

  /// Returns whether the [date] is the end of the selected range or not.
  bool dateIsEnd(DateTime date) {
    if (endDate == null) {
      return false;
    }

    return areSameDay(date, endDate!);
  }

  /// Returns whether the [date] is the start or the end of the selected range or not.
  /// This is useful to display the correct border radius on the day tile.
  bool dateIsStartOrEnd(DateTime date) {
    return dateIsStart(date) || dateIsEnd(date);
  }

  List<DayModel> retrieveDatesForMonth(final DateTime month) {
    int daysInMonth = DateTime(
      month.year,
      month.month + 1,
      0,
    ).day;

    final List<DayModel> dayModels = [];

    for (int i = 1; i <= daysInMonth; i++) {
      var date = DateTime(month.year, month.month, i);

      dayModels.add(DayModel(
        date: date,
        isSelected: dateIsStartOrEnd(date),
        isStart: dateIsStart(date),
        isEnd: dateIsEnd(date),
        isSelectable: dateIsSelectable(date),
        isToday: areSameDay(date, DateTime.now()),
        isInRange: dateInSelectedRange(date),
      ));
    }

    return dayModels;
  }

  /// Returns the number of days to skip at the beginning of the month.
  int retrieveDeltaForMonth(final DateTime month) {
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    return firstDayOfMonth.weekday % 7;
  }

  void onDateRangeChangedExternally(DateRange? newRange) {
    startDate = newRange?.start;
    endDate = newRange?.end;
    onDateRangeChanged(newRange);
  }
}

/// A controller that handles the logic of the calendar widget.
class CalendarWidgetController {
  final _streamController = StreamController<void>();

  Stream<void> get updateStream => _streamController.stream;

  /// The controller that handles the logic of the date range picker.
  final RangePickerController controller;

  CalendarWidgetController({
    required this.controller,
    required DateTime currentMonth,
  }) : _currentMonth = currentMonth;

  /// The current month that is displayed.
  DateTime _currentMonth;

  /// The current month that is displayed.
  DateTime get currentMonth => _currentMonth;

  /// The current month that is displayed.
  set currentMonth(DateTime value) {
    _currentMonth = value;
    _streamController.add(null);
  }

  /// The next month that can be displayed (two months can be displayed at the same time).
  DateTime get nextMonth => DateTime(currentMonth.year, currentMonth.month + 1, 1);

  /// Goes to the next month.
  void next() {
    currentMonth = nextMonth;
  }

  void onDateChanged(DateTime date) {
    controller.onDateChanged(date);
    _streamController.add(null);
  }

  /// Goes to the previous month.
  void previous() {
    currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
  }

  /// Returns the dates for the current month.
  List<DayModel> retrieveDatesForMonth() {
    return controller.retrieveDatesForMonth(currentMonth);
  }

  /// Returns the dates for the next month.
  List<DayModel> retrieveDatesForNextMonth() {
    return controller.retrieveDatesForMonth(nextMonth);
  }

  /// Returns the number of days to skip at the beginning of the current month.
  int retrieveDeltaForMonth() {
    return controller.retrieveDeltaForMonth(currentMonth);
  }

  /// Returns the number of days to skip at the beginning of the next month.
  int retrieveDeltaForNextMonth() {
    return controller.retrieveDeltaForMonth(nextMonth);
  }

  void setDateRange(DateRange? dateRange) {
    _streamController.add(null);

    if (dateRange == null) {
      controller.onDateRangeChangedExternally(null);
      return;
    }

    controller.onDateRangeChangedExternally(dateRange);
    currentMonth = dateRange.start;
  }
}

/// A function that builds a day tile for the date range picker.
///
/// * [dayModel] - The model for the day tile to be built.
/// * [theme] - The theme to apply to the day tile.
/// * [onTap] - A callback function to be called when the day tile is tapped.
Widget kDayTileBuilder(
  BuildContext context,
  DayModel dayModel,
  ValueChanged<DateTime> onTap,
  List<DateTime> stopHosting,
  List<DateManagement> plusPrice,
) {
  TextStyle combinedTextStyle = context.textTheme.krSubtext2.copyWith(fontWeight: FontWeight.w400);
  TextStyle selectedTextStyle = context.textTheme.krSubtext2.copyWith(color: Colors.white);
  TextStyle todayTextStyle = context.textTheme.krBody2.copyWith(fontWeight: FontWeight.bold);

  dayModel.date.weekday == DateTime.sunday ? combinedTextStyle = combinedTextStyle.copyWith(color: Colors.red) : combinedTextStyle = combinedTextStyle;

  dayModel.date.weekday == DateTime.saturday ? combinedTextStyle = combinedTextStyle.copyWith(color: Colors.blue) : combinedTextStyle = combinedTextStyle;

  int? price;

  if (dayModel.isToday) {
    combinedTextStyle = todayTextStyle;
  }

  if (dayModel.isInRange) {
    combinedTextStyle = selectedTextStyle;
  }

  if (dayModel.isSelected) {
    combinedTextStyle = selectedTextStyle;
  }

  if (!dayModel.isSelectable) {
    combinedTextStyle = combinedTextStyle.copyWith(decoration: TextDecoration.lineThrough, color: Colors.grey);
  }
  for(DateTime k in stopHosting){
    if (dayModel.date == k){
      combinedTextStyle = combinedTextStyle.copyWith(color: Colors.white, decoration: TextDecoration.none, background: Paint()..style = PaintingStyle.stroke..color = gray5..strokeWidth = 15..strokeJoin = StrokeJoin.round..strokeCap = StrokeCap.round);
    }
  }
  for(DateManagement k in plusPrice){
    if (dayModel.date == k.date){
      price = k.amount;
    }
  }



  return DayTileWidget(
    price: price ?? 0,
    textStyle: combinedTextStyle,
    color: dayModel.isSelected || dayModel.isInRange ? mainJeJuBlue : null,
    text: dayModel.date.day.toString(),
    value: dayModel.date,
    onTap: dayModel.isSelectable ? onTap : null,
    radius: dayModel.isEnd
        ? const BorderRadius.horizontal(
            right: Radius.circular(45),
          )
        : dayModel.isStart
            ? const BorderRadius.horizontal(
                left: Radius.circular(45),
              )
            : BorderRadius.zero,
  );
}

/// A widget that displays the names of the days of the week for the date range picker.
class DayNamesRow extends StatelessWidget {
  /// Creates a [DayNamesRow].
  ///
  /// * [key] - The [Key] for this widget.
  /// * [textStyle] - The style to apply to the day names text.
  /// * [weekDays] - The names of the days of the week to display. If null, defaults to the default week days.
  const DayNamesRow({
    Key? key,
    required this.textStyle,
    required this.weekDays,
  }) : super(key: key);

  final TextStyle textStyle;
  final List<String> weekDays;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var day in weekDays)
          Expanded(
            child: Center(
              child: Text(
                day,
                style: textStyle,
              ),
            ),
          ),
      ],
    );
  }
}

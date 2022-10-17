import 'package:calendar/calendar/calendar.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:calendar/calendar/styles/calendar_ui_util.dart';
import 'package:calendar/calendar/widgets/interval_mode/default_calendar_item.dart';
import 'package:calendar/calendar/widgets/interval_mode/selected_calendar_item.dart';
import 'package:calendar/calendar/widgets/interval_mode/selected_interval_calendar_item.dart';
import 'package:calendar/calendar/widgets/single_mode/calendar_item.dart';
import 'package:flutter/material.dart';

class Month extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onChanged;
  final DateTime? selectedDayStart;
  final DateTime? selectedDayEnd;
  final DateTime? selectedDay;
  final bool isInterval;
  final List<DateTime>? availableDaysList;
  final List<DateTime>? noAvailableDaysList;

  const Month({
    Key? key,
    required this.date,
    required this.onChanged,
    this.selectedDayStart,
    this.selectedDayEnd,
    required this.isInterval,
    this.availableDaysList,
    this.noAvailableDaysList,
    this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            CalendarUIUtil.dateConversion(date),
            style: const TextStyle(
              color: CalendarColors.black500,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _MonthDays(
            date: date,
            onChanged: onChanged,
            selectedDateStart: selectedDayStart,
            selectedDateEnd: selectedDayEnd,
            selectedDay: selectedDay,
            isInterval: isInterval,
            availableDaysList: availableDaysList,
            noAvailableDaysList: noAvailableDaysList,
          ),
        ],
      ),
    );
  }
}

class _MonthDays extends StatefulWidget {
  final DateTime date;
  final DateTime? selectedDateStart;
  final DateTime? selectedDateEnd;
  final DateTime? selectedDay;
  final Function(DateTime) onChanged;
  final bool isInterval;
  final List<DateTime>? availableDaysList;
  final List<DateTime>? noAvailableDaysList;

  const _MonthDays({
    Key? key,
    required this.date,
    required this.onChanged,
    this.selectedDateStart,
    this.selectedDateEnd,
    required this.isInterval,
    this.availableDaysList,
    this.noAvailableDaysList,
    this.selectedDay,
  }) : super(key: key);

  @override
  State<_MonthDays> createState() => _MonthDaysState();
}

class _MonthDaysState extends State<_MonthDays> {
  bool _stopPainting = false;
  int _day = 0;
  late int _monthDays;
  late int _startWeekDay;

  @override
  void initState() {
    _monthDays = DateTime(widget.date.year, widget.date.month + 1, 0).day;
    _startWeekDay = widget.date.weekday - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.3125,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 7,
      ),
      itemCount: _monthDays >= 30 && _startWeekDay >= 5 ? 42 : 35,
      itemBuilder: (context, index) {
        if (widget.isInterval) {
          return _calendarIntervalItem(index);
        } else {
          return _calendarItem(index);
        }
      },
    );
  }

  Widget _calendarItem(int index) {
    if (_startWeekDay == index) {
      _stopPainting = true;
    }
    if (_stopPainting) {
      _day++;
      if (_day <= _monthDays) {
        return CalendarItem(
          date: DateTime(widget.date.year, widget.date.month, _day),
          dayType: _dayTypeHandler(),
          selectedDay: widget.selectedDay,
          onTap: (value) {
            widget.onChanged(
              DateTime(widget.date.year, widget.date.month, value),
            );
          },
        );
      }
    }
    return const SizedBox();
  }

  DayType _dayTypeHandler() {
    DateTime date = DateTime(widget.date.year, widget.date.month, _day);
    if (widget.availableDaysList != null &&
        widget.availableDaysList!.contains(date)) {
      return DayType.availableDay;
    } else if (widget.noAvailableDaysList != null &&
        widget.noAvailableDaysList!.contains(date)) {
      return DayType.noAvailableDay;
    } else {
      return DayType.defaultDay;
    }
  }

  Widget _calendarIntervalItem(int index) {
    if (_startWeekDay == index) {
      _stopPainting = true;
    }
    if (_stopPainting) {
      _day++;
      if (_day <= _monthDays) {
        ///Проверка выбранной даты, если она соответсвует первой и последней, то отображем ее в черном квадрате
        DateTime date = DateTime(widget.date.year, widget.date.month, _day);
        if ((widget.selectedDateStart != null &&
                date == widget.selectedDateStart!) ||
            (widget.selectedDateEnd != null &&
                date == widget.selectedDateEnd!)) {
          return SelectedCalendarItem(
            date: date,
            onTap: (value) {
              widget.onChanged(
                DateTime(widget.date.year, widget.date.month, value),
              );
            },
          );
        }
        if ((widget.selectedDateStart != null &&
                date.isAfter(widget.selectedDateStart!)) &&
            (widget.selectedDateEnd != null &&
                date.isBefore(widget.selectedDateEnd!))) {
          return SelectedIntervalCalendarItem(
            date: date,
            onTap: (value) {
              widget.onChanged(
                DateTime(widget.date.year, widget.date.month, value),
              );
            },
          );
        }
        return DefaultCalendarItem(
          date: date,
          onTap: (value) {
            widget.onChanged(
              DateTime(widget.date.year, widget.date.month, value),
            );
          },
        );
      }
    }
    return const SizedBox();
  }
}

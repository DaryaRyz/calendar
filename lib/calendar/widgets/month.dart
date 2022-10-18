import 'package:calendar/calendar/calendar.dart';
import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:calendar/calendar/styles/calendar_ui_util.dart';
import 'package:calendar/calendar/widgets/interval_mode/default_calendar_item.dart';
import 'package:calendar/calendar/widgets/interval_mode/selected_calendar_item.dart';
import 'package:calendar/calendar/widgets/interval_mode/selected_interval_calendar_item.dart';
import 'package:calendar/calendar/widgets/single_mode/calendar_item.dart';
import 'package:flutter/material.dart';

class Month extends StatelessWidget {
  final DateTime date;
  final CalendarController selectedDateController;
  final bool isInterval;
  final List<DateTime>? availableDatesList;
  final List<DateTime>? noAvailableDatesList;

  const Month({
    Key? key,
    required this.date,
    required this.selectedDateController,
    required this.isInterval,
    this.availableDatesList,
    this.noAvailableDatesList,
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
            selectedDateController: selectedDateController,
            isInterval: isInterval,
            availableDatesList: availableDatesList,
            noAvailableDatesList: noAvailableDatesList,
          ),
        ],
      ),
    );
  }
}

class _MonthDays extends StatefulWidget {
  final DateTime date;
  final CalendarController selectedDateController;
  final bool isInterval;
  final List<DateTime>? availableDatesList;
  final List<DateTime>? noAvailableDatesList;

  const _MonthDays({
    Key? key,
    required this.date,
    required this.isInterval,
    this.availableDatesList,
    this.noAvailableDatesList,
    required this.selectedDateController,
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
    return SizedBox(
      height: _monthDays >= 30 && _startWeekDay >= 5 ? 240 : 200,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.3125,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 7,
        ),
        itemCount: _monthDays >= 30 && _startWeekDay >= 5 ? 42 : 35,
        itemBuilder: (context, index) {
          if (widget.isInterval) {
            return SizedBox();
           // return _calendarIntervalItem(index);
          } else {
            return _calendarItem(index);
          }
        },
      ),
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
          selectedDateController: widget.selectedDateController,
        );
      }
    }
    return const SizedBox();
  }

  DayType _dayTypeHandler() {
    DateTime date = DateTime(widget.date.year, widget.date.month, _day);
    if (widget.availableDatesList != null &&
        widget.availableDatesList!.contains(date)) {
      return DayType.availableDay;
    } else if (widget.noAvailableDatesList != null &&
        widget.noAvailableDatesList!.contains(date)) {
      return DayType.noAvailableDay;
    } else {
      return DayType.defaultDay;
    }
  }

  // Widget _calendarIntervalItem(int index) {
  //   if (_startWeekDay == index) {
  //     _stopPainting = true;
  //   }
  //   if (_stopPainting) {
  //     _day++;
  //     if (_day <= _monthDays) {
  //       ///Проверка выбранной даты, если она соответсвует первой и последней, то отображем ее в черном квадрате
  //       DateTime date = DateTime(widget.date.year, widget.date.month, _day);
  //       if ((widget.selectedDateStart.date != null &&
  //               date == widget.selectedDateStart.date) ||
  //           (widget.selectedDateEnd.date != null &&
  //               date == widget.selectedDateEnd.date)) {
  //         return SelectedCalendarItem(
  //           date: date,
  //           selectedStartDate: widget.selectedDateStart,
  //           selectedEndDate: widget.selectedDateEnd,
  //         );
  //       }
  //       if ((widget.selectedDateStart.date != null &&
  //               date.isAfter(widget.selectedDateStart.date!)) &&
  //           (widget.selectedDateEnd.date != null &&
  //               date.isBefore(widget.selectedDateEnd.date!))) {
  //         return SelectedIntervalCalendarItem(
  //           date: date,
  //           selectedStartDate: widget.selectedDateStart,
  //           selectedEndDate: widget.selectedDateEnd,
  //         );
  //       }
  //       return DefaultCalendarItem(
  //         date: date,
  //         selectedStartDate: widget.selectedDateStart,
  //         selectedEndDate: widget.selectedDateEnd,
  //       );
  //     }
  //   }
  //   return const SizedBox();
  // }
}

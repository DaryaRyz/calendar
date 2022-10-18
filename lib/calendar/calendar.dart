import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:calendar/calendar/widgets/month.dart';
import 'package:calendar/calendar/widgets/week_days.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final bool isInterval;
  final List<DateTime>? availableDatesList;
  final List<DateTime>? noAvailableDatesList;
  final CalendarController selectedDateController;

  const Calendar({
    Key? key,
    required this.isInterval,
    this.availableDatesList,
    this.noAvailableDatesList,
    required this.selectedDateController,
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final _dateNow = DateTime.now();

  @override
  void initState() {
    // _selectedDateController.addListener(() {
    //   print(
    //       'day: ${_selectedDateController.singleDate}\nstart: ${_selectedDateController.startDate}\nend: ${_selectedDateController.endDate}\n\n');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(widget.isInterval),
      color: CalendarColors.black20,
      child: Column(
        children: [
          const WeekDays(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                  6,
                  (index) => Month(
                    selectedDateController: widget.selectedDateController,
                    isInterval: widget.isInterval,
                    availableDatesList: widget.availableDatesList,
                    noAvailableDatesList: widget.noAvailableDatesList,
                    date: DateTime.utc(_dateNow.year, _dateNow.month + index),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum DayType {
  availableDay,
  noAvailableDay,
  defaultDay,
}

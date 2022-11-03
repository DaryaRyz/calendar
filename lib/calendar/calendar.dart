import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/utils/calendar_colors.dart';
import 'package:calendar/calendar/widgets/month.dart';
import 'package:calendar/calendar/widgets/week_days.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final bool isInterval;
  final List<DateTime>? availableDatesList;
  final List<DateTime>? noAvailableDatesList;
  final int monthQuantity;
  final Function(
    DateTime? singleDate,
    DateTime? startDate,
    DateTime? endDate,
  ) onChange;

  const Calendar({
    Key? key,
    required this.isInterval,
    this.availableDatesList,
    this.noAvailableDatesList,
    this.monthQuantity = 6,
    required this.onChange,
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
 final _selectedDateController = CalendarController();

  @override
  void initState() {
      _selectedDateController.addListener(() {
        widget.onChange(
          _selectedDateController.singleDate,
          _selectedDateController.startDate,
          _selectedDateController.endDate,
        );
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      color: CalendarColors.black20,
      child: Column(
        children: [
          const WeekDays(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                  widget.monthQuantity,
                  (index) => Month(
                    selectedDateController: _selectedDateController,
                    isInterval: widget.isInterval,
                    availableDatesList: widget.availableDatesList,
                    noAvailableDatesList: widget.noAvailableDatesList,
                    date: DateTime.utc(
                        DateTime.now().year, DateTime.now().month + index),
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

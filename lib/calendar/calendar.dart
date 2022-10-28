import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:calendar/calendar/widgets/month.dart';
import 'package:calendar/calendar/widgets/week_days.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  final bool isInterval;
  final List<DateTime>? availableDatesList;
  final List<DateTime>? noAvailableDatesList;
  final CalendarController selectedDateController;
  final int monthQuantity;

  const Calendar({
    Key? key,
    required this.isInterval,
    this.availableDatesList,
    this.noAvailableDatesList,
    required this.selectedDateController,
    this.monthQuantity = 6,
  }) : super(key: key);

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
                  monthQuantity,
                  (index) => Month(
                    selectedDateController: selectedDateController,
                    isInterval: isInterval,
                    availableDatesList: availableDatesList,
                    noAvailableDatesList: noAvailableDatesList,
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

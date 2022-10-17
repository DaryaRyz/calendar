import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:calendar/calendar/styles/calendar_strings.dart';
import 'package:flutter/material.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CalendarColors.white,
      child: Row(
        children: List.generate(
          CalendarStrings.weekDays.length,
          (index) => _WeekDay(
            weekDay: CalendarStrings.weekDays[index],
          ),
        ),
      ),
    );
  }
}

class _WeekDay extends StatelessWidget {
  final String weekDay;

  const _WeekDay({
    Key? key,
    required this.weekDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Center(
          child: Text(
            weekDay,
            style: const TextStyle(
              color: CalendarColors.black300,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

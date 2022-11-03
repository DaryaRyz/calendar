import 'package:calendar/calendar/utils/calendar_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> date = [];
    date.addAll(dateTimeSymbolMap()['ru'].STANDALONESHORTWEEKDAYS);
    date.add(date[0]);
    date.removeAt(0);

    return Container(
      color: CalendarColors.white,
      child: Row(
        children: List.generate(
          date.length,
          (index) => _WeekDay(
            name: date[index].substring(0, 1).toUpperCase() +
                date[index].substring(1, date[index].length),
          ),
        ),
      ),
    );
  }
}

class _WeekDay extends StatelessWidget {
  final String name;

  const _WeekDay({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Center(
          child: Text(
            name,
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

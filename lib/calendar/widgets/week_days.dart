import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   List<String> _date = dateTimeSymbolMap()['ru'].STANDALONESHORTWEEKDAYS;
   //TODO: поменять местами дни недели
    return Container(
      color: CalendarColors.white,
      child: Row(
        children: List.generate(
          _date.length,
          (index) => _WeekDay(
            name: _date[index],
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

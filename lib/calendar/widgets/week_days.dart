import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   List<String> date = dateTimeSymbolMap()['ru'].STANDALONESHORTWEEKDAYS;
   List<String> weekDays = [];
   for(int i = 1; i < date.length; i++){
     weekDays.add(date[i]);
   }
   weekDays.add(date[0]);

    return Container(
      color: CalendarColors.white,
      child: Row(
        children: List.generate(
          weekDays.length,
          (index) => _WeekDay(
            name: weekDays[index],
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

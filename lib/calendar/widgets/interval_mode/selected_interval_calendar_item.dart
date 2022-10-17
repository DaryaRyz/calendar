import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class SelectedIntervalCalendarItem extends StatefulWidget {
  final DateTime date;
  final Function(int) onTap;

  const SelectedIntervalCalendarItem({
    Key? key,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SelectedIntervalCalendarItem> createState() =>
      _SelectedIntervalCalendarItemState();
}

class _SelectedIntervalCalendarItemState
    extends State<SelectedIntervalCalendarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: CalendarColors.black150,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          widget.onTap(widget.date.day);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 2),
          primary: Colors.black87,
        ),
        child: Text(
          widget.date.day.toString(),
          style: const TextStyle(
            color: CalendarColors.black500,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

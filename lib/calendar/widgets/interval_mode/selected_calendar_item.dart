import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class SelectedCalendarItem extends StatefulWidget {
  final DateTime date;
  final Function(int) onTap;

  const SelectedCalendarItem({
    Key? key,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SelectedCalendarItem> createState() => _SelectedCalendarItemState();
}

class _SelectedCalendarItemState extends State<SelectedCalendarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CalendarColors.black500,
      ),
      child: TextButton(
        onPressed: () {
          widget.onTap(widget.date.day);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: Colors.black87,
        ),
        child: Text(
          widget.date.day.toString(),
          style: const TextStyle(
            color: CalendarColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

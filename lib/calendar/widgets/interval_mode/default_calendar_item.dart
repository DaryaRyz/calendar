import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class DefaultCalendarItem extends StatefulWidget {
  final DateTime date;
  final Function(int) onTap;

  const DefaultCalendarItem({
    Key? key,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  State<DefaultCalendarItem> createState() => _DefaultCalendarItemState();
}

class _DefaultCalendarItemState extends State<DefaultCalendarItem> {
  final DateTime _dateNow = DateTime.now();
  late bool _isActiveItem;

  @override
  void initState() {
    if (_dateNow.day > widget.date.day &&
        _dateNow.month == widget.date.month) {
      _isActiveItem = false;
    } else {
      _isActiveItem = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: TextButton(
        onPressed: _isActiveItem ? () {
          widget.onTap(widget.date.day);
        } : null,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: Colors.black87,
        ),
        child: Text(
          widget.date.day.toString(),
          style: TextStyle(
            color: _isActiveItem
                ? CalendarColors.black500
                : CalendarColors.black300,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

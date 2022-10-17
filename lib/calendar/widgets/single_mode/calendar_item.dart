import 'package:calendar/calendar/calendar.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class CalendarItem extends StatefulWidget {
  final DateTime date;
  final Function(int) onTap;
  final DayType dayType;
  final DateTime? selectedDay;

  const CalendarItem({
    Key? key,
    required this.date,
    required this.onTap,
    required this.dayType,
    this.selectedDay,
  }) : super(key: key);

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  final DateTime _dateNow = DateTime.now();
  late bool _isActiveItem;

  @override
  void initState() {
    if (_dateNow.day > widget.date.day && _dateNow.month == widget.date.month) {
      _isActiveItem = false;
    } else {
      _isActiveItem = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _colorHandler(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _dateNow.day == widget.date.day &&
                  _dateNow.month == widget.date.month
              ? CalendarColors.black500
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: TextButton(
        onPressed: _isActiveItem
            ? widget.dayType == DayType.availableDay
                ? () {
                    widget.onTap(widget.date.day);
                  }
                : null
            : null,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: Colors.black87,
        ),
        child: Text(
          widget.date.day.toString(),
          style: _textStyleHandler(),
        ),
      ),
    );
  }

  TextStyle _textStyleHandler() {
    if(widget.selectedDay == widget.date){
      return const TextStyle(
        color: CalendarColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );
    }
    if (!_isActiveItem) {
      return const TextStyle(
        color: CalendarColors.black300,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
    } else {
      switch (widget.dayType) {
        case DayType.availableDay:
          return const TextStyle(
            color: CalendarColors.black500,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          );
        case DayType.noAvailableDay:
          return const TextStyle(
            color: CalendarColors.black300,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          );
        case DayType.defaultDay:
          return const TextStyle(
            color: CalendarColors.black500,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          );
      }
    }
  }

  Color _colorHandler() {
    if (widget.selectedDay == widget.date) {
      return CalendarColors.black500;
    }
    switch (widget.dayType) {
      case DayType.availableDay:
        return CalendarColors.white;
      case DayType.noAvailableDay:
        return CalendarColors.black150;
      case DayType.defaultDay:
        return Colors.transparent;
    }
  }
}

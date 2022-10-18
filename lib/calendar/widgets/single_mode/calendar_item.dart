import 'package:calendar/calendar/calendar.dart';
import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class CalendarItem extends StatefulWidget {
  final DateTime date;
  final DayType dayType;
  final CalendarController selectedDateController;

  const CalendarItem({
    Key? key,
    required this.date,
    required this.dayType,
    required this.selectedDateController,
  }) : super(key: key);

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  final DateTime _dateNow = DateTime.now();

  ///прошедшие (недоступные) даты _isActualDate = false
  late bool _isActualDate;
  bool _isSelected = false;

  @override
  void initState() {
    ///для оптимизации каждая ячейка слушает контроллер и
    ///перерисовывается только в том случае, если она была до этого
    /// выбрана (_isSelected = true)
    widget.selectedDateController.addListener(() {
      if (_isSelected) {
        if (mounted) {
          setState(() {
            _isSelected = false;
          });
        }
      }
    });
    if (widget.selectedDateController.singleDate == widget.date) {
      _isSelected = true;
    }

    ///если дата, которая отрисовывается в текущий момент, меньше сегодняшней и
    ///их месяцы совпадают, то она становится прошедшей(_isActualDate = false)
    if (_dateNow.day > widget.date.day && _dateNow.month == widget.date.month) {
      _isActualDate = false;
    } else {
      _isActualDate = true;
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
        onPressed: _isActualDate && widget.dayType == DayType.availableDay
            ? () {
                setState(() {
                  widget.selectedDateController.setSingleDate(widget.date);
                  _isSelected = true;
                });
              }
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
    if (_isSelected) {
      return const TextStyle(
        color: CalendarColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );
    }
    if (!_isActualDate) {
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
    if (_isSelected) {
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

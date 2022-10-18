import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/calendar_date_types.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class SingleModeCalendarItem extends StatefulWidget {
  final DateTime date;
  final SingleDateType dayType;
  final CalendarController selectedDateController;

  const SingleModeCalendarItem({
    Key? key,
    required this.date,
    required this.dayType,
    required this.selectedDateController,
  }) : super(key: key);

  @override
  State<SingleModeCalendarItem> createState() => _SingleModeCalendarItemState();
}

class _SingleModeCalendarItemState extends State<SingleModeCalendarItem> {
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
        onPressed: _isActualDate && widget.dayType == SingleDateType.availableDate
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
        case SingleDateType.availableDate:
          return const TextStyle(
            color: CalendarColors.black500,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          );
        case SingleDateType.noAvailableDate:
          return const TextStyle(
            color: CalendarColors.black300,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          );
        case SingleDateType.defaultDate:
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
      case SingleDateType.availableDate:
        return CalendarColors.white;
      case SingleDateType.noAvailableDate:
        return CalendarColors.black150;
      case SingleDateType.defaultDate:
        return Colors.transparent;
    }
  }
}

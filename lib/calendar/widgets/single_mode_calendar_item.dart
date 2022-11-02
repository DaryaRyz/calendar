import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/calendar_date_types.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class SingleModeCalendarItem extends StatefulWidget {
  final DateTime date;
  final CalendarController selectedDateController;
  final List<DateTime>? availableDatesList;
  final List<DateTime>? noAvailableDatesList;

  const SingleModeCalendarItem({
    Key? key,
    required this.date,
    required this.selectedDateController,
    this.availableDatesList,
    this.noAvailableDatesList,
  }) : super(key: key);

  @override
  State<SingleModeCalendarItem> createState() => _SingleModeCalendarItemState();
}

class _SingleModeCalendarItemState extends State<SingleModeCalendarItem> {
  final DateTime _dateNow = DateTime.now();

  ///прошедшие (недоступные) даты _isActualDate = false
  late bool _isActualDate;
  late SingleDateType _dateType;

  @override
  void initState() {
    _dateType = _dateTypeHandler();

    ///для оптимизации каждая ячейка слушает контроллер и
    ///перезаписывается только в том случае, если она была до этого
    /// выбрана (_dateType == SingleDateType.selectedDate)
    widget.selectedDateController.addListener(() {
      if (_dateType == SingleDateType.selectedDate) {
        if (mounted) {
          setState(() {
            _dateType = _dateTypeHandler();
          });
        }
      }
    });
    if (widget.selectedDateController.singleDate == widget.date) {
      _dateType = SingleDateType.selectedDate;
    }

    ///если дата, которая отрисовывается в текущий момент, меньше сегодняшней и
    ///их месяцы совпадают, то она становится прошедшей(_isActualDate = false)
    _isActualDate =
        _dateNow.day <= widget.date.day || _dateNow.month != widget.date.month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SingleStyleHandler(_dateType).color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _borderColorHandler(),
          width: 2,
        ),
      ),
      child: TextButton(
        onPressed: _onTapHandler,
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
    if (!_isActualDate) {
      return const TextStyle(
        color: CalendarColors.black300,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
    } else {
      return SingleStyleHandler(_dateType).textStyle!;
    }
  }

  SingleDateType _dateTypeHandler() {
    if (widget.availableDatesList != null &&
        widget.availableDatesList!.contains(widget.date)) {
      return SingleDateType.availableDate;
    }
    if (widget.noAvailableDatesList != null &&
        widget.noAvailableDatesList!.contains(widget.date)) {
      return SingleDateType.noAvailableDate;
    }
    return SingleDateType.defaultDate;
  }

  _onTapHandler() {
    if (_isActualDate && _dateType == SingleDateType.availableDate){
      setState(() {
        widget.selectedDateController.setSingleDate(widget.date);
        _dateType = SingleDateType.selectedDate;
      });
    }
  }

  Color _borderColorHandler() {
    if (_dateNow.day == widget.date.day &&
        _dateNow.month == widget.date.month) {
      return CalendarColors.black500;
    }
    return Colors.transparent;
  }
}

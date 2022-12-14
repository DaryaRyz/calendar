import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/calendar_date_types.dart';
import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

class IntervalModeCalendarItem extends StatefulWidget {
  final DateTime date;
  final CalendarController selectedDateController;

  const IntervalModeCalendarItem({
    Key? key,
    required this.date,
    required this.selectedDateController,
  }) : super(key: key);

  @override
  State<IntervalModeCalendarItem> createState() =>
      _IntervalModeCalendarItemState();
}

class _IntervalModeCalendarItemState extends State<IntervalModeCalendarItem> {
  final DateTime _dateNow = DateTime.now();
  late bool _isActualDate;
  IntervalDateType _dateType = IntervalDateType.defaultDate;

  @override
  void initState() {
    ///вызываем присвоение типа для того, чтобы отобразить
    ///диапазон при переключении режима
    _dateTypeHandler(widget.date);

    ///слушаем контроллер и при измении значений переприсваиваем тип даты
    widget.selectedDateController.addListener(() {
      ///для оптимизации, при выборе новой даты, будут
      /// перерисовываться и обнуляться только те ячейки, что были выбраны
      if (_dateType == IntervalDateType.selectedDate ||
          _dateType == IntervalDateType.intervalDate) {
        if (mounted) {
          setState(() {
            _dateType = IntervalDateType.defaultDate;
          });
        }
      }

      ///после того как выбранным предыдущим ячейкам присвоется дефолтный тип,
      ///присваиваем типы новым выбранным ячейкам
      _dateTypeHandler(widget.date);
    });

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
      margin: _marginHandler(),
      decoration: BoxDecoration(
        color: _colorHandler(),
        borderRadius: _borderRadiusHandler(),
      ),
      child: TextButton(
        onPressed: _isActualDate
            ? () {
                _intervalSelectionSaveHandler(widget.date);
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

  EdgeInsetsGeometry? _marginHandler() {
    switch (_dateType) {
      case IntervalDateType.selectedDate:
        return null;
      case IntervalDateType.intervalDate:
        return const EdgeInsets.symmetric(vertical: 3);
      case IntervalDateType.defaultDate:
        return null;
    }
  }

  Color _colorHandler() {
    switch (_dateType) {
      case IntervalDateType.selectedDate:
        return CalendarColors.black500;
      case IntervalDateType.intervalDate:
        return CalendarColors.black150;
      case IntervalDateType.defaultDate:
        return Colors.transparent;
    }
  }

  BorderRadiusGeometry? _borderRadiusHandler() {
    switch (_dateType) {
      case IntervalDateType.selectedDate:
        return BorderRadius.circular(8);
      case IntervalDateType.intervalDate:
        return BorderRadius.circular(8);
      case IntervalDateType.defaultDate:
        return null;
    }
  }

  TextStyle _textStyleHandler() {
    if (!_isActualDate) {
      return const TextStyle(
        color: CalendarColors.black300,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
    } else {
      switch (_dateType) {
        case IntervalDateType.selectedDate:
          return const TextStyle(
            color: CalendarColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );
        case IntervalDateType.intervalDate:
          return const TextStyle(
            color: CalendarColors.black500,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          );
        case IntervalDateType.defaultDate:
          return const TextStyle(
            color: CalendarColors.black500,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          );
      }
    }
  }

  void _intervalSelectionSaveHandler(DateTime value) {

    ///сохранение начальной и конечной даты в контроллер
    if (widget.selectedDateController.startDate != null) {

      ///Если интервал определен и после этого была выбрана дата,
      ///то сбрасываем данные и выбранную дату записываем
      /// в selectedDateController.startDate
      if (widget.selectedDateController.endDate != null) {
        widget.selectedDateController.setEndDate(null);
        widget.selectedDateController.setStartDate(value);
      } else {
        widget.selectedDateController.setEndDate(value);

        if (widget.selectedDateController.startDate!.isAfter(widget.selectedDateController.endDate!)) {
          ///Меняем местами дату начала и конца интервала
          DateTime buffer = widget.selectedDateController.startDate!;
          widget.selectedDateController.setStartDate(widget.selectedDateController.endDate);
          widget.selectedDateController.setEndDate(buffer);
        }
      }
    } else {
      widget.selectedDateController.setStartDate(value);
    }
  }

  void _dateTypeHandler(DateTime date) {

    ///Проверка выбранной даты, если она соответсвует первой и последней,
    ///то отображем ее в черном квадрате
    if ((widget.selectedDateController.startDate != null && date == widget.selectedDateController.startDate) ||
        (widget.selectedDateController.endDate != null && date == widget.selectedDateController.endDate)) {
      if (mounted) {
        setState(() {
          _dateType = IntervalDateType.selectedDate;
        });
      }
    } else if ((widget.selectedDateController.startDate != null && date.isAfter(widget.selectedDateController.startDate!)) &&
        (widget.selectedDateController.endDate != null && date.isBefore(widget.selectedDateController.endDate!))) {
      if (mounted) {
        setState(() {
          _dateType = IntervalDateType.intervalDate;
        });
      }
    }
  }
}

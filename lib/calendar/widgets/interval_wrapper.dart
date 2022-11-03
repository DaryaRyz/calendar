import 'package:calendar/calendar/calendar_controller.dart';
import 'package:calendar/calendar/calendar_date_types.dart';
import 'package:flutter/material.dart';

class IntervalWrapper extends StatefulWidget {
  final Widget child;
  final DateTime date;
  final int index;
  final int startWeekDay;
  final int monthDays;
  final CalendarController selectedDateController;

  const IntervalWrapper({
    Key? key,
    required this.child,
    required this.date,
    required this.index,
    required this.selectedDateController,
    required this.startWeekDay,
    required this.monthDays,
  }) : super(key: key);

  @override
  State<IntervalWrapper> createState() => _IntervalWrapperState();
}

class _IntervalWrapperState extends State<IntervalWrapper> {
  IntervalWrapperType _type = IntervalWrapperType.none;

  @override
  void initState() {
    setState(() {
      _type = _intervalWrapperType(date: widget.date, index: widget.index);
    });

    widget.selectedDateController.addListener(() {
      ///для оптимизации, при выборе новой даты, будут
      /// перерисовываться и обнуляться только те ячейки, что были выбраны
      if (_type != IntervalWrapperType.none) {
        if (mounted) {
          setState(() {
            _type = IntervalWrapperType.none;
          });
        }
      }

      ///после того как выбранным предыдущим ячейкам присвоется дефолтный тип,
      ///присваиваем типы новым выбранным ячейкам
      if (mounted) {
        setState(() {
          _type = _intervalWrapperType(date: widget.date, index: widget.index);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: IntervalWrapperStyleHandler(_type).color,
          margin: IntervalWrapperStyleHandler(_type).margin,
        ),
        widget.child,
      ],
    );
  }

  IntervalWrapperType _intervalWrapperType({
    required DateTime date,
    required int index,
  }) {
    ///Проверка на начальную выбронную дату, скругляем левую сторону
    if ((widget.selectedDateController.startDate != null &&
        date == widget.selectedDateController.startDate)) {
      return IntervalWrapperType.left;

      ///Проверка на конечную выбронную дату, скругляем правую сторону
    } else if ((widget.selectedDateController.endDate != null &&
        date == widget.selectedDateController.endDate)) {
      return IntervalWrapperType.right;

      ///Проверка на даты которые находятся в выбранном диапозоне
    } else if ((widget.selectedDateController.startDate != null &&
            date.isAfter(widget.selectedDateController.startDate!)) &&
        (widget.selectedDateController.endDate != null &&
            date.isBefore(widget.selectedDateController.endDate!))) {
      ///Исключение, когда новый месяц начинается с вокресенья. Скругляем со всех сторон
      if ((index + 1) % 7 == 0 && widget.startWeekDay == index) {
        return IntervalWrapperType.none;

        ///Исключение, когда месяц заканчивается в понедельник. Скругляем со всех сторон
      } else if ((index) % 7 == 0 && date.day == widget.monthDays) {
        return IntervalWrapperType.none;

        ///Скругляем левую сторону у дат которые в пн
      } else if (index % 7 == 0 || widget.startWeekDay == index) {
        return IntervalWrapperType.left;

        ///Скругляем правую сторону у дат которые в вс
      } else if ((index + 1) % 7 == 0 || date.day == widget.monthDays) {
        return IntervalWrapperType.right;
      } else {
        ///Не скругляем углы
        return IntervalWrapperType.full;
      }
    } else {
      ///Нет фона
      return IntervalWrapperType.none;
    }
  }
}

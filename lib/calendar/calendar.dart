import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:calendar/calendar/widgets/month.dart';
import 'package:calendar/calendar/widgets/week_days.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final bool isInterval;
  final List<DateTime>? availableDaysList;
  final List<DateTime>? noAvailableDaysList;

  const Calendar({
    Key? key,
    required this.isInterval,
    this.availableDaysList,
    this.noAvailableDaysList,
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final _dateNow = DateTime.now();
  DateTime? _selectedDayStart;
  DateTime? _selectedDayEnd;
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CalendarColors.black20,
      child: Column(
        children: [
          const WeekDays(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                  6,
                  (index) => Month(
                    key: UniqueKey(),
                    selectedDayStart: _selectedDayStart,
                    selectedDayEnd: _selectedDayEnd,
                    selectedDay: _selectedDay,
                    isInterval: widget.isInterval,
                    availableDaysList: widget.availableDaysList,
                    noAvailableDaysList: widget.noAvailableDaysList,
                    date: DateTime.utc(_dateNow.year, _dateNow.month + index),
                    onChanged: (value) {
                      if (widget.isInterval) {
                        _intervalSelectionMode(value);
                      } else {
                        setState(() {
                          _selectedDay = value;
                        });
                      }
                      print(
                          'day: $_selectedDay\nstart: $_selectedDayStart\nend: $_selectedDayEnd\n\n');
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _intervalSelectionMode(DateTime value) {
    if (_selectedDayStart != null) {
      ///Если интервал определен и после этого была выбрана дата,
      ///то сбрасываем данные и выбранную дату записываем в _selectedDayStart
      if (_selectedDayEnd != null && value != _selectedDayEnd) {
        setState(() {
          _selectedDayEnd = null;
          _selectedDayStart = value;
        });
      } else {
        setState(() {
          _selectedDayEnd = value;

          ///Меняем местами дату начала и конца интервала
          if (_selectedDayStart!.isAfter(_selectedDayEnd!)) {
            DateTime buffer = _selectedDayStart!;
            _selectedDayStart = _selectedDayEnd;
            _selectedDayEnd = buffer;
          }
        });
      }
    } else {
      setState(() {
        _selectedDayStart = value;
      });
    }
  }
}

enum DayType {
  availableDay,
  noAvailableDay,
  defaultDay,
}

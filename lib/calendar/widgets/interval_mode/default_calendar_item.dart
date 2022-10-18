// import 'package:calendar/calendar/calendar_controller.dart';
// import 'package:calendar/calendar/styles/calendar_colors.dart';
// import 'package:flutter/material.dart';
//
// class DefaultCalendarItem extends StatefulWidget {
//   final DateTime date;
//   final CalendarController selectedStartDate;
//   final CalendarController selectedEndDate;
//
//   const DefaultCalendarItem({
//     Key? key,
//     required this.date,
//     required this.selectedStartDate,
//     required this.selectedEndDate,
//   }) : super(key: key);
//
//   @override
//   State<DefaultCalendarItem> createState() => _DefaultCalendarItemState();
// }
//
// class _DefaultCalendarItemState extends State<DefaultCalendarItem> {
//   final DateTime _dateNow = DateTime.now();
//   late bool _isActiveItem;
//
//   @override
//   void initState() {
//     if (_dateNow.day > widget.date.day && _dateNow.month == widget.date.month) {
//       _isActiveItem = false;
//     } else {
//       _isActiveItem = true;
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.transparent,
//       ),
//       child: TextButton(
//         onPressed: _isActiveItem
//             ? () {
//                 _intervalSelectionMode(widget.date);
//               }
//             : null,
//         style: TextButton.styleFrom(
//           padding: EdgeInsets.zero,
//           primary: Colors.black87,
//         ),
//         child: Text(
//           widget.date.day.toString(),
//           style: TextStyle(
//             color: _isActiveItem
//                 ? CalendarColors.black500
//                 : CalendarColors.black300,
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _intervalSelectionMode(DateTime value) {
//     if (widget.selectedStartDate.date != null) {
//       ///Если интервал определен и после этого была выбрана дата,
//       ///то сбрасываем данные и выбранную дату записываем в _selectedDayStart
//       if (widget.selectedEndDate.date != null &&
//           value != widget.selectedEndDate.date) {
//         setState(() {
//           widget.selectedEndDate.setDate(null);
//           widget.selectedStartDate.setDate(value);
//         });
//       } else {
//         setState(() {
//           widget.selectedEndDate.setDate(value);
//           if (widget.selectedStartDate.date!
//               .isAfter(widget.selectedEndDate.date!)) {
//             DateTime buffer = widget.selectedStartDate.date!;
//             widget.selectedStartDate.setDate(widget.selectedEndDate.date);
//             widget.selectedEndDate.setDate(buffer);
//           }
//         });
//
//         ///Меняем местами дату начала и конца интервала
//       }
//     } else {
//       setState(() {
//         widget.selectedStartDate.setDate(value);
//       });
//     }
//   }
// }

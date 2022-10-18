// import 'package:calendar/calendar/calendar_controller.dart';
// import 'package:calendar/calendar/styles/calendar_colors.dart';
// import 'package:flutter/material.dart';
//
// class SelectedCalendarItem extends StatefulWidget {
//   final DateTime date;
//   final CalendarController selectedStartDate;
//   final CalendarController selectedEndDate;
//
//   const SelectedCalendarItem({
//     Key? key,
//     required this.date,
//     required this.selectedStartDate,
//     required this.selectedEndDate,
//   }) : super(key: key);
//
//   @override
//   State<SelectedCalendarItem> createState() => _SelectedCalendarItemState();
// }
//
// class _SelectedCalendarItemState extends State<SelectedCalendarItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: CalendarColors.black500,
//       ),
//       child: TextButton(
//         onPressed: () {
//           _intervalSelectionMode(widget.date);
//         },
//         style: TextButton.styleFrom(
//           padding: EdgeInsets.zero,
//           primary: Colors.black87,
//         ),
//         child: Text(
//           widget.date.day.toString(),
//           style: const TextStyle(
//             color: CalendarColors.white,
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

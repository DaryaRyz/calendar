import 'package:calendar/calendar/styles/calendar_colors.dart';
import 'package:flutter/material.dart';

enum SingleDateType {
  availableDate,
  noAvailableDate,
  defaultDate,
  selectedDate,
}

enum IntervalDateType {
  selectedDate,
  intervalDate,
  defaultDate,
}

extension IntervalStyleHandler on IntervalDateType {
  Color? get color => {
        IntervalDateType.selectedDate: CalendarColors.black500,
        IntervalDateType.intervalDate: CalendarColors.black150,
        IntervalDateType.defaultDate: Colors.transparent,
      }[this];

  EdgeInsetsGeometry? get margin => {
        IntervalDateType.selectedDate: null,
        IntervalDateType.intervalDate: const EdgeInsets.symmetric(vertical: 3),
        IntervalDateType.defaultDate: null,
      }[this];

  BorderRadiusGeometry? get borderRadius => {
        IntervalDateType.selectedDate: BorderRadius.circular(8),
        IntervalDateType.intervalDate: BorderRadius.circular(8),
        IntervalDateType.defaultDate: null,
      }[this];

  TextStyle? get textStyle => {
        IntervalDateType.selectedDate: const TextStyle(
          color: CalendarColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        IntervalDateType.intervalDate: const TextStyle(
          color: CalendarColors.black500,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        IntervalDateType.defaultDate: const TextStyle(
          color: CalendarColors.black500,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      }[this];
}

extension SingleStyleHandler on SingleDateType {
  Color? get color => {
        SingleDateType.availableDate: CalendarColors.white,
        SingleDateType.noAvailableDate: CalendarColors.black150,
        SingleDateType.defaultDate: Colors.transparent,
        SingleDateType.selectedDate: CalendarColors.black500,
      }[this];

  TextStyle? get textStyle => {
        SingleDateType.availableDate: const TextStyle(
          color: CalendarColors.black500,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SingleDateType.noAvailableDate: const TextStyle(
          color: CalendarColors.black300,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        SingleDateType.defaultDate: const TextStyle(
          color: CalendarColors.black500,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        SingleDateType.selectedDate: const TextStyle(
          color: CalendarColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      }[this];
}

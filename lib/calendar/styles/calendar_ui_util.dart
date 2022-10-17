import 'package:calendar/calendar/styles/calendar_strings.dart';

class CalendarUIUtil{
  static String dateConversion(DateTime date){
    return '${CalendarStrings.month[date.month - 1]} ${date.year}';
  }
}
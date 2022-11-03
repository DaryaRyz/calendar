import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarUIUtil{
  static String dateConversion(DateTime date){
    initializeDateFormatting('ru');
    String useDate = DateFormat('yMMMM', 'ru').format(date);
    String result = useDate.replaceRange(0, 1, useDate[0].toUpperCase());
    return result.replaceRange(result.length - 3, result.length, '');
  }
}
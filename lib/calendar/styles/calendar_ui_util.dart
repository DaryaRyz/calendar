import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarUIUtil{
  static String dateConversion(DateTime date){
    initializeDateFormatting('ru');
    String _date = DateFormat('yMMMM', 'ru').format(date);
    String result = _date.replaceRange(0, 1, _date[0].toUpperCase());
    return result.replaceRange(result.length - 3, result.length, '');
  }
}
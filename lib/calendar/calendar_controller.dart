import 'package:flutter/cupertino.dart';

class CalendarController extends ChangeNotifier {
  DateTime? _singleDate;
  DateTime? _startDate;
  DateTime? _endDate;

  void setStartDate(DateTime? date) {
    _startDate = date;
    notifyListeners();
  }

  DateTime? get startDate {
    return _startDate;
  }

  void setEndDate(DateTime? date) {
    _endDate = date;
    notifyListeners();
  }

  DateTime? get endDate {
    return _endDate;
  }

  void setSingleDate(DateTime? date) {
    _singleDate = date;
    notifyListeners();
  }

  DateTime? get singleDate {
    return _singleDate;
  }
}

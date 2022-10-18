import 'package:calendar/calendar/calendar.dart';
import 'package:calendar/calendar/calendar_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool workingMode = true;
  final _selectedDateController = CalendarController();
  @override
  void initState() {
    _selectedDateController.addListener(() {
      //print('${_selectedDateController.singleDate}\n\n');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              workingMode ? 'Interval selection' : 'Single selection',
            ),
            actions: [
              Switch(
                value: workingMode,
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    workingMode = value;
                  });
                },
              ),
            ],
          ),
          body: Calendar(
            isInterval: workingMode,
            selectedDateController: _selectedDateController,
            availableDatesList: [
              DateTime(2022, 10, 18),
              DateTime(2022, 10, 22),
              DateTime(2022, 11, 22),
            ],
            noAvailableDatesList: [
              DateTime(2022, 10, 17),
              DateTime(2022, 10, 30),
              DateTime(2022, 11, 30)
            ],
          ),
        ),
      ),
    );
  }
}


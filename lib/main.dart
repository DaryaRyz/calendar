import 'package:calendar/calendar/calendar.dart';
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
            onChange: (singleDate, startDate, endDate) {
              print('singleDate: $singleDate\nstartDate: $startDate\n endDate: $endDate\n\n');
            },
          ),
        ),
      ),
    );
  }
}

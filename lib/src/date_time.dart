import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenuDateTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text("Date: ${DateFormat('EEEE, d MMM, yyyy').format(now)}"),
    );
  }
}

class MenuWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime.now();
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int weekOfYear = ((dayOfYear - date.weekday + 10) / 7).floor();
    return Text("LUNCHMENY V.: ${weekOfYear}");
  }
}

class OpenHours extends StatelessWidget {
  Map<String, int> WorkingDays = {
    'Tuesday': 10,
    'Wednesday': 10,
    'Thursday': 10,
    'Friday': 10,
    'Saturday': 12,
    'Sunday': 12,
  };

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    String keyForTime = DateFormat('EEEE').format(now);
    int nowHours = now.hour; // время сейчас
    int scheduleHours = WorkingDays[
        keyForTime]; // время по расписанию, где ключом является название сегдняшнего дня

    if (WorkingDays.containsKey(DateFormat('EEEE').format(now)) &&
        (nowHours >= scheduleHours)) {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Öppnad",
            style: TextStyle(
              fontSize: 20,
            ),
          ));
    } else {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Stängd",
            style: TextStyle(
              fontSize: 20,
            ),
          ));
    }
  }
}

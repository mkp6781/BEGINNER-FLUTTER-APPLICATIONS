import 'package:flutter/material.dart';

Future<TimeOfDay> select_time(context , time) async {
  time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    );
    return time;
}

Future<DateTime> select_date(context , date) async {
  date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050));
  return date;
}
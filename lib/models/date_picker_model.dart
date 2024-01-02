import 'package:flutter/material.dart';


class DatePicker{
   Future selectDate(DateTime initdate,dynamic context) async {
      DateTime picked=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: initdate,
        lastDate: DateTime(2100),
      ) as DateTime;
      return picked;
    }
}
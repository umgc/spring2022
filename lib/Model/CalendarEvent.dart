// ignore_for_file: unnecessary_statements

import 'package:untitled3/Utility/CalendarUtility.dart';

class CalenderEvent extends Event {
  String title;
  String date;
  String time;
  CalenderEvent({this.title = "", this.time = "", this.date = ""})
      : super(title);
}

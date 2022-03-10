import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:memorez/Model/Note.dart';
import 'package:memorez/Model/CalendarEvent.dart';
import 'package:memorez/Observables/NoteObservable.dart';

part 'CalenderObservable.g.dart';

class CalendarObservable = _AbstractCalendarObserver with _$CalendarObservable;

abstract class _AbstractCalendarObserver with Store {
  @observable
  ValueNotifier<List<CalenderEvent>> selectedEvents = ValueNotifier([]);

//Observable Variables -----------------------------------------------------
  @observable
  NoteObserver? noteObserver;

  @observable
  DateTime? selectedDay;

  @observable
  CalendarFormat calendarFormat = CalendarFormat.month;

  @observable
  bool _weekHasBeenPressed = false;

  @observable
  bool _monthHasBeenPressed = true;

  @observable
  bool _dayHasBeenPressed = false;

  @observable
  bool _calendarIsVisable = true;

  @observable
  bool _dailyCalendarIsVisible = false;

  @observable
  bool _notesOnDayIsVisible = true;

  @observable
  bool _calendarBarIsVisible = true;

  @observable
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 180));

  @observable
  DateTime _endDate = DateTime.now().add(const Duration(days: 180));

  @observable
  var monthStrings = ['Jan', 'Feb', 'Mar', 'April', 'May', 'June',
    'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];

  // Getters -------------------------------------
  @action
  bool getWeekHasBeenPressed() {
    return _weekHasBeenPressed;
  }

  @action
  bool getMonthHasBeenPressed() {
    return _monthHasBeenPressed;
  }

  @action
  bool getDayHasBeenPressed() {
    return _dayHasBeenPressed;
  }

  @action
  DateTime getStartDay() {
    return _startDate;
  }

  @action
  DateTime getEndDay() {
    return _endDate;
  }

  @action
  bool getCalendarIsVisible() {
    return _calendarIsVisable;
  }

  @action
  bool getCalendarBarIsVisible() {
    return _calendarBarIsVisible;
  }

  @action
  bool getDailyCalendarIsVisible() {
    return _dailyCalendarIsVisible;
  }

  @action
  bool getNotesOnDayIsVisible() {
    return _notesOnDayIsVisible;
  }

  //Setters-----------------------------------------
  @action
  void changeFormat(CalendarFormat format) {
    calendarFormat = format;
  }

  @action
  void setNoteObserver(observer) {
    noteObserver = observer;
  }

  @action
  void setSelectedDay(DateTime day) {
    selectedDay = day;
  }

  @action
  void setSelectedEvents( ValueNotifier<List<CalenderEvent>> value){
    selectedEvents = value;
  }

  @action
  void setWeekHasBeenPressed(bool value) {
    _weekHasBeenPressed = value;
  }

  @action
  void setMonthHasBeenPressed(bool value) {
    _monthHasBeenPressed = value;
  }

  @action
  void setDayHasBeenPressed(bool value) {
    _dayHasBeenPressed = value;
  }

  @action
  void setCalendarIsVisible(bool value) {
    _calendarIsVisable = value;
  }

  @action
  void setCalendarBarIsVisible(bool value) {
    _calendarBarIsVisible = value;
  }

  @action
  void setDailyCalendarIsVisible(bool value) {
    _dailyCalendarIsVisible = value;
  }

  @action
  void setCalendarIsVisisble(bool value) {
    _calendarIsVisable = value;
  }

  @action
  void setNotesOnDayIsVisible(bool value) {
    _notesOnDayIsVisible = value;
  }

  //Methods ---------------------------------------
  @action
  void weekView() {
    calendarFormat = CalendarFormat.week;
    setWeekHasBeenPressed(true);
    setDayHasBeenPressed(false);
    setMonthHasBeenPressed(false);

    setDailyCalendarIsVisible(false);
    setCalendarBarIsVisible(true);
    setCalendarIsVisible(true);

    setNotesOnDayIsVisible(true);
  }

  @action
  void monthView() {
    calendarFormat = CalendarFormat.month;
    setWeekHasBeenPressed(false);
    setDayHasBeenPressed(false);
    setMonthHasBeenPressed(true);

    setDailyCalendarIsVisible(false);
    setCalendarIsVisible(true);
    setCalendarBarIsVisible(true);

    setNotesOnDayIsVisible(true);
  }

  @action
  void dayView() {
    calendarFormat = CalendarFormat.week;
    print("Day View Pressed");
    setWeekHasBeenPressed(false);
    setDayHasBeenPressed(true);
    setMonthHasBeenPressed(false);

    setDailyCalendarIsVisible(true);
    setCalendarIsVisible(false);
    setCalendarBarIsVisible(true);

    setNotesOnDayIsVisible(false);
  }

  @action
  List<CalenderEvent> loadEventsOfSelectedDay(String day) {
    //print("loadEventsOfSelectedDay: note.eventDate: SelectDay $day");
    List<CalenderEvent> eventsOnDay = [];
    for (TextNote note in noteObserver!.usersNotes) {
       //print("Events Loaded: note.eventDate: ${note.eventDate} SelectDay $day");
      if (note.eventDate == day) {
        eventsOnDay.add(CalenderEvent(
            title: note.localText, time: note.eventTime, date: note.eventDate));
      }
    }
    selectedEvents.value = eventsOnDay;

    return eventsOnDay;
  }

  @action
  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @action
  List<Container> generateDailyTiles() {
    //This for loop checks each day and builds the title for each listTitle
      List<DateTime> _days = getDaysInBetween(_startDate, _endDate);
      List<Container> _daysAndEvents = [];
      for (var i = 0; i < _days.length; i++) {
        var _day = DateTime.parse(_days[i].toString()).day;
        var _month =
        monthStrings[DateTime.parse(_days[i].toString()).month - 1];
        var _year = DateTime.parse(_days[i].toString()).year;
        var tempItem = Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$_month $_day $_year",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
        );
        _daysAndEvents.add(tempItem);
        var _events =
            loadEventsOfSelectedDay(_days[i].toString().split(" ")[0]);
        for (var ii = 0; ii < _events.length; ii++) {
          tempItem = Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              border: Border.all(color: Colors.blueGrey, width: 1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\t\t${_events[ii]} \t at \t ${_events[ii].time}")
                ]),
          );
          _daysAndEvents.add(tempItem);
        }
      }
      return _daysAndEvents;
  }

  @action
  List<CalenderEvent> getNotesOnDay(){
    ValueListenableBuilder<List<CalenderEvent>>(
      valueListenable: selectedEvents,
      builder: (context, value, _) {
        print("Initialized Value Notifier: ");
        return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  border: Border.all(
                      color: Colors.blueGrey,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(12.0),

                ),
                child: ListTile(
                  //onTap: () => print('${value[index]}'),
                  title: Text("${value[index]} \t at \t ${value[index].time}",
                      textAlign: TextAlign.center),
                ),
              );
            });
      },
    );
    throw Exception();

  }
}

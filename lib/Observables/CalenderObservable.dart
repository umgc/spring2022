import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Model/CalendarEvent.dart';
import 'package:untitled3/Observables/NoteObservable.dart';

part 'CalenderObservable.g.dart';

class CalendarObservable = _AbstractCalendarObserver with _$CalendarObservable;

abstract class _AbstractCalendarObserver with Store {
  @observable
  NoteObserver? noteObserver;

  @observable
  DateTime? selectedDay;

  @observable
  CalendarFormat calendarFormat = CalendarFormat.week;

  @observable
  ValueNotifier<List<CalenderEvent>> selectedEvents = ValueNotifier([]);

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
  List<CalenderEvent> loadEventsOfSelectedDay(String day) {
    print("loadEventsOfSelectedDay: note.eventDate: SelectDay $day");
    List<CalenderEvent> eventsOnDay = [];
    for (TextNote note in noteObserver!.usersNotes) {
      // print(
      //   "loadEventsOfSelectedDay: note.eventDate: ${note.eventDate} SelectDay $day");
      if (note.eventDate == day) {
        eventsOnDay.add(CalenderEvent(
            title: note.localText, time: note.eventTime, date: note.eventDate));
      }
    }
    selectedEvents.value = eventsOnDay;

    return eventsOnDay;
  }
}

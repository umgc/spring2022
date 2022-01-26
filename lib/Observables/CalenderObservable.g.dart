// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalenderObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarObservable on _AbstractCalendarObserver, Store {
  final _$noteObserverAtom =
      Atom(name: '_AbstractCalendarObserver.noteObserver');

  @override
  NoteObserver? get noteObserver {
    _$noteObserverAtom.reportRead();
    return super.noteObserver;
  }

  @override
  set noteObserver(NoteObserver? value) {
    _$noteObserverAtom.reportWrite(value, super.noteObserver, () {
      super.noteObserver = value;
    });
  }

  final _$selectedDayAtom = Atom(name: '_AbstractCalendarObserver.selectedDay');

  @override
  DateTime? get selectedDay {
    _$selectedDayAtom.reportRead();
    return super.selectedDay;
  }

  @override
  set selectedDay(DateTime? value) {
    _$selectedDayAtom.reportWrite(value, super.selectedDay, () {
      super.selectedDay = value;
    });
  }

  final _$calendarFormatAtom =
      Atom(name: '_AbstractCalendarObserver.calendarFormat');

  @override
  CalendarFormat get calendarFormat {
    _$calendarFormatAtom.reportRead();
    return super.calendarFormat;
  }

  @override
  set calendarFormat(CalendarFormat value) {
    _$calendarFormatAtom.reportWrite(value, super.calendarFormat, () {
      super.calendarFormat = value;
    });
  }

  final _$selectedEventsAtom =
      Atom(name: '_AbstractCalendarObserver.selectedEvents');

  @override
  ValueNotifier<List<CalenderEvent>> get selectedEvents {
    _$selectedEventsAtom.reportRead();
    return super.selectedEvents;
  }

  @override
  set selectedEvents(ValueNotifier<List<CalenderEvent>> value) {
    _$selectedEventsAtom.reportWrite(value, super.selectedEvents, () {
      super.selectedEvents = value;
    });
  }

  final _$_AbstractCalendarObserverActionController =
      ActionController(name: '_AbstractCalendarObserver');

  @override
  void changeFormat(CalendarFormat format) {
    final _$actionInfo = _$_AbstractCalendarObserverActionController
        .startAction(name: '_AbstractCalendarObserver.changeFormat');
    try {
      return super.changeFormat(format);
    } finally {
      _$_AbstractCalendarObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNoteObserver(dynamic observer) {
    final _$actionInfo = _$_AbstractCalendarObserverActionController
        .startAction(name: '_AbstractCalendarObserver.setNoteObserver');
    try {
      return super.setNoteObserver(observer);
    } finally {
      _$_AbstractCalendarObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedDay(DateTime day) {
    final _$actionInfo = _$_AbstractCalendarObserverActionController
        .startAction(name: '_AbstractCalendarObserver.setSelectedDay');
    try {
      return super.setSelectedDay(day);
    } finally {
      _$_AbstractCalendarObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<CalenderEvent> loadEventsOfSelectedDay(String day) {
    final _$actionInfo = _$_AbstractCalendarObserverActionController
        .startAction(name: '_AbstractCalendarObserver.loadEventsOfSelectedDay');
    try {
      return super.loadEventsOfSelectedDay(day);
    } finally {
      _$_AbstractCalendarObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
noteObserver: ${noteObserver},
selectedDay: ${selectedDay},
calendarFormat: ${calendarFormat},
selectedEvents: ${selectedEvents}
    ''';
  }
}

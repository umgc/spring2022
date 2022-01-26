// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckListObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CheckListObserver on _AbstractCheckListObserver, Store {
  final _$checkedNoteIDsAtom =
      Atom(name: '_AbstractCheckListObserver.checkedNoteIDs');

  @override
  List<String> get checkedNoteIDs {
    _$checkedNoteIDsAtom.reportRead();
    return super.checkedNoteIDs;
  }

  @override
  set checkedNoteIDs(List<String> value) {
    _$checkedNoteIDsAtom.reportWrite(value, super.checkedNoteIDs, () {
      super.checkedNoteIDs = value;
    });
  }

  final _$selectedDayAtom =
      Atom(name: '_AbstractCheckListObserver.selectedDay');

  @override
  DateTime get selectedDay {
    _$selectedDayAtom.reportRead();
    return super.selectedDay;
  }

  @override
  set selectedDay(DateTime value) {
    _$selectedDayAtom.reportWrite(value, super.selectedDay, () {
      super.selectedDay = value;
    });
  }

  final _$_AbstractCheckListObserverActionController =
      ActionController(name: '_AbstractCheckListObserver');

  @override
  void setSelectedDay(DateTime day) {
    final _$actionInfo = _$_AbstractCheckListObserverActionController
        .startAction(name: '_AbstractCheckListObserver.setSelectedDay');
    try {
      return super.setSelectedDay(day);
    } finally {
      _$_AbstractCheckListObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCheckedList(String date) {
    final _$actionInfo = _$_AbstractCheckListObserverActionController
        .startAction(name: '_AbstractCheckListObserver.getCheckedList');
    try {
      return super.getCheckedList(date);
    } finally {
      _$_AbstractCheckListObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkItem(TextNote note) {
    final _$actionInfo = _$_AbstractCheckListObserverActionController
        .startAction(name: '_AbstractCheckListObserver.checkItem');
    try {
      return super.checkItem(note);
    } finally {
      _$_AbstractCheckListObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
checkedNoteIDs: ${checkedNoteIDs},
selectedDay: ${selectedDay}
    ''';
  }
}

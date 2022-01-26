// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteObserver on _AbstractNoteObserver, Store {
  final _$_imageAtom = Atom(name: '_AbstractNoteObserver._image');

  @override
  File? get _image {
    _$_imageAtom.reportRead();
    return super._image;
  }

  @override
  set _image(File? value) {
    _$_imageAtom.reportWrite(value, super._image, () {
      super._image = value;
    });
  }

  final _$imagePickerAtom = Atom(name: '_AbstractNoteObserver.imagePicker');

  @override
  ImagePicker get imagePicker {
    _$imagePickerAtom.reportRead();
    return super.imagePicker;
  }

  @override
  set imagePicker(ImagePicker value) {
    _$imagePickerAtom.reportWrite(value, super.imagePicker, () {
      super.imagePicker = value;
    });
  }

  final _$currentScreenAtom = Atom(name: '_AbstractNoteObserver.currentScreen');

  @override
  NOTE_SCREENS get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(NOTE_SCREENS value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$currNoteForDetailsAtom =
      Atom(name: '_AbstractNoteObserver.currNoteForDetails');

  @override
  TextNote? get currNoteForDetails {
    _$currNoteForDetailsAtom.reportRead();
    return super.currNoteForDetails;
  }

  @override
  set currNoteForDetails(TextNote? value) {
    _$currNoteForDetailsAtom.reportWrite(value, super.currNoteForDetails, () {
      super.currNoteForDetails = value;
    });
  }

  final _$usersNotesAtom = Atom(name: '_AbstractNoteObserver.usersNotes');

  @override
  List<TextNote> get usersNotes {
    _$usersNotesAtom.reportRead();
    return super.usersNotes;
  }

  @override
  set usersNotes(List<TextNote> value) {
    _$usersNotesAtom.reportWrite(value, super.usersNotes, () {
      super.usersNotes = value;
    });
  }

  final _$checkListNotesAtom =
      Atom(name: '_AbstractNoteObserver.checkListNotes');

  @override
  Set<TextNote> get checkListNotes {
    _$checkListNotesAtom.reportRead();
    return super.checkListNotes;
  }

  @override
  set checkListNotes(Set<TextNote> value) {
    _$checkListNotesAtom.reportWrite(value, super.checkListNotes, () {
      super.checkListNotes = value;
    });
  }

  final _$newNoteIsCheckListAtom =
      Atom(name: '_AbstractNoteObserver.newNoteIsCheckList');

  @override
  bool get newNoteIsCheckList {
    _$newNoteIsCheckListAtom.reportRead();
    return super.newNoteIsCheckList;
  }

  @override
  set newNoteIsCheckList(bool value) {
    _$newNoteIsCheckListAtom.reportWrite(value, super.newNoteIsCheckList, () {
      super.newNoteIsCheckList = value;
    });
  }

  final _$newNoteEventDateAtom =
      Atom(name: '_AbstractNoteObserver.newNoteEventDate');

  @override
  String get newNoteEventDate {
    _$newNoteEventDateAtom.reportRead();
    return super.newNoteEventDate;
  }

  @override
  set newNoteEventDate(String value) {
    _$newNoteEventDateAtom.reportWrite(value, super.newNoteEventDate, () {
      super.newNoteEventDate = value;
    });
  }

  final _$newNoteEventTimeAtom =
      Atom(name: '_AbstractNoteObserver.newNoteEventTime');

  @override
  String get newNoteEventTime {
    _$newNoteEventTimeAtom.reportRead();
    return super.newNoteEventTime;
  }

  @override
  set newNoteEventTime(String value) {
    _$newNoteEventTimeAtom.reportWrite(value, super.newNoteEventTime, () {
      super.newNoteEventTime = value;
    });
  }

  final _$getImageAsyncAction = AsyncAction('_AbstractNoteObserver.getImage');

  @override
  Future<dynamic> getImage() {
    return _$getImageAsyncAction.run(() => super.getImage());
  }

  final _$setCurrNoteIdForDetailsAsyncAction =
      AsyncAction('_AbstractNoteObserver.setCurrNoteIdForDetails');

  @override
  Future<void> setCurrNoteIdForDetails(dynamic noteId) {
    return _$setCurrNoteIdForDetailsAsyncAction
        .run(() => super.setCurrNoteIdForDetails(noteId));
  }

  final _$resetCurrNoteIdForDetailsAsyncAction =
      AsyncAction('_AbstractNoteObserver.resetCurrNoteIdForDetails');

  @override
  Future resetCurrNoteIdForDetails() {
    return _$resetCurrNoteIdForDetailsAsyncAction
        .run(() => super.resetCurrNoteIdForDetails());
  }

  final _$_AbstractNoteObserverActionController =
      ActionController(name: '_AbstractNoteObserver');

  @override
  void addNote(TextNote note) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.addNote');
    try {
      return super.addNote(note);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteNote(TextNote? note) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.deleteNote');
    try {
      return super.deleteNote(note);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotes(dynamic notes) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.setNotes');
    try {
      return super.setNotes(notes);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<TextNote> onSearchNote(String searchQuery) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.onSearchNote');
    try {
      return super.onSearchNote(searchQuery);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckList(dynamic listOfNotes) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.setCheckList');
    try {
      return super.setCheckList(listOfNotes);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCheckList() {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.clearCheckList');
    try {
      return super.clearCheckList();
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeScreen(NOTE_SCREENS name) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.changeScreen');
    try {
      return super.changeScreen(name);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewNoteAIsCheckList(bool value) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.setNewNoteAIsCheckList');
    try {
      return super.setNewNoteAIsCheckList(value);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewNoteEventDate(String value) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.setNewNoteEventDate');
    try {
      return super.setNewNoteEventDate(value);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewNoteEventTime(String value) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.setNewNoteEventTime');
    try {
      return super.setNewNoteEventTime(value);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imagePicker: ${imagePicker},
currentScreen: ${currentScreen},
currNoteForDetails: ${currNoteForDetails},
usersNotes: ${usersNotes},
checkListNotes: ${checkListNotes},
newNoteIsCheckList: ${newNoteIsCheckList},
newNoteEventDate: ${newNoteEventDate},
newNoteEventTime: ${newNoteEventTime}
    ''';
  }
}

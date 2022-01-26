// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationObserver on _AbstractNotificationObserver, Store {
  final _$onWalkingAtom = Atom(name: '_AbstractNotificationObserver.onWalking');

  @override
  bool get onWalking {
    _$onWalkingAtom.reportRead();
    return super.onWalking;
  }

  @override
  set onWalking(bool value) {
    _$onWalkingAtom.reportWrite(value, super.onWalking, () {
      super.onWalking = value;
    });
  }

  final _$onWaterAtom = Atom(name: '_AbstractNotificationObserver.onWater');

  @override
  bool get onWater {
    _$onWaterAtom.reportRead();
    return super.onWater;
  }

  @override
  set onWater(bool value) {
    _$onWaterAtom.reportWrite(value, super.onWater, () {
      super.onWater = value;
    });
  }

  final _$reminderAtom = Atom(name: '_AbstractNotificationObserver.reminder');

  @override
  bool get reminder {
    _$reminderAtom.reportRead();
    return super.reminder;
  }

  @override
  set reminder(bool value) {
    _$reminderAtom.reportWrite(value, super.reminder, () {
      super.reminder = value;
    });
  }

  final _$BathroomAtom = Atom(name: '_AbstractNotificationObserver.Bathroom');

  @override
  bool get Bathroom {
    _$BathroomAtom.reportRead();
    return super.Bathroom;
  }

  @override
  set Bathroom(bool value) {
    _$BathroomAtom.reportWrite(value, super.Bathroom, () {
      super.Bathroom = value;
    });
  }

  final _$noteNotificationAtom =
      Atom(name: '_AbstractNotificationObserver.noteNotification');

  @override
  bool get noteNotification {
    _$noteNotificationAtom.reportRead();
    return super.noteNotification;
  }

  @override
  set noteNotification(bool value) {
    _$noteNotificationAtom.reportWrite(value, super.noteNotification, () {
      super.noteNotification = value;
    });
  }

  final _$_AbstractNotificationObserverActionController =
      ActionController(name: '_AbstractNotificationObserver');

  @override
  void NoteNotification(dynamic value) {
    final _$actionInfo = _$_AbstractNotificationObserverActionController
        .startAction(name: '_AbstractNotificationObserver.NoteNotification');
    try {
      return super.NoteNotification(value);
    } finally {
      _$_AbstractNotificationObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void NotificationWalk(dynamic value) {
    final _$actionInfo = _$_AbstractNotificationObserverActionController
        .startAction(name: '_AbstractNotificationObserver.NotificationWalk');
    try {
      return super.NotificationWalk(value);
    } finally {
      _$_AbstractNotificationObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void NotificationWater(dynamic value) {
    final _$actionInfo = _$_AbstractNotificationObserverActionController
        .startAction(name: '_AbstractNotificationObserver.NotificationWater');
    try {
      return super.NotificationWater(value);
    } finally {
      _$_AbstractNotificationObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void NotificationReminder(dynamic value) {
    final _$actionInfo =
        _$_AbstractNotificationObserverActionController.startAction(
            name: '_AbstractNotificationObserver.NotificationReminder');
    try {
      return super.NotificationReminder(value);
    } finally {
      _$_AbstractNotificationObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void NotificationBathroom(dynamic value) {
    final _$actionInfo =
        _$_AbstractNotificationObserverActionController.startAction(
            name: '_AbstractNotificationObserver.NotificationBathroom');
    try {
      return super.NotificationBathroom(value);
    } finally {
      _$_AbstractNotificationObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
onWalking: ${onWalking},
onWater: ${onWater},
reminder: ${reminder},
Bathroom: ${Bathroom},
noteNotification: ${noteNotification}
    ''';
  }
}

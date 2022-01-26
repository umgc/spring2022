// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OnboardObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OnboardObserver on _AbstractOnboardObserver, Store {
  final _$currentScreenIndexAtom =
      Atom(name: '_AbstractOnboardObserver.currentScreenIndex');

  @override
  int get currentScreenIndex {
    _$currentScreenIndexAtom.reportRead();
    return super.currentScreenIndex;
  }

  @override
  set currentScreenIndex(int value) {
    _$currentScreenIndexAtom.reportWrite(value, super.currentScreenIndex, () {
      super.currentScreenIndex = value;
    });
  }

  final _$micAccessAllowedAtom =
      Atom(name: '_AbstractOnboardObserver.micAccessAllowed');

  @override
  bool get micAccessAllowed {
    _$micAccessAllowedAtom.reportRead();
    return super.micAccessAllowed;
  }

  @override
  set micAccessAllowed(bool value) {
    _$micAccessAllowedAtom.reportWrite(value, super.micAccessAllowed, () {
      super.micAccessAllowed = value;
    });
  }

  final _$languageAtom = Atom(name: '_AbstractOnboardObserver.language');

  @override
  dynamic get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(dynamic value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  final _$idAtom = Atom(name: '_AbstractOnboardObserver.id');

  @override
  int get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$deniedAtom = Atom(name: '_AbstractOnboardObserver.denied');

  @override
  bool get denied {
    _$deniedAtom.reportRead();
    return super.denied;
  }

  @override
  set denied(bool value) {
    _$deniedAtom.reportWrite(value, super.denied, () {
      super.denied = value;
    });
  }

  final _$_AbstractOnboardObserverActionController =
      ActionController(name: '_AbstractOnboardObserver');

  @override
  void permissionYes(dynamic value) {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.permissionYes');
    try {
      return super.permissionYes(value);
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void permissionNo(dynamic value) {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.permissionNo');
    try {
      return super.permissionNo(value);
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void languageChange(dynamic language) {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.languageChange');
    try {
      return super.languageChange(language);
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMicAccessAllowed(dynamic value) {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.setMicAccessAllowed');
    try {
      return super.setMicAccessAllowed(value);
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void moveToNextScreen() {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.moveToNextScreen');
    try {
      return super.moveToNextScreen();
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void moveToPrevScreen() {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.moveToPrevScreen');
    try {
      return super.moveToPrevScreen();
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.reset');
    try {
      return super.reset();
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreenIndex: ${currentScreenIndex},
micAccessAllowed: ${micAccessAllowed},
language: ${language},
id: ${id},
denied: ${denied}
    ''';
  }
}

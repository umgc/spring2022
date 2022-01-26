// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScreenNavigator.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainNavObserver on _AbstractMainNavObserver, Store {
  final _$currentScreenAtom =
      Atom(name: '_AbstractMainNavObserver.currentScreen');

  @override
  dynamic get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(dynamic value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$screenTitleAtom = Atom(name: '_AbstractMainNavObserver.screenTitle');

  @override
  String get screenTitle {
    _$screenTitleAtom.reportRead();
    return super.screenTitle;
  }

  @override
  set screenTitle(String value) {
    _$screenTitleAtom.reportWrite(value, super.screenTitle, () {
      super.screenTitle = value;
    });
  }

  final _$focusedNavBtnAtom =
      Atom(name: '_AbstractMainNavObserver.focusedNavBtn');

  @override
  dynamic get focusedNavBtn {
    _$focusedNavBtnAtom.reportRead();
    return super.focusedNavBtn;
  }

  @override
  set focusedNavBtn(dynamic value) {
    _$focusedNavBtnAtom.reportWrite(value, super.focusedNavBtn, () {
      super.focusedNavBtn = value;
    });
  }

  final _$_AbstractMainNavObserverActionController =
      ActionController(name: '_AbstractMainNavObserver');

  @override
  void changeScreen(dynamic screen) {
    final _$actionInfo = _$_AbstractMainNavObserverActionController.startAction(
        name: '_AbstractMainNavObserver.changeScreen');
    try {
      return super.changeScreen(screen);
    } finally {
      _$_AbstractMainNavObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String title) {
    final _$actionInfo = _$_AbstractMainNavObserverActionController.startAction(
        name: '_AbstractMainNavObserver.setTitle');
    try {
      return super.setTitle(title);
    } finally {
      _$_AbstractMainNavObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFocusedBtn(dynamic focusedBtn) {
    final _$actionInfo = _$_AbstractMainNavObserverActionController.startAction(
        name: '_AbstractMainNavObserver.setFocusedBtn');
    try {
      return super.setFocusedBtn(focusedBtn);
    } finally {
      _$_AbstractMainNavObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
screenTitle: ${screenTitle},
focusedNavBtn: ${focusedNavBtn}
    ''';
  }
}

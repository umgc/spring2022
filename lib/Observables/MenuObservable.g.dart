// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MenuObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MenuObserver on _AbstractMenuObserver, Store {
  final _$currentScreenAtom = Atom(name: '_AbstractMenuObserver.currentScreen');

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

  final _$focusedIconAtom = Atom(name: '_AbstractMenuObserver.focusedIcon');

  @override
  String get focusedIcon {
    _$focusedIconAtom.reportRead();
    return super.focusedIcon;
  }

  @override
  set focusedIcon(String value) {
    _$focusedIconAtom.reportWrite(value, super.focusedIcon, () {
      super.focusedIcon = value;
    });
  }

  final _$_AbstractMenuObserverActionController =
      ActionController(name: '_AbstractMenuObserver');

  @override
  void changeScreen(dynamic screen) {
    final _$actionInfo = _$_AbstractMenuObserverActionController.startAction(
        name: '_AbstractMenuObserver.changeScreen');
    try {
      return super.changeScreen(screen);
    } finally {
      _$_AbstractMenuObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
focusedIcon: ${focusedIcon}
    ''';
  }
}

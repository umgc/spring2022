// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SettingObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingObserver on _AbstractSettingObserver, Store {
  final _$currentScreenAtom =
      Atom(name: '_AbstractSettingObserver.currentScreen');

  @override
  String get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(String value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$userSettingsAtom =
      Atom(name: '_AbstractSettingObserver.userSettings');

  @override
  Setting get userSettings {
    _$userSettingsAtom.reportRead();
    return super.userSettings;
  }

  @override
  set userSettings(Setting value) {
    _$userSettingsAtom.reportWrite(value, super.userSettings, () {
      super.userSettings = value;
    });
  }

  final _$_AbstractSettingObserverActionController =
      ActionController(name: '_AbstractSettingObserver');

  @override
  void saveSetting() {
    final _$actionInfo = _$_AbstractSettingObserverActionController.startAction(
        name: '_AbstractSettingObserver.saveSetting');
    try {
      return super.saveSetting();
    } finally {
      _$_AbstractSettingObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initSettings(dynamic settings) {
    final _$actionInfo = _$_AbstractSettingObserverActionController.startAction(
        name: '_AbstractSettingObserver.initSettings');
    try {
      return super.initSettings(settings);
    } finally {
      _$_AbstractSettingObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeScreen(String name) {
    final _$actionInfo = _$_AbstractSettingObserverActionController.startAction(
        name: '_AbstractSettingObserver.changeScreen');
    try {
      return super.changeScreen(name);
    } finally {
      _$_AbstractSettingObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsFirstRun(bool value) {
    final _$actionInfo = _$_AbstractSettingObserverActionController.startAction(
        name: '_AbstractSettingObserver.setIsFirstRun');
    try {
      return super.setIsFirstRun(value);
    } finally {
      _$_AbstractSettingObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
userSettings: ${userSettings}
    ''';
  }
}

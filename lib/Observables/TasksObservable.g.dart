// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TasksObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TasksObserver on _AbstractTasksObserver, Store {
  final _$currentScreenAtom =
      Atom(name: '_AbstractTasksObserver.currentScreen');

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

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen}
    ''';
  }
}
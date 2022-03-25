// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskObserver on _AbstractTaskObserver, Store {
  final _$currentScreenAtom = Atom(name: '_AbstractTaskObserver.currentScreen');

  @override
  TASK_SCREENS get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(TASK_SCREENS value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$currTaskForDetailsAtom =
      Atom(name: '_AbstractTaskObserver.currTaskForDetails');

  @override
  TextTask? get currTaskForDetails {
    _$currTaskForDetailsAtom.reportRead();
    return super.currTaskForDetails;
  }

  @override
  set currTaskForDetails(TextTask? value) {
    _$currTaskForDetailsAtom.reportWrite(value, super.currTaskForDetails, () {
      super.currTaskForDetails = value;
    });
  }

  final _$usersTaskAtom = Atom(name: '_AbstractTaskObserver.usersTask');

  @override
  List<TextTask> get usersTask {
    _$usersTaskAtom.reportRead();
    return super.usersTask;
  }

  @override
  set usersTask(List<TextTask> value) {
    _$usersTaskAtom.reportWrite(value, super.usersTask, () {
      super.usersTask = value;
    });
  }

  final _$checkListTasksAtom =
      Atom(name: '_AbstractTaskObserver.checkListTasks');

  @override
  Set<TextTask> get checkListTasks {
    _$checkListTasksAtom.reportRead();
    return super.checkListTasks;
  }

  @override
  set checkListTasks(Set<TextTask> value) {
    _$checkListTasksAtom.reportWrite(value, super.checkListTasks, () {
      super.checkListTasks = value;
    });
  }

  final _$newTaskIsCheckListAtom =
      Atom(name: '_AbstractTaskObserver.newTaskIsCheckList');

  @override
  bool get newTaskIsCheckList {
    _$newTaskIsCheckListAtom.reportRead();
    return super.newTaskIsCheckList;
  }

  @override
  set newTaskIsCheckList(bool value) {
    _$newTaskIsCheckListAtom.reportWrite(value, super.newTaskIsCheckList, () {
      super.newTaskIsCheckList = value;
    });
  }

  final _$newTaskEventDateAtom =
      Atom(name: '_AbstractTaskObserver.newTaskEventDate');

  @override
  String get newTaskEventDate {
    _$newTaskEventDateAtom.reportRead();
    return super.newTaskEventDate;
  }

  @override
  set newTaskEventDate(String value) {
    _$newTaskEventDateAtom.reportWrite(value, super.newTaskEventDate, () {
      super.newTaskEventDate = value;
    });
  }

  final _$newTaskEventTimeAtom =
      Atom(name: '_AbstractTaskObserver.newTaskEventTime');

  @override
  String get newTaskEventTime {
    _$newTaskEventTimeAtom.reportRead();
    return super.newTaskEventTime;
  }

  @override
  set newTaskEventTime(String value) {
    _$newTaskEventTimeAtom.reportWrite(value, super.newTaskEventTime, () {
      super.newTaskEventTime = value;
    });
  }

  final _$setCurrTaskIdForDetailsAsyncAction =
      AsyncAction('_AbstractTaskObserver.setCurrTaskIdForDetails');

  @override
  Future<void> setCurrTaskIdForDetails(dynamic taskId) {
    return _$setCurrTaskIdForDetailsAsyncAction
        .run(() => super.setCurrTaskIdForDetails(taskId));
  }

  final _$resetCurrTaskIdForDetailsAsyncAction =
      AsyncAction('_AbstractTaskObserver.resetCurrTaskIdForDetails');

  @override
  Future resetCurrTaskIdForDetails() {
    return _$resetCurrTaskIdForDetailsAsyncAction
        .run(() => super.resetCurrTaskIdForDetails());
  }

  final _$_AbstractTaskObserverActionController =
      ActionController(name: '_AbstractTaskObserver');

  @override
  void addTask(TextTask task) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.addTask');
    try {
      return super.addTask(task);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteTask(TextTask? task) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.deleteTask');
    try {
      return super.deleteTask(task);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTasks(dynamic tasks) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.setTasks');
    try {
      return super.setTasks(tasks);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<TextTask> onSearchTask(String searchQuery) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.onSearchTask');
    try {
      return super.onSearchTask(searchQuery);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckList(dynamic listOfTasks) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.setCheckList');
    try {
      return super.setCheckList(listOfTasks);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCheckList() {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.clearCheckList');
    try {
      return super.clearCheckList();
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeScreen(TASK_SCREENS name) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.changeScreen');
    try {
      return super.changeScreen(name);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewTaskAIsCheckList(bool value) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.setNewTaskAIsCheckList');
    try {
      return super.setNewTaskAIsCheckList(value);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewTaskEventDate(String value) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.setNewTaskEventDate');
    try {
      return super.setNewTaskEventDate(value);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewTaskEventTime(String value) {
    final _$actionInfo = _$_AbstractTaskObserverActionController.startAction(
        name: '_AbstractTaskObserver.setNewTaskEventTime');
    try {
      return super.setNewTaskEventTime(value);
    } finally {
      _$_AbstractTaskObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

currentScreen: ${currentScreen},
currTaskForDetails: ${currTaskForDetails},
usersTask: ${usersTask},
checkListTasks: ${checkListTasks},
newTaskIsCheckList: ${newTaskIsCheckList},
newTaskEventDate: ${newTaskEventDate},
newTaskEventTime: ${newTaskEventTime}
    ''';
  }
}

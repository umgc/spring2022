import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'SaveTask.dart';
import 'viewTask.dart';

final viewTasksScaffoldKey = GlobalKey<ScaffoldState>();

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  _TaskState();

  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context);

    return Scaffold(
      key: viewTasksScaffoldKey,
      body: Observer(builder: (_) => _changeScreen(taskObserver.currentScreen)),
    );
  }

  Widget _changeScreen(TASK_SCREENS screen) {
    print("---Tasks/Task.dart Line 35--- Changing Task screen to $screen");

    switch (screen) {
      case TASK_SCREENS.ADD_TASK:
        return SaveTask();

      case TASK_SCREENS.TASK_DETAIL:
        return SaveTask(
          viewExistingTask: true,
        );

      default:
        return ViewTasks();
    }
  }
}

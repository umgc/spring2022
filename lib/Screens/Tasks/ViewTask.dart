import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:memorez/DatabaseHandler/DBHelper.dart';
import 'package:memorez/Services/NoteService.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'TaskTable.dart';
import 'package:memorez/Model/Task.dart';

final viewTasksScaffoldKey = GlobalKey<ScaffoldState>();

/// View Tasks page
class ViewTasks extends StatefulWidget {
  ViewTasks();

  @override
  State<ViewTasks> createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  _ViewTasksState();

  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context);

    taskObserver.resetCurrTaskIdForDetails();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            TaskTable(taskObserver.usersTask, () => print("done")),
            // Text('Completed Tasks'),
            // TaskTable(inActiveUserTasks, () => print("done"))
          ],
        ),
        floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFloatingBtn(taskObserver),
              ],
            )));
  }

  //Funtion retuns Floating button
  Widget buildFloatingBtn(TaskObserver taskObserver) {
    return Visibility(
      visible: taskObserver.careGiverModeEnabled,
      child: FloatingActionButton(
        onPressed: () {
          taskObserver.changeScreen(TASK_SCREENS.ADD_TASK);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}

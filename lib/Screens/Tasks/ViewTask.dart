import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'TaskTable.dart';

final viewTasksScaffoldKey = GlobalKey<ScaffoldState>();

/// View Tasks page
class ViewTasks extends StatefulWidget {
  @override
  _ViewTasksState createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  _ViewTasksState();

  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context);
    taskObserver.resetCurrTaskIdForDetails();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: TaskTable(taskObserver.usersTask, () => print("done")),
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
    return FloatingActionButton(
      onPressed: () {
        taskObserver.changeScreen(TASK_SCREENS.ADD_TASK);
      },
      tooltip: I18n.of(context)!.addNote,
      child: Icon(Icons.add),
    );
  }
}

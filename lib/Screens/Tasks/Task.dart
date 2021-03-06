import 'package:flutter/material.dart';
import 'package:memorez/Screens/Tasks/TaskTable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:memorez/DatabaseHandler/DBHelper.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/Tasks/completeHealthCheck.dart';
import 'package:memorez/Utility/Constant.dart';
import '../../Observables/TaskObservable.dart';
import '../../Services/TaskService.dart';
import 'saveNewTask.dart';
import 'completeActivity.dart';

final viewTasksScaffoldKey = GlobalKey<ScaffoldState>();

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool careGiverModeEnabled = false;
  _TaskState();

  final _pref = SharedPreferences.getInstance();
  late DbHelper dbHelper;
  var _conUserId = TextEditingController();
  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      _conUserId.text = sp.getString("user_id")!;

    });
  }

  UserModel? get userData => null;

  @override
  void initState() {
    super.initState();
    getUserData();
    dbHelper = DbHelper();
  }


  @override
  Widget build(BuildContext context) {
    print("username " + _conUserId.text);
    final taskObserver = Provider.of<TaskObserver>(context);
    //print('loaded tasks : ' + taskObserver.usersTask.toString());

    TextTaskService.loadTasks().then((tasks) =>
    {taskObserver.setTasks(tasks), taskObserver.setCheckList(tasks)});

    _conUserId.text == 'Admin'
        ? taskObserver.enableCaregiverMode()
        : taskObserver.disableCaregiverMode();

    return Container(
      key: viewTasksScaffoldKey,
      child: Observer(builder: (_) => _changeScreen(taskObserver.currentScreen)),
    );
  }

  Widget _changeScreen(TASK_SCREENS screen) {

    switch (screen) {
      case TASK_SCREENS.ADD_TASK:
        return SaveNewTask();

      case TASK_SCREENS.TASK_DETAIL:
        return CompleteActivity(
          readOnly: true,
        );
      case TASK_SCREENS.TASK_COMPLETE_ACTIVITY:
        return CompleteActivity(
          readOnly: false,
        );
      case TASK_SCREENS.TASK_COMPLETE_HEALTH_CHECK:
        return CompleteHealthCheck(
          readOnly: false,
        );
      case TASK_SCREENS.TASK_VIEW_COMPLETED_HEALTH_CHECK:
        return CompleteHealthCheck(
          readOnly: true,
        );

      default:
        {
          return TaskTable();
        }
    }
  }
}

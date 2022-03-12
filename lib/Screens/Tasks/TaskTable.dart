import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Task.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import '../../Observables/TaskObservable.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// View Tasks page
class TaskTable extends StatelessWidget {
  final List<TextTask> usersTasks;

  final Function? onListItemClickCallBackFn;

  //Flutter will autto assign this param to usersTasks
  TaskTable(this.usersTasks, this.onListItemClickCallBackFn);

  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);

    final taskObserver = Provider.of<TaskObserver>(context);
    taskObserver.resetCurrTaskIdForDetails();

    final settingObserver = Provider.of<SettingObserver>(context);

    const TEXT_STYLE = TextStyle(fontSize: 20);
    const HEADER_TEXT_STYLE = const TextStyle(fontSize: 20);

    var rowHeight = (MediaQuery.of(context).size.height - 56) / 5;
    var noteWidth = MediaQuery.of(context).size.width * 0.35;
    print("My width is $noteWidth");
    print('---line 35 no tasks ' + taskObserver.usersTask.length.toString());
    List<TextTask> activeUserTasks = <TextTask>[];
    List<TextTask> inActiveUserTasks = <TextTask>[];

    for (var i = 0; i < taskObserver.usersTask.length; i++) {
      if (taskObserver.usersTask[i].isTaskCompleted) {
        print('---line 45 active ' + i.toString());
        inActiveUserTasks.add(taskObserver.usersTask[i]);
      } else {
        print('---line 45 inactive ' + i.toString());
        activeUserTasks.add(taskObserver.usersTask[i]);
      }
      ;
    }

    print('---line 52 no tasks ' + inActiveUserTasks.length.toString());

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Active Tasks',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[900]),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: activeUserTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: InkWell(
                          //This runs when double tapping an Active Task
                          onDoubleTap: () {
                            // setState(() {
                            //
                            //   _completeTasks.add(_toDoTasks.elementAt(index));
                            //   _toDoTasks.remove(_toDoTasks.elementAt(index));
                            //
                            // });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  //color: setBackgroundColor(index),
                                  border: Border.all(color: Colors.blue),
                                  color: Colors.lightBlue[100],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(children: <Widget>[
                                    FaIcon(
                                        getIcon(activeUserTasks
                                            .elementAt(index)
                                            .icon),
                                        color: Colors.lightBlue[900]),
                                    Text(
                                      '   ' +
                                          activeUserTasks.elementAt(index).text,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue[900]),
                                    )
                                  ])))));
                }),
            const Divider(thickness: 5, color: Colors.grey),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Completed Tasks',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[900]),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: inActiveUserTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: InkWell(
                          //This runs when double tapping an Active Task
                          onDoubleTap: () {
                            // setState(() {
                            //
                            //   _completeTasks.add(_toDoTasks.elementAt(index));
                            //   _toDoTasks.remove(_toDoTasks.elementAt(index));
                            //
                            // });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  //color: setBackgroundColor(index),
                                  border: Border.all(color: Colors.blue),
                                  color: Colors.blueGrey[100],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(children: <Widget>[
                                    FaIcon(
                                        getIcon(inActiveUserTasks
                                            .elementAt(index)
                                            .icon),
                                        color: Colors.lightBlue[900]),
                                    Column(
                                      children: [
                                        Text(
                                          inActiveUserTasks
                                              .elementAt(index)
                                              .text,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlue[900]),
                                        ),
                                        Text(
                                          '01/05/2021 10:05 AM',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.lightBlue[900],
                                          ),
                                        )
                                      ],
                                    ),
                                  ])))));
                })
          ])

      //   DataTable(
      //       dataRowHeight: rowHeight,
      //       headingRowHeight: 60,
      //       columns: const <DataColumn>[
      //         DataColumn(
      //           label: Text(
      //             'Type',
      //             style: HEADER_TEXT_STYLE,
      //           ),
      //         ),
      //         DataColumn(
      //           label: Text(
      //             'Task',
      //             style: HEADER_TEXT_STYLE,
      //           ),
      //         ),
      //         DataColumn(
      //           label: Text(
      //             'CREATED',
      //             style: HEADER_TEXT_STYLE,
      //           ),
      //         ),
      //       ],
      //       rows: List<DataRow>.generate(
      //         activeUserTasks.length,
      //         (int index) => DataRow(
      //           cells: <DataCell>[
      //             DataCell(Text(activeUserTasks[index].taskType)),
      //             DataCell(
      //               Container(
      //                   // padding: EdgeInsets.all(10),
      //                   // width: noteWidth,
      //                   child: Text(
      //                 activeUserTasks[index].text,
      //                 style: TEXT_STYLE,
      //               )),
      //               showEditIcon: true,
      //               onTap: () => {
      //                 screenNav.changeScreen(MAIN_SCREENS.TASKS),
      //                 taskObserver
      //                     .setCurrTaskIdForDetails(usersTasks[index].taskId)
      //                     .then((value) => taskObserver
      //                         .changeScreen(TASK_SCREENS.TASK_DETAIL)),
      //                 if (onListItemClickCallBackFn != null)
      //                   {onListItemClickCallBackFn!.call()}
      //               },
      //             ),
      //             DataCell(Text(timeago.format(
      //                 activeUserTasks[index].recordedTime,
      //                 locale:
      //                     settingObserver.userSettings.locale.languageCode))),
      //           ],
      //         ),
      //       )),
      //
      // SingleChildScrollView(
      //     child: DataTable(
      //         dataRowHeight: rowHeight,
      //         headingRowHeight: 60,
      //         columns: const <DataColumn>[
      //           DataColumn(
      //             label: Text(
      //               'Type',
      //               style: HEADER_TEXT_STYLE,
      //             ),
      //           ),
      //           DataColumn(
      //             label: Text(
      //               'Task',
      //               style: HEADER_TEXT_STYLE,
      //             ),
      //           ),
      //           DataColumn(
      //             label: Text(
      //               'CREATED',
      //               style: HEADER_TEXT_STYLE,
      //             ),
      //           ),
      //         ],
      //         rows: List<DataRow>.generate(
      //           inActiveUserTasks.length,
      //           (int index) => DataRow(
      //             cells: <DataCell>[
      //               DataCell(Text(inActiveUserTasks[index].taskType)),
      //               DataCell(
      //                 Container(
      //                     // padding: EdgeInsets.all(10),
      //                     // width: noteWidth,
      //                     child: Text(
      //                   inActiveUserTasks[index].text,
      //                   style: TEXT_STYLE,
      //                 )),
      //                 showEditIcon: true,
      //                 onTap: () => {
      //                   screenNav.changeScreen(MAIN_SCREENS.TASKS),
      //                   taskObserver
      //                       .setCurrTaskIdForDetails(usersTasks[index].taskId)
      //                       .then((value) => taskObserver
      //                           .changeScreen(TASK_SCREENS.TASK_DETAIL)),
      //                   if (onListItemClickCallBackFn != null)
      //                     {onListItemClickCallBackFn!.call()}
      //                 },
      //               ),
      //               DataCell(Text(timeago.format(
      //                   inActiveUserTasks[index].recordedTime,
      //                   locale: settingObserver
      //                       .userSettings.locale.languageCode))),
      //             ],
      //           ),
      //         )))
      ,
    );
  }
}

IconData getIcon(String inputIconLabel) {
  IconData result = FontAwesomeIcons.globe;
  if (inputIconLabel == 'walking') {
    result = FontAwesomeIcons.walking;
  }
  return result;
}

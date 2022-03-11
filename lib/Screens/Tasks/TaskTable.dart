import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Task.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import '../../Observables/TaskObservable.dart';

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

    return SingleChildScrollView(
      child: DataTable(
          dataRowHeight: rowHeight,
          headingRowHeight: 60,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Type',
                style: HEADER_TEXT_STYLE,
              ),
            ),
            DataColumn(
              label: Text(
                'Task',
                style: HEADER_TEXT_STYLE,
              ),
            ),
            DataColumn(
              label: Text(
                'CREATED',
                style: HEADER_TEXT_STYLE,
              ),
            ),
          ],
          rows: List<DataRow>.generate(
            usersTasks.length,
            (int index) => DataRow(
              cells: <DataCell>[
                DataCell(Text(usersTasks[index].taskType)),
                DataCell(
                  Container(
                      // padding: EdgeInsets.all(10),
                      // width: noteWidth,
                      child: Text(
                    usersTasks[index].text,
                    style: TEXT_STYLE,
                  )),
                  showEditIcon: true,
                  onTap: () => {
                    screenNav.changeScreen(MAIN_SCREENS.TASKS),
                    taskObserver
                        .setCurrTaskIdForDetails(usersTasks[index].taskId)
                        .then((value) => taskObserver
                            .changeScreen(TASK_SCREENS.TASK_DETAIL)),
                    if (onListItemClickCallBackFn != null)
                      {onListItemClickCallBackFn!.call()}
                  },
                ),
                DataCell(Text(timeago.format(usersTasks[index].recordedTime,
                    locale: settingObserver.userSettings.locale.languageCode))),
              ],
            ),
          )),
    );
  }
}

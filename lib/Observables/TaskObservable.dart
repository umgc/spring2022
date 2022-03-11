import 'package:mobx/mobx.dart';

import '../Services/TaskService.dart';

import 'dart:collection';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:untitled3/Utility/Constant.dart';
import '../Model/Task.dart';
import 'package:share_plus/share_plus.dart';

part 'TaskObservable.g.dart';

class TaskObserver = _AbstractTaskObserver with _$TaskObserver;

abstract class _AbstractTaskObserver with Store {
  _AbstractTaskObserver() {
    TextTaskService.loadTasks()
        .then((tasks) => {setTasks(tasks), setCheckList(tasks)});
  }
  @observable
  File? _image;

  @observable
  ImagePicker imagePicker = ImagePicker();

  @observable
  TASK_SCREENS currentScreen = TASK_SCREENS.TASK;

  @observable
  TextTask? currTaskForDetails;

  @observable
  List<TextTask> usersTask = [];

  @observable
  Set<TextTask> checkListTasks = LinkedHashSet<TextTask>();

  //used when creating new note
  @observable
  bool newTaskIsCheckList = false;

  @observable
  String newTaskEventDate = "";

  @observable
  String newTaskEventTime = "";

  @action
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    _image = File(image!.path);
    Share.shareFiles([image.path]);
  }

  @action
  void addTask(TextTask task) {
    print("Adding task to: ${task.taskId}");
    usersTask.add(task);
    TextTaskService.persistTasks(usersTask);
  }

  @action
  void deleteTask(TextTask? task) {
    if (task == null) {
      print("deleteTask: param is null");
      return;
    }
    //remove from state
    usersTask.remove(task);
    checkListTasks.remove(task);
    //remove from storage by over-writing content
    TextTaskService.persistTasks(usersTask);
  }

  @action
  Future<void> setCurrTaskIdForDetails(taskId) async {
    print("Find Taskid: $taskId");

    for (TextTask task in usersTask) {
      if (task.taskId == taskId) {
        currTaskForDetails = task;
        newTaskEventDate = task.eventDate;
        newTaskEventTime = task.eventTime;
        newTaskIsCheckList = task.isCheckList;
      }
    }
  }

  @action
  resetCurrTaskIdForDetails() async {
    currTaskForDetails = null;
    setNewTaskAIsCheckList(false);
    setNewTaskEventDate("");
    setNewTaskEventTime("");
  }

  @action
  void setTasks(tasks) {
    print("set task to: ${tasks}");
    usersTask = tasks;
  }

  @action
  List<TextTask> onSearchTask(String searchQuery) {
    List<TextTask> filteredResult = usersTask
        .where((element) =>
            element.text.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return filteredResult;
  }

  @action
  void setCheckList(listOfTasks) {
    for (TextTask item in listOfTasks) {
      if (item.isCheckList == true || item.recurrentType == "daily") {
        checkListTasks.add(item);
      }
    }
  }

  @action
  void clearCheckList() {
    checkListTasks.clear();
  }

  @action
  void changeScreen(TASK_SCREENS name) {
    print("Task Screen changed to: $name");
    currentScreen = name;
  }

  /*
  * Actions for creating new Tasks
  */
  @action
  void setNewTaskAIsCheckList(bool value) {
    newTaskIsCheckList = value;
  }

  @action
  void setNewTaskEventDate(String value) {
    print("setNewTaskEventDate: setting new Task date $value");
    newTaskEventDate = value;
  }

  @action
  void setNewTaskEventTime(String value) {
    print("setNewTaskEventTime: setting new Task time $value");
    newTaskEventTime = value;
  }
}

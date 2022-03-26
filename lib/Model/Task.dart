import 'dart:ffi';

import '../Services/TaskService.dart';

class TextTask {
  TextTask();

  /// Name of the text task file
  String taskId = TextTaskService.generateUUID();

  /// Date and time when the text task was recorded
  DateTime recordedTime = DateTime.now();

  //language
  String language = "en";

  //true for check list Item
  bool isCheckList = false;

  //Event might occur daily, weekl, monthly or yearly
  //Default is 'none' for singly occurrence events
  String recurrentType = "none";

  //true for check list Item
  bool isEvent = false;

  /// Actual text of the text note
  String text = "";

  /// Local text of the note stored at creation
  String localText = "";

  /// Whether or not this text file is flagged as a favorite
  bool isFavorite = false;

  /// Date of event
  String eventDate = "";

  /// Date of event
  String eventTime = "";

  ///Task Type
  String taskType = "defaultType";
  DateTime sendTaskDateTime = DateTime.now();
  String responseText = '';
  bool isReoccuring = false;
  String firstHealthCheckMood = '';
  String secondHealthCheckMood = '';
  String name = '';
  String description = 'Test Description';
  String icon = 'tooth';
  String iconColor = 'purple';
  bool isResponseRequired = false;
  bool isTaskCompleted = false;
  DateTime? completedTaskDateTime;

  String toJson() {
    String completedTaskDateTime = '';
    if (this.isTaskCompleted) {
      if (this.completedTaskDateTime != null) {
        completedTaskDateTime = this.completedTaskDateTime!.toIso8601String();
      }
    }
    String jsonStr = """ {
                        "taskId": "${this.taskId}",
                        "taskType": "${this.taskType}",
                        "sendTaskDateTime": "${this.sendTaskDateTime.toIso8601String()}",
                        "responseText":"${this.responseText}",
                        "isReoccuring":"${this.isReoccuring}",
                        "isTaskCompleted" :"${this.isTaskCompleted}",
                        "firstHealthCheckMood":"${this.firstHealthCheckMood}",
                        "secondHealthCheckMood":"${this.secondHealthCheckMood}",
                        "name":"${this.name}",
                        "description":"${this.description}",
                        "icon":"${this.icon}",
                        "iconColor":"${this.iconColor}",
                        "isResponseRequired":"${this.isResponseRequired}",
                        "completedTaskDateTime":"${completedTaskDateTime}"
                      
                        }""";
    return jsonStr;
  }

  factory TextTask.fromJson(dynamic jsonObj) {
    TextTask task = TextTask();
    //print("extracting jsonObj $jsonObj");
    task.taskId = jsonObj['taskId'];
    task.taskType = jsonObj['taskType'];
    // task.sendTaskDateTime =
    //     DateTime.parse(jsonObj['sendTaskDateTime'].toIso8601Strin);
    task.responseText = jsonObj['responseText'];
    task.isReoccuring =
        jsonObj['isReoccuring'].toString().toLowerCase() == 'true';
    task.firstHealthCheckMood = jsonObj['firstHealthCheckMood'];
    task.secondHealthCheckMood = jsonObj['secondHealthCheckMood'];
    task.name = jsonObj['name'];
    task.description = jsonObj['description'];
    task.icon = jsonObj['icon'];
    task.iconColor = jsonObj['iconColor'];
    task.isResponseRequired =
        jsonObj['isResponseRequired'].toString().toLowerCase() == 'true';
    task.isTaskCompleted =
        jsonObj['isTaskCompleted'].toString().toLowerCase() == 'true';
    if (task.isTaskCompleted) {
      if (jsonObj['completedTaskDateTime'] != '') {
        task.completedTaskDateTime =
            DateTime.parse(jsonObj['completedTaskDateTime'].toString());
      }
    }

    // task.recordedTime = DateTime.parse(jsonObj['recordedTime']);
    // task.language = jsonObj['language'];
    // task.isCheckList = jsonObj['isCheckList'];
    // task.recurrentType = jsonObj['recurrentType'];
    // task.isEvent = jsonObj['isEvent'];
    // task.text = jsonObj['text'];
    // task.localText = jsonObj['localText'];
    // task.isFavorite = jsonObj['isFavorite'];
    // task.eventDate = jsonObj['eventDate'] ?? "";
    // task.eventTime = jsonObj['eventTime'] ?? "";
    print(task.toString());
    return task;
  }

  @override
  String toString() {
    return this.toJson();
  }
}

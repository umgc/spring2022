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

  String toJson() {
    String jsonStr = """ {"noteId": "${this.taskId}",
                        "recordedTime": "${this.recordedTime}",
                        "language": "${this.language}",
                        "recurrentType": "${this.recurrentType}",
                        "isCheckList": ${this.isCheckList},
                        "isEvent": ${this.isEvent},
                        "text": "${this.text}",
                        "localText": "${this.localText}",
                        "isFavorite": ${this.isFavorite},
                        "eventDate": "${this.eventDate}",
                        "eventTime": "${this.eventTime}"
                        }""";
    return jsonStr;
  }

  factory TextTask.fromJson(dynamic jsonObj) {
    TextTask task = TextTask();
    print("extracting jsonObj $jsonObj");
    task.taskId = jsonObj['noteId'];
    task.recordedTime = DateTime.parse(jsonObj['recordedTime']);
    task.language = jsonObj['language'];
    task.isCheckList = jsonObj['isCheckList'];
    task.recurrentType = jsonObj['recurrentType'];
    task.isEvent = jsonObj['isEvent'];
    task.text = jsonObj['text'];
    task.localText = jsonObj['localText'];
    task.isFavorite = jsonObj['isFavorite'];
    task.eventDate = jsonObj['eventDate'] ?? "";
    task.eventTime = jsonObj['eventTime'] ?? "";
    return task;
  }

  @override
  String toString() {
    return this.toJson();
  }
}

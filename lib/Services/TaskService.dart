import 'package:memorez/Utility/EncryptionUtil.dart';

import '../Model/Task.dart';
import '../Utility/FileUtil.dart';
import 'package:uuid/uuid.dart';

/// Encapsulates all file I/O for text notes
class TextTaskService {
  static String FILE_NAME = "memory_tasks.json";

  /// Constructor
  TextTaskService();

  /// Save a text note file to local storage
  static Future<List<TextTask>> loadTasks() async {
    print('Loading tasks from file');
    List<TextTask> userTextTasks = [];
    try {
      dynamic listExtract =
          await FileUtil.readJson(FILE_NAME).then((value) => value);
      for (var task in listExtract) {
        print("Loading tasks from file start $task");
        userTextTasks.add(TextTask.fromJson(task));
        print("Loading tasks from file end $task");
      }
      print('all tasks loaded ' + userTextTasks.length.toString());
    } catch (Exception) {
      print('error ' + Exception.toString());
    }
    return userTextTasks;
  }

  /// Save a text note file to local storage
  static Future<void> persistTasks(List<TextTask> tasks) async {
    final encryptedNote = EncryptUtil.encryptNote(tasks.toString());
    FileUtil.writeFile(FILE_NAME, encryptedNote);
  }

  static String generateUUID() {
    var uuid = Uuid();
    // Generate a v4 (random) id
    var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
    return v4;
  }

  static void persistDailyCheckedNotes(String checkedNoteID) {
    String fileName =
        "${DateTime.now().toString().split(" ")[0]}_checkeditems.txt";
    print("persistDailyCheckedNotes: fileName $fileName");
    FileUtil.writeFile(fileName, "$checkedNoteID");
  }

  static Future<String> getDailyCheckedNote(String date) async {
    String data = "";
    String fileName = "${date}_checkeditems.txt";
    await FileUtil.readFile(fileName).then((value) => data = value);
    return data;
  }
}

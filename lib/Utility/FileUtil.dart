import 'package:path_provider/path_provider.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'dart:convert';

import 'package:untitled3/Utility/EncryptionUtil.dart';

class FileUtil {
  /// The file system to use for all I/O operations. Generally LocalFileSystem()
  /// but MemoryFileSystem() is used when running unit tests.
  static FileSystem fileSystem = const LocalFileSystem();

  /// Returns the correct file directory for all text notes
  static Future<Directory> _getTextNotesDirectory() async {
    var docsDirectory = fileSystem.directory(".");

    try {
      if (fileSystem is LocalFileSystem) {
        // Docs folder only available for Android and IOS, not unit tests
        var docsPath = (await getApplicationDocumentsDirectory()).path;
        docsDirectory = fileSystem.directory(docsPath);

        final notesDirectory =
            fileSystem.directory('${docsDirectory.path}/Memory_Magic');
        notesDirectory.createSync();
        return notesDirectory;
      }
    } catch (MissingPluginException) {}

    return docsDirectory;
  }

  static Future<dynamic> readJson(String fileName) async {
    dynamic data = "";
    try {
      String fileContent = await readFile(fileName);
      if (fileContent.trim().isEmpty) {
        fileContent = "{}";
      }
      data = await json.decode(EncryptUtil.decryptNote(fileContent));
    } catch (e) {
      print("ERROR-Couldn't read file: ${e.toString()}");
    }
    return data;
  }

  static Future<String> readFile(String fileName) async {
    String data = "";
    try {
      var textNotesDirectory = await _getTextNotesDirectory();
      final File file = fileSystem.file('${textNotesDirectory.path}/$fileName');
      print("readFile: filepath ${file.path}");
      //create file if it does not exist
      if (await file.exists() == false) {
        file.createSync(recursive: true);
      } else {
        data = file.readAsStringSync().trim();
      }
      print("readFile: result data $data");
    } catch (e) {
      print("ERROR-Couldn't read file: ${e.toString()}");
    }
    return data;
  }

  static Future<void> writeFile(String fileName, String data) async {
    try {
      var textNotesDirectory = await _getTextNotesDirectory();
      final File file = fileSystem.file('${textNotesDirectory.path}/$fileName');
      file.writeAsString(data);
      print("data has been written to file ${file.path}");
    } catch (e) {
      print("ERROR-Couldn't write to file: ${e.toString()}");
    }
  }
}

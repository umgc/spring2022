import '../Model/Setting.dart';
import '../Utility/FileUtil.dart';

/// Encapsulates all file I/O for text notes
class SettingService {
  static String FILE_NAME = "settings.json";

  /// Constructor
  SettingService();

  /// Save a text note file to local storage
  static Future<Setting> loadSetting() async {
    dynamic jsonObj = await FileUtil.readJson(FILE_NAME).then((value) => value);
    Setting userTextNotes = Setting.fromJson(jsonObj);
    return userTextNotes;
  }

  /// Save a text note file to local storage
  static Future<void> save(Setting settingObj) async {
    print("Saving settings");
    FileUtil.writeFile(FILE_NAME, "${settingObj.toString()}");
  }
}

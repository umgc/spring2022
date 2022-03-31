import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../generated/i18n.dart';

enum FontSize {
  SMALL,
  MEDIUM,
  LARGE,
}

enum AppTheme { BLUE, PINK } /// prob needs to be changed

fontSizeStringToEnum(String fontSizeString) {
  switch (fontSizeString) {
    case 'FontSize.MEDIUM':
      return FontSize.MEDIUM;
    case 'FontSize.SMALL':
      return FontSize.SMALL;
    case 'FontSize.LARGE':
      return FontSize.LARGE;
  }
}

appThemeStringToEnum(String appTheme) { ///needs to be changed with appTheme
  switch (appTheme) {
    case 'AppTheme.BLUE':
      return AppTheme.BLUE;
    case 'AppTheme.PINK':
      return AppTheme.PINK;
  }
}

const DEFAULT_FONT_SIZE = FontSize.MEDIUM;

const DEFAULT_DAYS_TO_KEEP_FILES = "7";
String defaultLocale = Platform.localeName;


// var DEFAULT_LOCALE = Locale("en", "US");

var DEFAULT_LOCALE = Locale('${ui.window.locale.languageCode}');

const DEFAULT_APP_THEME = AppTheme.BLUE;

const DEFAULT_IS_FIRST_RUN = true;

const DEFAULT_ENABLE_VOICE_OVER_TEXT = true;

const DEFAULT_MINUTES_BEFORE_NOTE_NOTIFICATIONS = "3";

const DEFAULT_MINUTES_BEFORE_TASK_NOTIFICATIONS = "1";

const DEFAULT_ENABLE_NOTES_NOTIFICATIONS = true;

const DEFAULT_ENABLE_TASKS_NOTIFICATIONS = true;

const DEFAULT_ENABLE_CAREGIVER_MODE = false;


/// Defines the settings object
class Setting {

  // days to keep files before clearing them
  String daysToKeepFiles = DEFAULT_DAYS_TO_KEEP_FILES; /// Is this the same as Notes?

  //bool to track if the app is newly installed
  bool isFirstRun = DEFAULT_IS_FIRST_RUN;

  // language of preference
  Locale locale = DEFAULT_LOCALE;

  //path to the wake word file
  bool enableVoiceOverText = DEFAULT_ENABLE_VOICE_OVER_TEXT;

  FontSize noteFontSize = DEFAULT_FONT_SIZE;
  FontSize menuFontSize = DEFAULT_FONT_SIZE;

  AppTheme appTheme = DEFAULT_APP_THEME;

  String minutesBeforeNoteNotifications = DEFAULT_MINUTES_BEFORE_NOTE_NOTIFICATIONS;

  String minutesBeforeTaskNotifications = DEFAULT_MINUTES_BEFORE_TASK_NOTIFICATIONS;

  bool enableNotesNotifications = DEFAULT_ENABLE_NOTES_NOTIFICATIONS;

  bool enableTasksNotifications = DEFAULT_ENABLE_TASKS_NOTIFICATIONS;

  /// Constructor takes all properties as params
  Setting();

  String toJson() {
    String jsonStr = """{"daysToKeepFiles": "${this.daysToKeepFiles}",
                        "locale": "${this.locale.toString()}",
                        "isFirstRun": ${this.isFirstRun},
                        "enableVoiceOverText": ${this.enableVoiceOverText},
                        "appTheme": "${this.appTheme.toString()}",
                        "noteFontSize": "${this.noteFontSize.toString()}",
                        "menuFontSize": "${this.menuFontSize.toString()}",
                        "minutesBeforeNoteNotifications": "${this.minutesBeforeNoteNotifications.toString()}",
                        "minutesBeforeTaskNotifications": "${this.minutesBeforeTaskNotifications.toString()}",
                        "enableNotesNotifications": ${this.enableNotesNotifications},
                        "enableTasksNotifications": ${this.enableTasksNotifications} }
                        """;

    return jsonStr;
  }

  factory Setting.fromJson(dynamic jsonObj) {
    Setting setting = Setting();
    print("extracting jsonObj $jsonObj");
    if (jsonObj != "" && jsonObj.length > 0) {
      if (jsonObj['locale'] != null) {
        var localeParts = jsonObj['locale'].split('_');
        setting.locale = Locale(localeParts[0], localeParts[1]);
      } else {
        setting.locale = DEFAULT_LOCALE;
      }
      setting.daysToKeepFiles = jsonObj['daysToKeepFiles']?.toString() ?? DEFAULT_DAYS_TO_KEEP_FILES;
      setting.isFirstRun = jsonObj['isFirstRun'] ?? DEFAULT_IS_FIRST_RUN;
      setting.enableVoiceOverText = jsonObj['enableVoiceOverText'] ?? DEFAULT_ENABLE_VOICE_OVER_TEXT;
      setting.noteFontSize = fontSizeStringToEnum(jsonObj['noteFontSize']) ?? DEFAULT_FONT_SIZE;
      setting.menuFontSize = fontSizeStringToEnum(jsonObj['menuFontSize']) ?? DEFAULT_FONT_SIZE;
      setting.appTheme = appThemeStringToEnum(jsonObj['appTheme'] ?? DEFAULT_APP_THEME);
      setting.minutesBeforeNoteNotifications = jsonObj['minutesBeforeNoteNotifications'] ?? DEFAULT_MINUTES_BEFORE_NOTE_NOTIFICATIONS;
      setting.minutesBeforeTaskNotifications = jsonObj['minutesBeforeTaskNotifications'] ?? DEFAULT_MINUTES_BEFORE_TASK_NOTIFICATIONS;
      setting.enableNotesNotifications = jsonObj['enableNotesNotifications'] ?? DEFAULT_ENABLE_NOTES_NOTIFICATIONS;
      setting.enableTasksNotifications = jsonObj['enableTasksNotifications'] ?? DEFAULT_ENABLE_TASKS_NOTIFICATIONS;
    }

    return setting;
  }

  @override
  String toString() {
    return this.toJson();
  }
}

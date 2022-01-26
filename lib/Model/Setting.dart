import 'dart:ui';

enum FontSize {
  SMALL,
  MEDIUM,
  LARGE,
}

enum AppTheme { BLUE, PINK }

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

appThemeStringToEnum(String appTheme) {
  switch (appTheme) {
    case 'AppTheme.BLUE':
      return AppTheme.BLUE;
    case 'AppTheme.PINK':
      return AppTheme.PINK;
  }
}

const DEFAULT_FONT_SIZE = FontSize.MEDIUM;

const DEFAULT_DAYS_TO_KEEP_FILES = "7";

const DEFAULT_LOCALE = const Locale("en", "US");

const DEFAULT_APP_THEME = AppTheme.BLUE;

const DEFAULT_IS_FIRST_RUN = true;

const DEFAULT_ENABLE_VOICE_OVER_TEXT = true;


/// Defines the settings object
class Setting {
  /// days to keep files before clearing them
  String daysToKeepFiles = DEFAULT_DAYS_TO_KEEP_FILES;

  //bool to track if the app is newly installed
  bool isFirstRun = DEFAULT_IS_FIRST_RUN;

  // language of preference
  Locale locale = DEFAULT_LOCALE;

  /// path to the wake word file
  bool enableVoiceOverText = DEFAULT_ENABLE_VOICE_OVER_TEXT;

  FontSize noteFontSize = DEFAULT_FONT_SIZE;
  FontSize menuFontSize = DEFAULT_FONT_SIZE;

  AppTheme appTheme = DEFAULT_APP_THEME;


  /// Constructor takes all properties as params
  Setting();

  String toJson() {
    String jsonStr = """{"daysToKeepFiles": "${this.daysToKeepFiles}",
                        "locale": "${this.locale.toString()}",
                        "isFirstRun": ${this.isFirstRun},
                        "enableVoiceOverText": ${this.enableVoiceOverText},
                        "appTheme": "${this.appTheme.toString()}",
                        "noteFontSize": "${this.noteFontSize.toString()}",
                        "menuFontSize": "${this.menuFontSize.toString()}" }
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
    }

    return setting;
  }

  @override
  String toString() {
    return this.toJson();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/LoginPage.dart';
import 'package:untitled3/Services/LocaleService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import 'dart:math' as math;

import '../../Observables/ScreenNavigator.dart';

List<FontSize> fontSizes = [FontSize.SMALL, FontSize.MEDIUM, FontSize.LARGE];
List<String> minutesBeforeNotification = ['1', '2', '3', '5', '10', '30'];
List<AppTheme> themes = [AppTheme.BLUE, AppTheme.PINK];

List<String> daysToKeepFilesOptions = ["1", "3", "5", "7", "14", "Forever"];

/// days to keep Notes???

class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);
    final settingObserver = Provider.of<SettingObserver>(context);
    final supportedLocales = GeneratedLocalizationsDelegate().supportedLocales;

    fontSizeToDisplayName(FontSize fontSize) {
      switch (fontSize) {
        case FontSize.SMALL:
          {
            return I18n.of(context)!.small;
          }
        case FontSize.MEDIUM:
          {
            return I18n.of(context)!.medium;
          }
        case FontSize.LARGE:
          {
            return I18n.of(context)!.large;
          }
        default:
          throw new UnimplementedError('not implemented');
      }
    }

    themeToDisplayName(AppTheme appTheme) {
      switch (appTheme) {
        case AppTheme.BLUE:
          {
            return I18n.of(context)!.blue;
          }
        case AppTheme.PINK:
          {
            return I18n.of(context)!.pink;
          }
        default:
          throw new UnimplementedError('not implemented');
      }
    }

    final ICON_SIZE = 40.00;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  /**
                 * Notes section
                 */
                  Row(
                    children: [
                      Text(I18n.of(context)!.notesScreenName,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800])),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0, //for spacing
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    //'Enable Notifications',
                    I18n.of(context)!.enableNotifications,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value:
                        settingObserver.userSettings.enableNotesNotifications,
                    onChanged: (bool newValue) {
                      setState(() {
                        settingObserver.userSettings.enableNotesNotifications =
                            newValue;
                      });
                    },
                    inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                    activeTrackColor: Colors.green,
                    activeColor: Colors.blue,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    //'Minutes Before Notification',
                    I18n.of(context)!.minutesBeforeNotification,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    alignment: Alignment.center,
                    value: settingObserver
                        .userSettings.minutesBeforeNoteNotifications,

                    /// the default or saved value
                    items: minutesBeforeNotification
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        settingObserver.userSettings
                            .minutesBeforeNoteNotifications = newValue!;

                      });
                    },

                    // items: supportedLocales.map((valueItem) {
                    //   return DropdownMenuItem(
                    //       value: valueItem,
                    //       child: Text((LocaleService.getDisplayLanguage(
                    //           valueItem.languageCode)["name"])
                    //       )
                    //   );
                    // }).toList(),
                    // onChanged: (Locale? newLocale) {
                    //   setState(() {
                    //     if (newLocale != null) {
                    //       settingObserver.userSettings.locale = newLocale;
                    //     }
                    //   });
                    // },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    I18n.of(context)!.daysToKeepNotes,
                    //'Days To Keep Notes',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    alignment: Alignment.center, /// This may need to be changed to new variable.*****************
                    value: settingObserver.userSettings.daysToKeepFiles,
                    items: daysToKeepFilesOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        settingObserver.userSettings.daysToKeepFiles =
                            newValue!;/// This may need to be changed to new variable.*****************

                        //null check
                      });
                    },
                  ),
                ],
              ),
              addTopDivider(),
              addBotDivider(),

              /**
             * Tasks section
             */
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      Text(I18n.of(context)!.tasks,
                          //'Tasks',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800])),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    I18n.of(context)!.enableNotifications,
                    //'Enable Notifications',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value:
                        settingObserver.userSettings.enableTasksNotifications,
                    onChanged: (bool newValue) {
                      setState(() {
                        settingObserver.userSettings.enableTasksNotifications =
                            newValue;
                      });
                    },
                    inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                    activeTrackColor: Colors.green,
                    activeColor: Colors.blue,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    I18n.of(context)!.minutesBeforeNotification,
                    //'Minutes Before Notification',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    alignment: Alignment.center,
                    value: settingObserver
                        .userSettings.minutesBeforeTaskNotifications,
                    items: minutesBeforeNotification
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        settingObserver.userSettings
                            .minutesBeforeTaskNotifications = newValue!;
                      });
                    },
                  ),
                ],
              ),
              addTopDivider(),
              addBotDivider(),

              /**
             * App Settings Section
             */
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      Text(I18n.of(context)!.appSettings,
                          //'App Settings',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800])),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),

              /// Not sure what options we are including for font
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Font Size',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<FontSize?>(
                    alignment: Alignment.center,
                    value: settingObserver.userSettings.menuFontSize,
                    items: fontSizes
                        .map<DropdownMenuItem<FontSize>>((FontSize value) {
                      return DropdownMenuItem<FontSize>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (FontSize? newValue) {
                      setState(() {
                        settingObserver.userSettings.menuFontSize = newValue!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    I18n.of(context)!.language,
                    //'Language',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Text(I18n.of(context)!.language,
                  //     style: Theme.of(context).textTheme.bodyText2),
                  // Padding(
                  //   padding: const EdgeInsets.all(3),
                  //   child: Container(
                  //     width: 60,
                  //     height: 40,
                  //     padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.black, width: 1),
                  //     ),
                  //       DropdownButton(
                  //       hint: Text(
                  //         I18n.of(context)!.selectLanguage,
                  //         style: Theme.of(context).textTheme.headline6,
                  //       ),
                  //
                  //       value: settingObserver.userSettings.locale,
                  //       onChanged: (Locale? newLocale) {
                  //         setState(() {
                  //           if (newLocale != null) {
                  //             settingObserver.userSettings.locale = newLocale;
                  //           }
                  //         });
                  //       },
                  //       isExpanded: true,
                  //       underline: SizedBox(),
                  //       style: Theme.of(context).textTheme.bodyText1,
                  //       items: supportedLocales.map((valueItem) {
                  //         return DropdownMenuItem(
                  //             value: valueItem,
                  //             child: Text((LocaleService.getDisplayLanguage(
                  //                 valueItem.languageCode)["name"])));
                  //       }).toList(),
                  //     ),

                  ///
                  DropdownButton(
                    alignment: Alignment.center,
                    //value: note1,
                    value: settingObserver.userSettings.locale,
                    items: supportedLocales.map((valueItem) {
                      return DropdownMenuItem(
                          value: valueItem,
                          child: Text((LocaleService.getDisplayLanguage(
                              valueItem.languageCode)["name"])));
                    }).toList(),
                    onChanged: (Locale? newLocale) {
                      setState(() {
                        if (newLocale != null) {
                          settingObserver.userSettings.locale = newLocale;
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    I18n.of(context)!.theme,
                    //'Theme',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<AppTheme>(
                    alignment: Alignment.center,
                    value: settingObserver.userSettings.appTheme,
                    items: themes
                        .map<DropdownMenuItem<AppTheme>>((AppTheme value) {
                      return DropdownMenuItem<AppTheme>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (AppTheme? newValue) {
                      setState(() {
                        settingObserver.userSettings.appTheme = newValue!;
                      });
                    },
                  ),
                ],
              ),
              addTopDivider(),
              addBotDivider(),

              /// Caregiver Mode Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        screenNav.changeScreen(MENU_SCREENS.LOGIN);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => LoginForm()));
                  },
                      child: Text(
                          'Enable Caregiver Mode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black
                      ),
                      ),
                    style: TextButton.styleFrom(
                      elevation: 1.0,
                      alignment: Alignment.center,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0),
                        ),
                      ),
                      backgroundColor: Colors.grey[400],
                    ),
                  ),

                ],
              ),

              addTopDivider(),
              addBotDivider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Cancel Button
                  GestureDetector(
                      onTap: () {
                        // final screenNav =
                        //     Provider.of<MenuObserver>(context, listen: false);
                        // screenNav.changeScreen(MENU_SCREENS.MENU);
                        screenNav.changeScreen(MAIN_SCREENS.MENU);
                      },
                      child: Column(
                        children: [
                          Transform.rotate(
                              angle: 180 * math.pi / 180,
                              child: Icon(
                                Icons.exit_to_app_rounded,
                                size: ICON_SIZE,
                                color: Colors.red,
                              )),
                          Text(
                            I18n.of(context)!.cancel,
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      )
                  ),

                  ///SAVE BUTTON
                  GestureDetector(
                      onTap: () {
                        settingObserver.saveSetting();
                        I18n.onLocaleChanged!(
                            settingObserver.userSettings.locale);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.save,
                            size: ICON_SIZE,
                            color: Colors.green,
                          ),
                          Text(
                            I18n.of(context)!.save,
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      )
                  ),

                  /// Reset Button
                  GestureDetector(
                    onTap: () {
                      Setting setting = settingObserver.userSettings;
                      setting.menuFontSize = DEFAULT_FONT_SIZE;
                      setting.noteFontSize = DEFAULT_FONT_SIZE;
                      setting.daysToKeepFiles = DEFAULT_DAYS_TO_KEEP_FILES;
                      setting.locale = DEFAULT_LOCALE;
                      setting.appTheme = DEFAULT_APP_THEME;
                      settingObserver.saveSetting();

                      I18n.onLocaleChanged!(DEFAULT_LOCALE);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.restore,
                          size: ICON_SIZE,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          I18n.of(context)!.resetSettings,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}

Divider addTopDivider() {
  return Divider(
    thickness: 2.0,
    indent: 5,
    endIndent: 5,
  );
}

Divider addBotDivider() {
  return Divider(
    thickness: 2.0,
    indent: 5,
    height: 40,
    endIndent: 5,
  );
}

//
// Text(I18n.of(context)!.daysToKeepNotes,
// style: Theme.of(context).textTheme.bodyText2),
// Padding(
// padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
// child: Container(
// width: 60,
// height: 40,
// padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 1),
// ),
// child: DropdownButton(
// hint: Text(
// I18n.of(context)!.promptNoteDeletionTimeline,
// style: Theme.of(context).textTheme.bodyText1,
// ),
// icon: Icon(
// // Add this
// Icons.edit_sharp, // Add this
// color: Colors.blue, // Add this
// ),
// value: settingObserver.userSettings.daysToKeepFiles,
// onChanged: (String? newValue) {
// setState(() {
// settingObserver.userSettings.daysToKeepFiles =
// newValue ?? DEFAULT_DAYS_TO_KEEP_FILES;
// });
// },
// isExpanded: true,
// underline: SizedBox(),
// style: Theme.of(context).textTheme.bodyText1,
// items: daysToKeepFilesOptions.map((valueItem) {
// return DropdownMenuItem(
// value: valueItem, child: Text((valueItem)));
// }).toList(),
// ),
// ),
// ),
// Text(I18n.of(context)!.noteFontSize,
// style: Theme.of(context).textTheme.bodyText2),
// Padding(
// padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
// child: Container(
// width: 60,
// height: 40,
// padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 1),
// ),
// child: DropdownButton(
// hint: Text(
// I18n.of(context)!.promptNoteFontSize,
// style: Theme.of(context).textTheme.bodyText1,
// ),
// icon: Icon(
// // Add this
// Icons.edit_sharp, // Add this
// color: Colors.blue, // Add this
// ),
// value: settingObserver.userSettings.noteFontSize,
// onChanged: (FontSize? newValue) {
// setState(() {
// settingObserver.userSettings.noteFontSize =
// newValue ?? DEFAULT_FONT_SIZE;
// });
// },
// isExpanded: true,
// underline: SizedBox(),
// style: Theme.of(context).textTheme.bodyText1,
// items: fontSizes.map((valueItem) {
// return DropdownMenuItem(
// value: valueItem,
// child: Text((fontSizeToDisplayName(valueItem))));
// }).toList(),
// ),
// ),
// ),
// Text(I18n.of(context)!.menuFontSize,
// style: Theme.of(context).textTheme.bodyText2),
// Padding(
// padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
// child: Container(
// width: 60,
// height: 40,
// padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 1),
// ),
// child: DropdownButton(
// hint: Text(
// I18n.of(context)!.promptMenuFontSize,
// style: Theme.of(context).textTheme.bodyText1,
// ),
// icon: Icon(
// // Add this
// Icons.edit_sharp, // Add this
// color: Colors.blue, // Add this
// ),
// value: settingObserver.userSettings.menuFontSize,
// onChanged: (FontSize? newValue) {
// setState(() {
// settingObserver.userSettings.menuFontSize =
// newValue ?? DEFAULT_FONT_SIZE;
// });
// },
// isExpanded: true,
// underline: SizedBox(),
// style: Theme.of(context).textTheme.bodyText1,
// items: fontSizes.map((valueItem) {
// return DropdownMenuItem(
// value: valueItem,
// child: Text((fontSizeToDisplayName(valueItem))));
// }).toList(),
// ),
// ),
// ),
// Text(I18n.of(context)!.language,
// style: Theme.of(context).textTheme.bodyText2),
// Padding(
// padding: const EdgeInsets.all(3),
// child: Container(
// width: 60,
// height: 40,
// padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 1),
// ),
// child: DropdownButton(
// hint: Text(
// I18n.of(context)!.selectLanguage,
// style: Theme.of(context).textTheme.headline6,
// ),
// //icon: Icon(                // Add this
// //  Icons.arrow_drop_down_outlined,  // Add this
// //  color: Colors.blue,   // Add this
// //),
// icon: Image.asset(
// // Add this
// //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
// "assets/images/dropdownarrow.png",
// width: 28,
// height: 18,
// //Icons.arrow_drop_down_outlined,
// //size: 31,
// color: Colors.blue, // Add this
// ),
// value: settingObserver.userSettings.locale,
// onChanged: (Locale? newLocale) {
// setState(() {
// if (newLocale != null) {
// settingObserver.userSettings.locale = newLocale;
// }
// });
// },
// isExpanded: true,
// underline: SizedBox(),
// style: Theme.of(context).textTheme.bodyText1,
// items: supportedLocales.map((valueItem) {
// return DropdownMenuItem(
// value: valueItem,
// child: Text((LocaleService.getDisplayLanguage(
// valueItem.languageCode)["name"])));
// }).toList(),
// ),
// ),
// ),
// Text(I18n.of(context)!.theme,
// style: Theme.of(context).textTheme.bodyText2),
// Padding(
// padding: const EdgeInsets.all(3),
// child: Container(
// width: 60,
// height: 40,
// padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 1),
// ),
// child: DropdownButton(
// hint: Text(
// I18n.of(context)!.promptTheme,
// style: Theme.of(context).textTheme.headline6,
// ),
// //icon: Icon(                // Add this
// //  Icons.arrow_drop_down_outlined,  // Add this
// //  color: Colors.blue,   // Add this
// //),
// icon: Image.asset(
// // Add this
// //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
// "assets/images/dropdownarrow.png",
// width: 28,
// height: 18,
// //Icons.arrow_drop_down_outlined,
// //size: 31,
// color: Colors.blue, // Add this
// ),
// value: settingObserver.userSettings.appTheme,
// onChanged: (AppTheme? newTheme) {
// setState(() {
// settingObserver.userSettings.appTheme =
// newTheme ?? DEFAULT_APP_THEME;
// });
// },
// isExpanded: true,
// underline: SizedBox(),
// style: Theme.of(context).textTheme.bodyText1,
// items: themes.map((theme) {
// return DropdownMenuItem(
// value: theme, child: Text(themeToDisplayName(theme)));
// }).toList(),
// ),
// ),
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// GestureDetector(
// onTap: () {
// final screenNav =
// Provider.of<MenuObserver>(context, listen: false);
// screenNav.changeScreen(MENU_SCREENS.MENU);
// },
// child: Column(
// children: [
// Transform.rotate(
// angle: 180 * math.pi / 180,
// child: Icon(
// Icons.exit_to_app_rounded,
// size: ICON_SIZE,
// color: Colors.amber,
// )),
// Text(
// I18n.of(context)!.cancel,
// style: Theme.of(context).textTheme.bodyText1,
// )
// ],
// )),
// //SAVE BUTTON
// GestureDetector(
// onTap: () {
// settingObserver.saveSetting();
// I18n.onLocaleChanged!(
// settingObserver.userSettings.locale);
// },
// child: Column(
// children: [
// Icon(
// Icons.save,
// size: ICON_SIZE,
// color: Colors.green,
// ),
// Text(
// I18n.of(context)!.save,
// style: Theme.of(context).textTheme.bodyText1,
// )
// ],
// )),
// GestureDetector(
// onTap: () {
// Setting setting = settingObserver.userSettings;
// setting.menuFontSize = DEFAULT_FONT_SIZE;
// setting.noteFontSize = DEFAULT_FONT_SIZE;
// setting.daysToKeepFiles = DEFAULT_DAYS_TO_KEEP_FILES;
// setting.locale = DEFAULT_LOCALE;
// setting.appTheme = DEFAULT_APP_THEME;
// settingObserver.saveSetting();
//
// I18n.onLocaleChanged!(DEFAULT_LOCALE);
// },
// child: Column(
// children: [
// Icon(
// Icons.restore,
// size: ICON_SIZE,
// color: Colors.blueAccent,
// ),
// Text(
// I18n.of(context)!.resetSettings,
// style: Theme.of(context).textTheme.bodyText1,
// ),
// ],
// ))
// ],
// ),

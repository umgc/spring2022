import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Services/LocaleService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import 'dart:math' as math;

List<FontSize> fontSizes = [FontSize.SMALL, FontSize.MEDIUM, FontSize.LARGE];
List<String> minutesBeforeNotification = [
  '1',
  '2',
  '3',
  '5',
  '10',
  '30'
]; // can add padding to keep dropdown menu on screen
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
                      Text('Notes',
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
                    'Enable Notifications',
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
                    'Minutes Before Notification',
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

                        ///Maybe dont need a save icon, just a reset
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
                    'Days To Keep Notes',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    alignment: Alignment.center,
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
                            newValue!;

                        ///null check
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
                      Text('Tasks',
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
                    'Enable Notifications',
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
                    'Minutes Before Notification',
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
                      Text('App Settings',
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
                    'Language',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ///specific predefined parts are translated???
                  // Text(
                  //   I18n.of(context)!.cancel,
                  //   //locale: settingObserver.userSettings.locale,
                  //   style: Theme.of(context).textTheme.bodyText1,
                  // ),

                  ///

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
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Theme',
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

                        settingObserver.userSettings.appTheme = newValue!;///???????????????????
                        print('What themes?');

                        ///remove after testing
                      });
                    },
                  ),
                ],
              ),
              addTopDivider(),
              addBotDivider(),

              /**
             * Triggers section of the screen
             */
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Triggers',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800])),
                    ],
                  ),
                ],
              ),

              /**
             * Invisible Box for spacing
             */
              SizedBox(
                height: 12.0,
              ),

              /**
             * Start Recording Trigger
             */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Start Recording',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Container(
                height: 35.0,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Placeholder text.',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                  onChanged: (value) {
                    // onChanged: (Locale? newLocale) {
                    //   setState(() {
                    //     if (newLocale != null) {
                    //       settingObserver.userSettings.locale = newLocale;
                    //     }
                    //   });
                    // },
                  },
                ),
              ),

              /**
             * Invisible Box for spacing.
             */
              SizedBox(
                height: 12.0,
              ),

              /**
             * Stop Recording Trigger
             */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Stop Recording',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Container(
                height: 35.0,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Placeholder text.',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                  onChanged: (value) {},
                ),
              ),

              /**
             * Invisible Box for spacing
             */
              SizedBox(
                height: 12.0,
              ),

              /**
             * Playback Notes Trigger
             */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Playback Notes',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Container(
                height: 35.0,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Placeholder text.',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                  onChanged: (value) {
                    //print(settingObserver.userSettings);
                  },
                ),
              ),

              //end Playback Notes section

              SizedBox(
                height: 20,
              ),
              /**
             * for testing functionality*********************************************************************
             */
//             Text(I18n.of(context)!.daysToKeepNotes,
//                 style: Theme.of(context).textTheme.bodyText2),
//             Padding(
//               padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
//               child: Container(
//                 width: 60,
//                 height: 40,
//                 padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black, width: 1),
//                 ),
//                 child: DropdownButton(
//                   onTap: () => print('tap tap'),
//                   hint: Text(
//                     I18n.of(context)!.promptNoteDeletionTimeline,
//                     style: Theme.of(context).textTheme.bodyText1,
//                   ),
//                   icon: Icon(
// // Add this
//                     Icons.edit_sharp, // Add this
//                     color: Colors.blue, // Add this
//                   ),
//                   value: settingObserver.userSettings.daysToKeepFiles,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                      // settingObserver.userSettings.daysToKeepFiles =
//                     //      newValue ?? DEFAULT_DAYS_TO_KEEP_FILES;
//                     });
//                   },
//                   isExpanded: true,
//                   underline: SizedBox(),
//
//                   style: Theme.of(context).textTheme.bodyText1,
//                   items: daysToKeepFilesOptions.map((valueItem) {
//                     return DropdownMenuItem(
//                         value: valueItem, child: Text((valueItem)));
//                   }).toList(),
//
//                 ),
//               ),
//             ),

              /***********************************************************************
             * for testing functionality
             */

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        final screenNav =
                            Provider.of<MenuObserver>(context, listen: false);
                        screenNav.changeScreen(MENU_SCREENS.MENU);
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
                      )),
//SAVE BUTTON
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
                      )),
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

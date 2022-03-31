import 'package:flutter/material.dart';
import 'package:memorez/Screens/AdminPage.dart';
import 'package:memorez/Screens/LoginPage.dart';
import 'package:memorez/Screens/UpdateAdmin.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/Setting.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Services/LocaleService.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import '../../DatabaseHandler/database_helper_profile.dart';
import '../../Model/UserModel.dart';
import '../../Observables/ScreenNavigator.dart';

List<FontSize> fontSizes = [FontSize.SMALL, FontSize.MEDIUM, FontSize.LARGE];
List<String> _minutesBeforeNoteNotification = ['1', '2', '3', '5', '10', '30'];
List<String> _minutesBeforeTaskNotification = ['1', '2', '3', '5', '10', '30'];
List<AppTheme> themes = [AppTheme.BLUE, AppTheme.PINK];

List<String> _daysToKeepFilesOptions = ["1", "3", "5", "7", "14", "Forever"];

bool careMode = false;

class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  // is caregiver loggedin?

  final _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  var _conUserId = TextEditingController();

  UserModel? get userData => null;

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();

  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text = sp.getString("user_id")!;
      _conUserId.text == 'Admin'? careMode = true : careMode = false;
    });
  }

  void removeSP(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
  }

  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);
    // screenNav.changeScreen(MENU_SCREENS.SETTING);
    final settingObserver = Provider.of<SettingObserver>(context);
    final supportedLocales = GeneratedLocalizationsDelegate().supportedLocales;
    _conUserId.text == 'Admin'? careMode = true : careMode = false;

    ///Helper method to convert theme names from all caps to normal text.
    _themeToDisplayName(AppTheme appTheme) {
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

    ///Helper method to convert font size names from all caps to normal text.
    _fontToDisplayName(FontSize fontName) {
      switch (fontName) {
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

    /// Font size of section headers
    double _sectionFontSize =
        (Theme.of(context).textTheme.bodyText1?.fontSize)! * 1.4;

    /// Font size of body text
    double? _bodyFontSize = Theme.of(context).textTheme.bodyText1?.fontSize;

    /// Size of the Cancel, Save, and Reset icons.
    final double _iconSize = 40.00;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (careMode) ...[
                Row(
                  children: <Widget>[
                    /// Notes Section
                    Row(
                      children: [
                        Text(
                          I18n.of(context)!.notesScreenName,
                          style: TextStyle(
                            //fontSize: getSize2(),
                            fontSize: _sectionFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
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
                          fontSize: _bodyFontSize, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value:
                          settingObserver.userSettings.enableNotesNotifications,
                      onChanged: (bool newValue) {
                        setState(() {
                          settingObserver
                              .userSettings.enableNotesNotifications = newValue;
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
                    Flexible(
                      child: Text(
                        //'Minutes Before Notification',
                        
                        I18n.of(context)!.minutesBeforeNotifications,
                        style: TextStyle(
                          fontSize: _bodyFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      alignment: Alignment.center,
                      value: settingObserver
                          .userSettings.minutesBeforeNoteNotifications,
                      items: _minutesBeforeNoteNotification
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: _bodyFontSize,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          settingObserver.userSettings
                              .minutesBeforeNoteNotifications = newValue!;
                        });
                      },
                    ),
                  ],
                ),

                /// Setting previously used to save Notes a specified number of days
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Flexible(
                //       child: Text(
                //         I18n.of(context)!.daysToKeepNotes,
                //         //'Days To Keep Notes',
                //         style: TextStyle(
                //           fontSize: _bodyFontSize,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     DropdownButton<String>(
                //       alignment: Alignment.center,
                //
                //       /// This may need to be changed to new variable.*****************
                //       value: settingObserver.userSettings.daysToKeepFiles,
                //       items: _daysToKeepFilesOptions
                //           .map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(
                //             value,
                //             style: TextStyle(
                //               fontSize: _bodyFontSize,
                //             ),
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           settingObserver.userSettings.daysToKeepFiles =
                //               newValue!;
                //
                //           /// This may need to be changed to new variable.*****************
                //
                //           //null check
                //         });
                //       },
                //     ),
                //   ],
                // ),
                _addTopDivider(),
                _addBotDivider(),

                /// Tasks section
                Row(
                  children: <Widget>[
                    Row(
                      children: [
                        Text(I18n.of(context)!.tasks,
                            //'Tasks',
                            style: TextStyle(
                                fontSize: _sectionFontSize,
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
                        fontSize: _bodyFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value:
                          settingObserver.userSettings.enableTasksNotifications,
                      onChanged: (bool newValue) {
                        setState(() {
                          settingObserver
                              .userSettings.enableTasksNotifications = newValue;
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
                    Flexible(
                      child: Text(
                        
                        I18n.of(context)!.minutesBeforeNotifications,
                        //'Minutes Before Notification',
                        style: TextStyle(
                          fontSize: _bodyFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      alignment: Alignment.center,
                      value: settingObserver
                          .userSettings.minutesBeforeTaskNotifications,
                      items: _minutesBeforeTaskNotification
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: _bodyFontSize,
                            ),
                          ),
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
                _addTopDivider(),
                _addBotDivider(),
              ],

              ///App Settings Section
              Row(
                children: <Widget>[
                  Flexible(
                    child: 
                      Text(I18n.of(context)!.appSettings,
                          //'App Settings',
                          style: TextStyle(
                              //fontSize: 20.0,
                              fontSize: _sectionFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800])),
                    
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      I18n.of(context)!.fontSize,
                      style: TextStyle(
                        fontSize: _bodyFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButton<FontSize?>(
                    alignment: Alignment.center,
                    value: settingObserver.userSettings.menuFontSize,
                    items: fontSizes
                        .map<DropdownMenuItem<FontSize>>((FontSize value) {
                      return DropdownMenuItem<FontSize>(
                        value: value,
                        child: Text(
                          _fontToDisplayName(value),
                          style: TextStyle(
                            fontSize: _bodyFontSize,
                          ),
                        ),
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
                      fontSize: _bodyFontSize,
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
                        child: Text(
                          (LocaleService.getDisplayLanguage(
                              valueItem.languageCode)["name"]),
                          style: TextStyle(
                            fontSize: _bodyFontSize,
                          ),
                        ),
                      );
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
                      fontSize: _bodyFontSize,
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
                        child: Text(
                          _themeToDisplayName(value),
                          style: TextStyle(
                            fontSize: _bodyFontSize,
                          ),
                        ),
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
              _addTopDivider(),
              _addBotDivider(),

              /// Caregiver Mode Button

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 11),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
               _conUserId.text != 'Admin'?
                      TextButton(
                        onPressed: () {
                          // screenNav.changeScreen(MAIN_SCREENS
                          //     .MENU); ///////////////////////////////put new screen
                          // careMode = true;
                          // screenNav.changeScreen(MENU_SCREENS.SETTING);
                          careMode = true;
                          // screenNav.changeScreen(MENU_SCREENS.LOGIN);
                          screenNav.changeScreen(MENU_SCREENS.SETTING);
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>
                              LoginForm()));

                        },

                        child: Text(
                          I18n.of(context)!.enableCaregiverMode,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _bodyFontSize,
                              color: Colors.white),
                        ),

                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          elevation: 1.0,
                          alignment: Alignment.center,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          backgroundColor: Color(0xFF0D47A1),
                        ),
                      ):

                      TextButton(
                        onPressed: () {
                          // screenNav.changeScreen(MAIN_SCREENS
                          //     .MENU); ///////////////////////////////put new screen
                          // careMode = true;
                          // screenNav.changeScreen(MENU_SCREENS.SETTING);
                          careMode = true;

                          // screenNav.changeScreen(CAREGIVER_SCREENS.CAREGIVER);
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>
                              UpdateAdmin()));


                        },
                        child: Text(
                          I18n.of(context)!.updateCaregiver,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _bodyFontSize,
                              color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          elevation: 1.0,
                          alignment: Alignment.center,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          backgroundColor: Color(0xFF0D47A1),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      //   child: GestureDetector(
                      //       onTap: () {
                      //         careMode = false;
                      //         screenNav.changeScreen(CAREGIVER_SCREENS.CAREGIVER);
                      //       },
                      //       child: Column(
                      //         children: [
                      //           Icon(
                      //             Icons.supervised_user_circle,
                      //             size: 40.0,
                      //             color: Colors.red,
                      //           ),
                      //           Text(
                      //             'Update Caregiver',
                      //             style: TextStyle(fontSize: 14),
                      //           )
                      //         ],
                      //       )),
                      // ),

                  ],
                ),
              ),

              _addTopDivider(),
              _addBotDivider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                size: _iconSize,
                                color: Colors.red,
                              )),
                          Text(
                            I18n.of(context)!.cancel,
                            style: TextStyle(
                                fontSize: _bodyFontSize,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),

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
                            size: _iconSize,
                            color: Colors.green,
                          ),
                          Text(
                            I18n.of(context)!.save,
                            style: TextStyle(
                                fontSize: _bodyFontSize,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
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
                          size: _iconSize,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          I18n.of(context)!.resetSettings,
                          style: TextStyle(
                              fontSize: _bodyFontSize,
                              fontWeight: FontWeight.bold),
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

Divider _addTopDivider() {
  return Divider(
    thickness: 2.0,
    indent: 5,
    endIndent: 5,
  );
}

Divider _addBotDivider() {
  return Divider(
    thickness: 2.0,
    indent: 5,
    height: 40,
    endIndent: 5,
  );
}

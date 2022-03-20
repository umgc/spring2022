import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorez/Screens/UpdateAdmin.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/Observables/HelpObservable.dart';
import 'package:memorez/Observables/MicObservable.dart';
import 'package:memorez/Observables/NoteObservable.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Screens/AdminPage.dart';
import 'package:memorez/Screens/LoginPage.dart';
import 'package:memorez/Screens/Mic/Mic.dart';
import 'package:memorez/Screens/Profile/edit_profile_page.dart';
import '../../Observables/MenuObservable.dart';
import 'package:memorez/Screens/Note/Note.dart';
import 'package:memorez/Screens/Note/NoteSearchDelegate.dart';
import 'package:memorez/Screens/NotificationScreen.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/Utility/ThemeUtil.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:memorez/Screens/Settings/Help.dart';
import '../DatabaseHandler/DbHelper.dart';
import '../Model/UserModel.dart';
import 'Profile/UserProfile.dart';
import 'Settings/Setting.dart';
import 'Note/Note.dart';
import 'package:memorez/Screens/Menu/Menu.dart';
import 'package:memorez/Screens/Settings/Trigger.dart';
import 'package:memorez/Screens/Settings/Help.dart';
import 'package:memorez/Screens/Settings/SyncToCloud.dart';

import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import '../Observables/ScreenNavigator.dart';
import 'package:memorez/Screens/Calendar/Calendar.dart';
import 'Checklist.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:memorez/Screens/Tasks/tasks.dart';
import 'package:memorez/Screens/HomePage.dart';
import 'dart:io';

final mainScaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateful widget that the main application instantiates.
class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  var _conUserId = TextEditingController();

  UserModel? get userData => null;
  bool adminModeEnabled = false;
  String weWantToSeeConUserId = "";
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
      weWantToSeeConUserId = _conUserId.text;
      // print("line 81 xxxxxx" + weWantToSeeConUserId);
      if (_conUserId.text == "Admin") {
        adminModeEnabled = true;
      } else {
        adminModeEnabled = false;
      }
    });
  }

  void removeSP(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
  }

  int _currentIndex = 0;

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(I18n.of(context)!.no),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(I18n.of(context)!.yes),
        ),
      ],
    );
  }

  Widget _changeScreen(screen, index) {
    print("index $index");
    final screenNav = Provider.of<MainNavObserver>(context);

    //main screen
    if (screen == MENU_SCREENS.HELP || index == 2) {
      screenNav.setTitle(I18n.of(context)!.help);

      return Help();
    }
    if (screen == MAIN_SCREENS.MENU || index == 0) {
      screenNav.setTitle(I18n.of(context)!.menuScreenName);
      return Menu();
    }
    if (screen == MAIN_SCREENS.HOME || index == 1) {
      // screenNav.setTitle(I18n.of(context)!.homeScreenName);
      screenNav.setTitle(I18n.of(context)!.chat);
      return SpeechScreen();
    }
    if (screen == MAIN_SCREENS.CALENDAR) {
      screenNav.setTitle(I18n.of(context)!.calendarScreenName);
      return Calendar();
    }
    if (screen == MAIN_SCREENS.CHECKLIST) {
      screenNav.setTitle(I18n.of(context)!.checklistScreenName);
      return Checklist();
    }
    if (screen == MAIN_SCREENS.NOTE) {
      // screenNav.setTitle(I18n.of(context)!.checklistScreenName);
      screenNav.setTitle(I18n.of(context)!.notesScreenName);
      return Note();
    }
    if (screen == MAIN_SCREENS.NOTIFICATION) {
      screenNav.setTitle(I18n.of(context)!.notificationsScreenName);
      return NotificationScreen();
    }
    if (screen == MAIN_SCREENS.TASKS) {
      // screenNav.setTitle(I18n.of(context)!.checklistScreenName);
      screenNav.setTitle(I18n.of(context)!.tasks);
      return Tasks();
    }
    if (screen == MENU_SCREENS.USERPROFILE) {
      screenNav.setTitle(I18n.of(context)!.profile);
      return UserProfile();
    }

    if (screen == PROFILE_SCREENS.UPDATE_USERPROFILE) {
      screenNav.setTitle(I18n.of(context)!.editpatientinformation);
      return EditProfilePage();
    }

    if (screen == MENU_SCREENS.LOGIN) {
      screenNav.setTitle("Caregiver Login");
      return LoginForm();
    }
    if (screen == CAREGIVER_SCREENS.CAREGIVER) {
      screenNav.setTitle('Caregiver Screen');
      return UpdateAdmin();
    }

    //menu screens
    if (screen == MENU_SCREENS.HELP || index == 2) {
      screenNav.setTitle(I18n.of(context)!.menuScreenName);
      return Help();
    }
    if (screen == MENU_SCREENS.SYNC_TO_CLOUD) {
      screenNav.setTitle(I18n.of(context)!.syncToCloudScreen);
      return SyncToCloud();
    }
    if (screen == MENU_SCREENS.TRIGGER) {
      screenNav.setTitle(I18n.of(context)!.trigger);
      return Trigger();
    }
    if (screen == MENU_SCREENS.SETTING) {
      //screenNav.setTitle(I18n.of(context)!.settingScreenName);
      screenNav.setTitle(I18n.of(context)!.generalSetting);
      return Settings();
    }

    return Text("Wrong Screen - fix it");
  }

  // flag to control whether or not results are read
  bool readResults = false;

  // flag to indicate a voice search
  bool voiceSearch = false;

  // Search bar to insert in the app bar header
  late SearchBar searchBar;

  // voice helper service

  /// Value of search filter to be used in filtering search results
  String searchFilter = "";

  /// Search is submitted from search bar
  onSubmitted(value) {
    if (voiceSearch) {
      voiceSearch = false;
      readResults = true;
    }
    searchFilter = value;
    setState(() => mainScaffoldKey.currentState);
  }

  // Search has been cleared from search bar
  onCleared() {
    searchFilter = "";
  }

  // _getSearchBar() {
  //   searchFilter = "";
  //   return new SearchBar(
  //       inBar: false,
  //       setState: setState,
  //       onSubmitted: onSubmitted,
  //       onCleared: onCleared,
  //       buildDefaultAppBar: buildAppBar);
  // }

  _onClickMic(MicObserver micObserver, MainNavObserver screenNav) {
    micObserver.toggleListeningMode();

    print("${MAIN_SCREENS.HOME} and ${screenNav.currentScreen}");
    if (screenNav.currentScreen != MAIN_SCREENS.HOME) {
      screenNav.changeScreen(MAIN_SCREENS.HOME);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final micObserver = Provider.of<MicObserver>(context);
    final screenNav = Provider.of<MainNavObserver>(context);
    screenNav.changeScreen(MAIN_SCREENS.MENU);
    final settingObserver = Provider.of<SettingObserver>(context);
    HelpObserver helpObserver = Provider.of<HelpObserver>(context);
    helpObserver.loadHelpCotent();
    final menuObserver = Provider.of<MenuObserver>(context);
    return Observer(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          //removes the backbutton in the appbar
          automaticallyImplyLeading: false,
          titleTextStyle: TextStyle(color: Colors.black),
          toolbarHeight: 50,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(
                  builder: (_) => Text(
                        '${screenNav.screenTitle}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
              ),
              Visibility(
                visible: adminModeEnabled,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red[200],
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 5.0),
                                  child: Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 1.0),
                                  child: TextButton(
                                    child: Text(
                                      'Exit CareGiver',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        removeSP("Admin");
                                        adminModeEnabled = false;
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
            //margin: const EdgeInsets.only(bottom: 30.0),
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Center(
                child: _changeScreen(
                    screenNav.currentScreen, screenNav.focusedNavBtn))),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: screenNav.setFocusedBtn,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            // showUnselectedLabels: true,
            // showSelectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  child: Observer(
                    builder: (_) => Container(
                      child: new IconButton(
                          icon: new Icon(Icons.home),
                          color: (screenNav.focusedNavBtn == 0)
                              ? Colors.white
                              : Colors.black,
                          iconSize: 40,
                          onPressed: () {
                            screenNav.changeScreen(MAIN_SCREENS.MENU);
                            screenNav.setFocusedBtn(0);
                            _currentIndex = 0;
                            micObserver.micIsExpectedToListen = false;
                          }),
                    ),
                  ),
                ),
                label: I18n.of(context)!.menuScreenName,
                // label: I18n.of(context)!.notesScreenName,
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    // constraints: BoxConstraints(),
                    child: Observer(
                      builder: (_) => AvatarGlow(
                        endRadius: 29,
                        animate: micObserver.micIsExpectedToListen,
                        child: IconButton(
                            icon: new Icon(Icons.mic),
                            iconSize: 43,
                            color: (screenNav.focusedNavBtn == 1)
                                ? Colors.white
                                : Colors.black,
                            onPressed: () => {
                                  _onClickMic(micObserver, screenNav),
                                  screenNav.setFocusedBtn(1),
                                  _currentIndex = 1,
                                }),
                      ),
                    ),
                  ),
                  label: I18n.of(context)!.chat),

              // ),
              BottomNavigationBarItem(
                icon: Container(
                  child: Observer(
                    builder: (_) => Container(
                      child: IconButton(
                          icon: new Icon(Icons.help_outline),
                          color: (screenNav.focusedNavBtn == 2)
                              ? Colors.white
                              : Colors.black,
                          iconSize: 40,
                          onPressed: () {
                            screenNav.changeScreen(MENU_SCREENS.HELP);
                            screenNav.setFocusedBtn(2);
                            _currentIndex = 2;
                            micObserver.micIsExpectedToListen = false;
                          }),
                    ),
                  ),
                ),
                label: I18n.of(context)!.help,
                // label: I18n.of(context)!.notesScreenName,
              ),
            ]),
      ),
    );
  }
}

//TODO User FittedBox to resize according to the phone's size

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/HelpObservable.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Mic/Mic.dart';

import 'package:untitled3/Screens/Note/Note.dart';
import 'package:untitled3/Screens/Note/NoteSearchDelegate.dart';
import 'package:untitled3/Screens/NotificationScreen.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/Utility/ThemeUtil.dart';
import 'package:untitled3/generated/i18n.dart';

import 'Settings/Setting.dart';
import 'Note/Note.dart';
import 'package:untitled3/Screens/Menu/Menu.dart';
import 'package:untitled3/Screens/Settings/Trigger.dart';
import 'package:untitled3/Screens/Settings/Help.dart';
import 'package:untitled3/Screens/Settings/SyncToCloud.dart';

import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import '../Observables/ScreenNavigator.dart';
import 'calendar.dart';
import 'Checklist.dart';

import 'package:avatar_glow/avatar_glow.dart';

final mainScaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateful widget that the main application instantiates.
class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  Note _note = Note();
  Menu _menu = Menu();
  SpeechScreen _speechScreen = SpeechScreen();
  Calendar _calendar = Calendar();
  Checklist _checklist = Checklist();
  NotificationScreen _notificationScreen = NotificationScreen();
  Help _help = Help();
  Settings _settings = Settings();

  Widget _changeScreen(screen, index) {
    print("index $index");
    final screenNav = Provider.of<MainNavObserver>(context);

    //main screen
    if (screen == MAIN_SCREENS.NOTE || index == 2) {
      screenNav.setTitle(I18n.of(context)!.notesScreenName);
      return _note;
    }
    if (screen == MAIN_SCREENS.MENU || index == 0) {
      screenNav.setTitle(I18n.of(context)!.menuScreenName);
      return Menu();
    }
    if (screen == MAIN_SCREENS.HOME) {
      screenNav.setTitle(I18n.of(context)!.homeScreenName);
      return _speechScreen;
    }
    if (screen == MAIN_SCREENS.CALENDAR) {
      screenNav.setTitle(I18n.of(context)!.calendarScreenName);
      return _calendar;
    }
    if (screen == MAIN_SCREENS.CHECKLIST) {
      screenNav.setTitle(I18n.of(context)!.checklistScreenName);
      return _checklist;
    }
    if (screen == MAIN_SCREENS.NOTIFICATION) {
      screenNav.setTitle(I18n.of(context)!.notificationsScreenName);
      return _notificationScreen;
    }

    //menu screens
    if (screen == MENU_SCREENS.HELP) {
      screenNav.setTitle(I18n.of(context)!.menuScreenName);
      return _help;
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
      screenNav.setTitle(I18n.of(context)!.settingScreenName);
      return _settings;
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

  _getSearchBar() {
    searchFilter = "";
    return new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: onCleared,
        buildDefaultAppBar: buildAppBar);
  }

  _onClickMic(MicObserver micObserver, MainNavObserver screenNav) {
    micObserver.toggleListeningMode();

    print("${MAIN_SCREENS.HOME} and ${screenNav.currentScreen}");
    if (screenNav.currentScreen != MAIN_SCREENS.HOME) {
      screenNav.changeScreen(MAIN_SCREENS.HOME);
    }
  }

  AppBar buildAppBar(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);
    return AppBar(
      toolbarHeight: 120,
      centerTitle: true,
      title: Column(
        children: [
          Row(
            //mainAxisAlignment:MainAxisAlignment.end,
            children: [
              Observer(
                  builder: (_) => Text(
                        '${screenNav.screenTitle}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                      )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    screenNav.changeScreen(MAIN_SCREENS.NOTIFICATION);
                  },
                  icon: Observer(
                      builder: (_) => Icon(
                            Icons.notification_add_outlined,
                            color: (screenNav.focusedNavBtn ==
                                    MAIN_SCREENS.NOTIFICATION)
                                ? Colors.white
                                : Colors.black,
                            size: 46,
                          ))),
              IconButton(
                  onPressed: () {
                    screenNav.changeScreen(MAIN_SCREENS.CHECKLIST);
                  },
                  icon: Observer(
                      builder: (_) => Icon(
                            Icons.checklist,
                            color: (screenNav.focusedNavBtn ==
                                    MAIN_SCREENS.CHECKLIST)
                                ? Colors.white
                                : Colors.black,
                            size: 46,
                          ))),
              IconButton(
                  onPressed: () {
                    screenNav.changeScreen(MAIN_SCREENS.CALENDAR);
                  },
                  icon: Observer(
                      builder: (_) => Icon(
                            Icons.event_note_outlined,
                            color: (screenNav.focusedNavBtn ==
                                    MAIN_SCREENS.CALENDAR)
                                ? Colors.white
                                : Colors.black,
                            size: 46,
                          )))
            ],
          )
        ],
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 50.0, right: 10),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: NoteSearchDelegate(),
                );
              },
              child: Icon(
                Icons.search,
                size: 35.0,
                color: Colors.black,
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final micObserver = Provider.of<MicObserver>(context);
    final screenNav = Provider.of<MainNavObserver>(context);
    final settingObserver = Provider.of<SettingObserver>(context);
    HelpObserver helpObserver = Provider.of<HelpObserver>(context);
    helpObserver.loadHelpCotent();

    return Observer(
        builder: (_) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildAppBar(context),
            body: Container(
                //margin: const EdgeInsets.only(bottom: 30.0),
                child: Center(
                    child: _changeScreen(
                        screenNav.currentScreen, screenNav.focusedNavBtn))),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 8.0,
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: screenNav.setFocusedBtn,
                    selectedItemColor: Colors.black,
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.black,
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    items: [
                      BottomNavigationBarItem(
                        icon: Observer(
                            builder: (_) => Icon(
                                  Icons.menu_book,
                                  size: 46,
                                  color: (screenNav.focusedNavBtn == 0)
                                      ? Colors.white
                                      : Colors.black,
                                )),
                        label: I18n.of(context)!.menuScreenName,
                      ),
                      BottomNavigationBarItem(
                          icon: Observer(
                              builder: (_) => Icon(
                                    Icons.mic,
                                    size: 46,
                                    color: (screenNav.focusedNavBtn == 1)
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                          label: ''),
                      BottomNavigationBarItem(
                        icon: Observer(
                            builder: (_) => Icon(
                                  Icons.notes,
                                  size: 46,
                                  color: (screenNav.focusedNavBtn == 2)
                                      ? Colors.white
                                      : Colors.black,
                                )),
                        label: I18n.of(context)!.notesScreenName,
                      ),
                    ]),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: AvatarGlow(
                animate: micObserver.micIsExpectedToListen,
                glowColor: Theme.of(context).primaryColor,
                endRadius: 80,
                duration: Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child: Container(
                    width: 120.0,
                    height: 85.0,
                    child: new RawMaterialButton(
                      shape: new CircleBorder(),
                      elevation: 0.01,
                      onPressed: () => {
                        _onClickMic(micObserver, screenNav)
                      }, //{screenNav.changeScreen(MAIN_SCREENS.HOME)},
                      child: Column(children: [
                        Image(
                          image: AssetImage("assets/images/mic.png"),
                          color: themeToColor(
                              settingObserver.userSettings.appTheme),
                          height: 80,
                          width: 80.82,
                        ),
                      ]),
                    )))));
  }
}
//TODO User FittedBox to resize according to the phone's size
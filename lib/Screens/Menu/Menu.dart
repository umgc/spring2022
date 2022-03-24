import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memorez/Observables/NoteObservable.dart';
import 'package:memorez/Observables/ScreenNavigator.dart';
import 'package:memorez/Screens/Settings/Setting.dart';
import 'package:memorez/generated/i18n.dart';
import '../../Observables/MenuObservable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Observables/TaskObservable.dart';
import '../../Utility/Constant.dart';
import 'package:memorez/Screens/Settings/Trigger.dart';
import 'package:memorez/Screens/Settings/Help.dart';
import 'package:memorez/Screens/Settings/SyncToCloud.dart';
import 'package:memorez/Screens/Main.dart';

class Menu extends StatefulWidget {
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  MainNavigator mainNavigator = new MainNavigator();

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context, listen: false);
    final menuObserver = Provider.of<MenuObserver>(context, listen: false);
    final taskObserver = Provider.of<TaskObserver>(context, listen: false);
    final screenNav = Provider.of<MainNavObserver>(context);
    return Observer(
        builder: (_) => (menuObserver.currentScreen == MENU_SCREENS.MENU)
            ? Scaffold(

          body: Column(

            children: <Widget>[

              Expanded(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    Expanded(

                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10, right: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.deepPurple,
                            textStyle: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.bars),
                              SizedBox(width: 15.0),
                              Text(
                                // 'TASKS',
                                I18n.of(context)!.tasks.toUpperCase(),
                              ),
                            ],
                          ),
                          onPressed: () {
                            screenNav.changeScreen(MAIN_SCREENS.TASKS);
                            taskObserver.changeScreen(TASK_SCREENS.TASK);

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10, right: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            textStyle: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.solidStickyNote),
                              SizedBox(width: 15.0),
                              Text(
                                //'NOTES',
                                I18n.of(context)!.notesScreenName.toUpperCase(),
                              ),
                            ],
                          ),
                          onPressed: () {
                            screenNav.changeScreen(MAIN_SCREENS.NOTE);
                            noteObserver.changeScreen(NOTE_SCREENS.NOTE);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10, right: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.lightBlueAccent,
                            textStyle: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.calendar),
                              SizedBox(width: 15.0),
                              Text(
                                //'CALENDAR',
                                I18n.of(context)!.calendarScreenName.toUpperCase(),
                              ),
                            ],
                          ),
                          onPressed: () {
                            screenNav.changeScreen(MAIN_SCREENS.CALENDAR);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10, right: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            textStyle: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.userAlt),
                              SizedBox(width: 15.0),
                              Text(
                                //'PROFILE',
                                I18n.of(context)!.profile.toUpperCase(),
                              ),
                            ],
                          ),
                          onPressed: () {
                            screenNav.changeScreen(MENU_SCREENS.USERPROFILE);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10, right: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.deepPurple,
                            textStyle: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.cog),
                              SizedBox(width: 15.0),
                              Text(
                                //'SETTINGS',
                                I18n.of(context)!.generalSetting.toUpperCase(),
                              ),
                            ],
                          ),
                          onPressed: () {
                            screenNav.changeScreen(MENU_SCREENS.SETTING);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Container(
              //     color: Colors.blue,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: <Widget>[
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Row(
              //               children: [
              //                 FaIcon(FontAwesomeIcons.home),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 TextButton(
              //                   style: TextButton.styleFrom(
              //                     primary: Colors.white,
              //                   ),
              //                   onPressed: () {},
              //                   child: const Text('MENU'),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Row(
              //               children: [
              //                 FaIcon(FontAwesomeIcons.microphone),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 TextButton(
              //                   style: TextButton.styleFrom(
              //                     primary: Colors.white,
              //                   ),
              //                   onPressed: () {},
              //                   child: const Text('CHAT'),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Row(
              //               children: [
              //                 FaIcon(FontAwesomeIcons.questionCircle),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 TextButton(
              //                   style: TextButton.styleFrom(
              //                     primary: Colors.white,
              //                   ),
              //                   onPressed: () {},
              //                   child: const Text('HELP'),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),

          /*LEGACY CODE*/ /*LEGACY CODE*/ /*LEGACY CODE*/
          // body: SingleChildScrollView(
          //     child: Column(
          //   children: <Widget>[
          //     Column(children: [
          //       Row(
          //         children: [
          //           Expanded(
          //               child: Container(
          //             margin: const EdgeInsets.only(
          //                 left: 20.0, right: 20.0, top: 20),
          //             height: 220,
          //             width: 174,
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   primary: Colors.grey,
          //                   onPrimary: Colors.white,
          //                   shadowColor: Colors.grey,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius:
          //                           BorderRadius.circular(30.0)),
          //                   minimumSize: Size(40, 40)),
          //               onPressed: () {
          //                 //menuObserver
          //                 //  .changeScreen(MENU_SCREENS.SYNC_TO_CLOUD);
          //               },
          //               child: Column(children: [
          //                 Image(
          //                   image: AssetImage("assets/images/Cloud.png"),
          //                   color: Colors.white,
          //                   height: 150,
          //                   width: 155,
          //                 ),
          //                 Text(I18n.of(context)!.syncToCloud,
          //                     style: TextStyle(
          //                         fontSize: 20, color: Colors.black))
          //               ]),
          //             ),
          //           )),
          //           Expanded(
          //               child: Container(
          //             margin: const EdgeInsets.only(
          //                 left: 0, right: 20.0, top: 20),
          //             height: 220,
          //             width: 174,
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   primary: Colors.grey,
          //                   onPrimary: Colors.white,
          //                   shadowColor: Colors.grey,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius:
          //                           BorderRadius.circular(30.0)),
          //                   minimumSize: Size(10, 10)),
          //               onPressed: () {
          //                 menuObserver.changeScreen(MENU_SCREENS.TRIGGER);
          //               },
          //               child: Column(children: [
          //                 Padding(
          //                   padding: new EdgeInsets.all(5.0),
          //                 ),
          //                 Image(
          //                   image:
          //                       AssetImage("assets/images/Trigger.png"),
          //                   color: Colors.white,
          //                   height: 140,
          //                   width: 90,
          //                 ),
          //                 Text(I18n.of(context)!.trigger,
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                       color: Colors.black,
          //                     ))
          //               ]),
          //             ),
          //           )),
          //         ],
          //       )
          //     ]),
          //     Column(children: [
          //       Row(
          //         children: [
          //           Expanded(
          //               child: Container(
          //             margin: const EdgeInsets.only(
          //                 left: 20.0, right: 20.0, top: 20),
          //             height: 220,
          //             width: 174,
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   primary: Colors.grey,
          //                   onPrimary: Colors.white,
          //                   shadowColor: Colors.grey,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius:
          //                           BorderRadius.circular(30.0)),
          //                   minimumSize: Size(10, 10)),
          //               onPressed: () {
          //                 menuObserver
          //                     .changeScreen(MENU_SCREENS.GENERAL_SETTING);
          //               },
          //               child: Column(children: [
          //                 Padding(
          //                   padding: new EdgeInsets.all(10.0),
          //                 ),
          //                 Image(
          //                   image:
          //                       AssetImage("assets/images/Setting.png"),
          //                   color: Colors.white,
          //                   height: 132,
          //                   width: 132,
          //                 ),
          //                 Padding(
          //                   padding: new EdgeInsets.all(10.0),
          //                 ),
          //                 Text(I18n.of(context)!.generalSetting,
          //                     style: TextStyle(
          //                         fontSize: 20, color: Colors.black))
          //               ]),
          //             ),
          //           )),
          //           Expanded(
          //               child: Container(
          //             margin: const EdgeInsets.only(
          //                 left: 0, right: 20.0, top: 20),
          //             height: 220,
          //             width: 174,
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   primary: Colors.grey,
          //                   onPrimary: Colors.white,
          //                   shadowColor: Colors.grey,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius:
          //                           BorderRadius.circular(30.0)),
          //                   minimumSize: Size(10, 10)),
          //               onPressed: () {
          //                 menuObserver.changeScreen(MENU_SCREENS.HELP);
          //               },
          //               child: Column(children: [
          //                 Padding(
          //                   padding: new EdgeInsets.all(5.0),
          //                 ),
          //                 Image(
          //                   image: AssetImage("assets/images/Help.png"),
          //                   color: Colors.white,
          //                   height: 150,
          //                   width: 155,
          //                 ),
          //                 Padding(
          //                   padding: new EdgeInsets.all(6.0),
          //                 ),
          //                 Text(I18n.of(context)!.help,
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                       color: Colors.black,
          //                     ))
          //               ]),
          //             ),
          //           )),
          //         ],
          //       )
          //     ]),
          //   ],
          // )),
        )
            : (menuObserver.currentScreen == MENU_SCREENS.TRIGGER)
            ? Trigger()
            : (menuObserver.currentScreen == MENU_SCREENS.HELP)
            ? Help()
            : (menuObserver.currentScreen ==
            MENU_SCREENS.GENERAL_SETTING)
            ? Settings()
            : (menuObserver.currentScreen ==
            MENU_SCREENS.SYNC_TO_CLOUD)
            ? SyncToCloud()
            : Text("Oopps"));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:untitled3/Observables/NotificationObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
  requestSoundPermission: false,
  requestBadgePermission: false,
  requestAlertPermission: false,
);

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    initializeSetting();
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationObserver = Provider.of<NotificationObserver>(context);
    final noteObserver = Provider.of<NoteObserver>(context);

    return Observer(
        builder: (_) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(18, 0, 0, 20)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          I18n.of(context)!.notesNotificiations,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Divider(
                        color: Colors.black87,
                        height: 20,
                        thickness: 2,
                      ),
                      SwitchListTile(
                        value: notificationObserver.noteNotification,
                        onChanged: (value) async {
                          notificationObserver.NoteNotification(value);
                          for (TextNote note in noteObserver.usersNotes) {
                            String dateTimeStr =
                                note.eventDate + " " + note.eventTime;
                            if (dateTimeStr.trim().isEmpty == false) {
                              DateTime dateTime = DateTime.parse(dateTimeStr);
                              DateTime now = DateTime.now();
                              if (!dateTime.isBefore(now)) {
                                displayNotification(note.text, dateTime);
                              }
                            }
                          }
                        },
                        title: Text(
                          I18n.of(context)!.turnOnNotesNotification,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      SwitchListTile(
                        value: notificationObserver.reminder,
                        onChanged: (value) async {
                          notificationObserver.NotificationReminder(value);
                          if (!notificationObserver.reminder) {
                            await cancelNotificationReminder();
                          } else {
                            for (TextNote note in noteObserver.usersNotes) {
                              String dateTimeStr =
                                  note.eventDate + " " + note.eventTime;
                              if (dateTimeStr.trim().isEmpty == false) {
                                DateTime dateTime = DateTime.parse(dateTimeStr);
                                DateTime now = DateTime.now();
                                DateTime scheduleTime =
                                    dateTime.subtract(Duration(minutes: 15));
                                if (scheduleTime ==
                                        dateTime
                                            .subtract(Duration(minutes: 15)) &&
                                    !scheduleTime.isBefore(now)) {
                                  repeatNotificationNote(
                                      note.text, scheduleTime);
                                }
                              }
                            }
                          }
                        },
                        title: Text(
                          I18n.of(context)!.turnOnEventReminder,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Text(
                        I18n.of(context)!.reminderStartTime,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          I18n.of(context)!.activitiesNotifications,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Divider(
                        color: Colors.black87,
                        height: 20,
                        thickness: 2,
                      ),
                      SwitchListTile(
                        value: notificationObserver.onWalking,
                        onChanged: (value) async {
                          notificationObserver.NotificationWalk(value);
                          print(notificationObserver.onWalking);
                          if (!notificationObserver.onWalking) {
                            await cancelWalkNotification();
                          } else {
                            repeatNotificationWalk();
                          }
                        },
                        title: Text(
                          I18n.of(context)!.turnOnHourlyWalkNotification,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      SwitchListTile(
                        value: notificationObserver.onWater,
                        onChanged: (value1) async {
                          notificationObserver.NotificationWater(value1);
                          print(notificationObserver.onWater);
                          if (!notificationObserver.onWater) {
                            await cancelWaterNotification();
                          } else {
                            repeatNotificationWater();
                          }
                        },
                        title: Text(
                          I18n.of(context)!.turnOnHourlyWaterNotification,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      SwitchListTile(
                        value: notificationObserver.Bathroom,
                        onChanged: (value2) async {
                          notificationObserver.NotificationBathroom(value2);
                          print(notificationObserver.Bathroom);
                          if (!notificationObserver.Bathroom) {
                            await cancelbathNotification();
                          } else {
                            repeatNotificationBathroom();
                          }
                        },
                        title: Text(
                          I18n.of(context)!.turnOnBathroomNotification,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

Future<void> displayNotification(String note, DateTime day) async {
  notificationsPlugin.zonedSchedule(
      0,
      'Note',
      note,
      tz.TZDateTime.from(day, tz.local),
      NotificationDetails(
        android:
            AndroidNotificationDetails('channel id', 'channel description'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: 'Note load');
}

Future<void> initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('my_logo');
  var initializeSetting = InitializationSettings(
      android: initializeAndroid, iOS: initializationSettingsIOS);
  await notificationsPlugin.initialize(initializeSetting,
      onSelectNotification: (payload) async {
    onSelectNotification('Note load');
  });
}

Future<void> repeatNotificationWater() async {
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 1',
    "CHANNEL_DESCRIPTION 1",
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iosChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  await notificationsPlugin.periodicallyShow(
    1,
    'WATER',
    'Please drink water',
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

repeatNotificationWalk() async {
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 2',
    "CHANNEL_DESCRIPTION 2",
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iosChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  await notificationsPlugin.periodicallyShow(
    2,
    'WALK',
    'Please take a walk',
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

repeatNotificationBathroom() async {
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 3',
    "CHANNEL_DESCRIPTION 3",
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iosChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  await notificationsPlugin.periodicallyShow(
    3,
    'BATHROOM',
    'Please go to the bathroom',
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

Future<void> repeatNotificationNote(String note, DateTime day) async {
  var androidChannelSpecifics = AndroidNotificationDetails(
    'CHANNEL_ID 1',
    "CHANNEL_DESCRIPTION 1",
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iosChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  await notificationsPlugin.periodicallyShow(
    4,
    "Reminder",
    note,
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

Future<void> cancelWaterNotification() async {
  await notificationsPlugin.cancel(1);
}

Future<void> cancelWalkNotification() async {
  await notificationsPlugin.cancel(2);
}

Future<void> cancelbathNotification() async {
  await notificationsPlugin.cancel(3);
}

Future<void> cancelNotificationReminder() async {
  await notificationsPlugin.cancel(4);
}

Future<void> onSelectNotification(String payload) async {
  NoteObserver noteObserver = NoteObserver();
  print("$payload");
  if (payload == 'Note load') {
    noteObserver.changeScreen(NOTE_SCREENS.NOTE);
  }
}

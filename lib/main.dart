import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:memorez/Observables/CalenderObservable.dart';
import 'package:memorez/Observables/CheckListObservable.dart';
import 'package:memorez/Observables/HelpObservable.dart';
import 'package:memorez/Observables/MicObservable.dart';
import 'package:memorez/Observables/OnboardObservable.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:memorez/Screens/Main.dart';
import 'package:memorez/utils/user_preferences.dart';
import 'Screens/Splash/SplashScreen.dart';
import 'Utility/FontUtil.dart';
import 'Utility/ThemeUtil.dart';
import 'generated/i18n.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Observables/MenuObservable.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Observables/NoteObservable.dart';
import 'package:memorez/Observables/ScreenNavigator.dart';
import 'package:memorez/Observables/NotificationObservable.dart';
import 'package:memorez/Observables/TaskObservable.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: Color(0XFF9050DD),
            ledColor: Colors.white,
            playSound: true,
            enableLights:true,
            enableVibration: true
        )
      ]
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    I18n.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
    });
  }

  SettingObserver settingObserver = SettingObserver();

  @override
  Widget build(BuildContext context) {
    String defaultLocale = Platform.localeName;
    print('KKKKKKKKKKKKKKKK $defaultLocale');
    final i18n = I18n.delegate;
    BottomNavigationBarThemeData bottomNavigationBarThemeData =
        BottomNavigationBarThemeData(
            backgroundColor:
                themeToColor(settingObserver.userSettings.appTheme));

    return Observer(
        builder: (_) => MultiProvider(
                providers: [
                  Provider<MainNavigator>(create: (_) => MainNavigator()),
                  Provider<NotificationObserver>(
                      create: (_) => NotificationObserver()),
                  Provider<OnboardObserver>(create: (_) => OnboardObserver()),
                  Provider<MenuObserver>(create: (_) => MenuObserver()),
                  Provider<NoteObserver>(create: (_) => NoteObserver()),
                  Provider<MainNavObserver>(create: (_) => MainNavObserver()),
                  Provider<SettingObserver>(create: (_) => settingObserver),
                  Provider<MicObserver>(create: (_) => MicObserver()),
                  Provider<CalendarObservable>(
                      create: (_) => CalendarObservable()),
                  Provider<CheckListObserver>(
                      create: (_) => CheckListObserver()),
                  Provider<HelpObserver>(create: (_) => HelpObserver()),
                  Provider<TaskObserver>(create: (_) => TaskObserver())
                ],
                child: (MaterialApp(
                  debugShowCheckedModeBanner: false,
                  //to load original main screen set home to SplashScreen.dart()
                  home: SplashScreen(),
                  localizationsDelegates: [
                    i18n,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  theme: ThemeData(
                    appBarTheme: AppBarTheme(
                      backgroundColor:
                          themeToColor(settingObserver.userSettings.appTheme),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        primary:
                            themeToColor(settingObserver.userSettings.appTheme),
                      ),
                    ),
                    bottomNavigationBarTheme: bottomNavigationBarThemeData,
                    textTheme: TextTheme(
                      headline1: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      bodyText1: TextStyle(
                          fontSize: fontSizeToPixelMap(
                              settingObserver.userSettings.menuFontSize,
                              false)),
                      bodyText2: TextStyle(
                          fontSize: fontSizeToPixelMap(
                              settingObserver.userSettings.menuFontSize, true)),
                    ),
                  ),
                  supportedLocales: i18n.supportedLocales,
                  localeResolutionCallback: i18n.resolution(
                      fallback: settingObserver.userSettings.locale),
                ))));
  }
}

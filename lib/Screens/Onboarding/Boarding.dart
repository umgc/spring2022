import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/OnboardObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Home.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Screens/Onboarding/CloudSetup.dart';
import 'package:untitled3/Screens/Onboarding/Permission.dart';
import 'package:untitled3/Screens/Onboarding/SelectLanguage.dart';
import 'package:untitled3/Screens/Onboarding/Walkthrough.dart';

import 'package:untitled3/generated/i18n.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  _OnBoardingScreenState();

  OnboardObserver onboardObserver = OnboardObserver();
  Setting onbaordSetting = Setting();

  //count of boardingScreens
  static const int NUM_OF_ONBOARDING_SCREEN = 3;

  String _screenName(index) {
    List<String> boardingScreens = [
      I18n.of(context)!.onboardLangSetup,
      I18n.of(context)!.onboardPermissionSetup,
      //I18n.of(context)!.onboardCloudSetup,
      I18n.of(context)!.walkthroughScreen,
      I18n.of(context)!.homeScreenName,
    ];

    if (index > boardingScreens.length - 1) return "";

    return boardingScreens[index];
  }

  Widget _changeScreen(index) {
  
    switch (index) {
      case 0:
        return SelectLanguageScreen();
      case 1:
        return PermissionScreen();
      case 2:
        return CloudSetupScreen();
      default:
        return WalkthroughScreen();
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 90,
      title: Observer(
          builder: (_) => Text(
                '${_screenName(onboardObserver.currentScreenIndex)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              )),
      backgroundColor: Color(0xFF33ACE3),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Scaffold(
              appBar: buildAppBar(context),
              body: Center(
                  child: _changeScreen(onboardObserver.currentScreenIndex)),
              persistentFooterButtons: [
                (onboardObserver.currentScreenIndex < NUM_OF_ONBOARDING_SCREEN)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            ElevatedButton(
                              child: Text(I18n.of(context)!.back.toUpperCase()),
                              onPressed: () =>
                                  {onboardObserver.moveToPrevScreen()},
                            ),
                            ElevatedButton(
                              child: Text(I18n.of(context)!.next.toUpperCase()),
                              onPressed: () {
                                  if(onboardObserver.currentScreenIndex < 2){
                                    onboardObserver.moveToNextScreen();
                                  }else{
                                    Navigator.pushReplacement<void, void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => WalkthroughScreen(),
                                      ));
                                  }
                                },
                            ),
                          ])
                    : Text("")
              ],
            ));
  }
}

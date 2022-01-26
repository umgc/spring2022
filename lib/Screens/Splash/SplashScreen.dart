// Original idea from:
// https://mamuseferha.medium.com/how-to-use-lottie-animation-in-your-flutter-splash-screen-788f1380641d
// Mamus Eferha, May 26, Medium.com "How to use Lottie animation in your flutter splash"
// Adapted for UMGC SWEN Capstone Project Fall 2021
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Onboarding/Boarding.dart';
import '../Main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (5)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingObserver = Provider.of<SettingObserver>(context);

    return Scaffold(
      body: Lottie.asset(
        'assets/lottie/animation.json',
        controller: _controller,
        height: MediaQuery.of(context).size.height * 1,
        animate: true,
        frameRate: FrameRate(60.0),
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward().whenComplete(() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Observer(
                          builder: (_) =>
                              (settingObserver.userSettings.isFirstRun == false)
                                  ? MainNavigator()
                                  : (OnBoardingScreen()))),
                ));
        },
      ),
    );
  }
}

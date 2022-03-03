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
import 'package:untitled3/Screens/Main.dart';

import 'LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;


  @override
  Widget build(BuildContext context) {
    final settingObserver = Provider.of<SettingObserver>(context);

    return
      Scaffold(
        backgroundColor: Colors.white,
        body: Center(

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Text('MemorEZ', style: TextStyle(color: Color(0xFF0D47A1), fontSize: 40, fontWeight: FontWeight.w900)),
                SizedBox(height: 20.0),
                Text('Spend less time remembering and more time doing', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                SizedBox(height: 60.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                                color: Color(0xFF0D47A1),
                            // gradient: LinearGradient(
                            //   colors: <Color>[
                            //     Color(0xFF0D47A1),
                            //     Color(0xFF1976D2),
                            //     Color(0xFF42A5F5),
                            //   ],
                            // ),
                          ),
                        ),
                      ),

                      TextButton.icon(
                        icon: const Icon(Icons.person),
                        label: const Text(' PATIENT '),
                        style: TextButton.styleFrom(
                          padding : const EdgeInsets.only(left: 90, right: 90.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return MainNavigator();
                            }),
                          );
                        },
                      )
                      // TextButton(
                      //   style: TextButton.styleFrom(
                      //     padding: const EdgeInsets.all(16.0),
                      //     primary: Colors.white,
                      //     textStyle: const TextStyle(fontSize: 20),
                      //   ),
                      //   onPressed: () {
                      //     Navigator.push(context,
                      //       MaterialPageRoute(builder: (context){
                      //         return LoginForm();
                      //       }),
                      //     );
                      //   },
                      //   child: const Text('  Admin Mode  '),
                      // ),


                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(

                          decoration: const BoxDecoration(

                            color: Color(0xFF0D47A1),
                            // gradient: LinearGradient(
                            //   colors: <Color>[
                            //     Color(0xFF0D47A1),
                            //     Color(0xFF1976D2),
                            //     Color(0xFF42A5F5),
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                      TextButton.icon(

                        icon: const Icon(Icons.medical_services),
                        label: const Text('CAREGIVER'),
                          style: TextButton.styleFrom(
                            padding : const EdgeInsets.only(left: 80, right: 80.0),
                            // padding: const EdgeInsets.all(15.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return LoginForm();
                              }),
                            );
                          },
                      ),

                      // TextButton(
                      //
                      //   style: TextButton.styleFrom(
                      //     padding: const EdgeInsets.all(16.0),
                      //     primary: Colors.white,
                      //     textStyle: const TextStyle(fontSize: 20),
                      //   ),
                      //   onPressed: () {
                      //     Navigator.push(context,
                      //       MaterialPageRoute(builder: (context){
                      //         return MainNavigator();
                      //       }),
                      //     );
                      //   },
                      //   child: const Text('Normal Access'),
                      // ),


                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                Image.asset(
                  "assets/images/caregiver_patient_image.png",
                  height: 400.0,
                  width: 400.0,
                ),

              ],
            ),
          ),
        ),

      );

        Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Observer(
                  builder: (_) =>
                  (settingObserver.userSettings.isFirstRun == false)
                      ? MainNavigator()
                      : (OnBoardingScreen()),
                ),
              ),
            );

  }
}

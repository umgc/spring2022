import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);
    final noteObserver = Provider.of<NoteObserver>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Text(I18n.of(context)!.speakOrWritePrompt,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  )),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 70),
                height: 301,
                width: 174,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      onPrimary: Colors.white,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      minimumSize: Size(40, 40)),
                  onPressed: () {
                    screenNav.changeScreen(MAIN_SCREENS.HOME);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainNavigator()),
                    );
                  },
                  child: Column(children: [
                    Padding(
                      padding: new EdgeInsets.all(40.0),
                    ),
                    Image(
                      image: AssetImage("assets/images/mic.png"),
                      color: Colors.white,
                      height: 129.89,
                      width: 100.82,
                    ),
                    Text('Speak',
                        style: TextStyle(fontSize: 25, color: Colors.black))
                  ]),
                ),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 0, right: 20.0, top: 70),
                height: 301,
                width: 174,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      onPrimary: Colors.white,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      minimumSize: Size(10, 10)),
                  onPressed: () {
                    screenNav.changeScreen(MAIN_SCREENS.NOTE);
                    noteObserver.changeScreen(NOTE_SCREENS.ADD_NOTE);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainNavigator()),
                    );
                  },
                  child: Column(children: [
                    Padding(
                      padding: new EdgeInsets.all(20.0),
                    ),
                    Image(
                      image: AssetImage("assets/images/Note.png"),
                      color: Colors.white,
                      height: 170,
                      width: 155,
                    ),
                    Text('Text',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ))
                  ]),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}

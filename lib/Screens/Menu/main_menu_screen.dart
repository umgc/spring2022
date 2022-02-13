import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled3/Screens/Components/bottom_buttons.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreen createState() => _MainMenuScreen();
}

class _MainMenuScreen extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemorEZ'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
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
                            'TASKS',
                          ),
                        ],
                      ),
                      onPressed: () {},
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
                    padding: const EdgeInsets.all(5.0),
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
                            'NOTES',
                          ),
                        ],
                      ),
                      onPressed: () {},
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
                    padding: const EdgeInsets.all(5.0),
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
                            'CALENDAR',
                          ),
                        ],
                      ),
                      onPressed: () {},
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
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.redAccent[100],
                        textStyle: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.userAlt),
                          SizedBox(width: 15.0),
                          Text(
                            'PROFILE',
                          ),
                        ],
                      ),
                      onPressed: () {},
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
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purpleAccent,
                        textStyle: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.cog),
                          SizedBox(width: 15.0),
                          Text(
                            'SETTINGS',
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BottomButtons(),
          )
        ],
      ),
    );
  }
}

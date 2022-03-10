import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Help.dart';
import 'package:untitled3/Observables/HelpObservable.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Screens/Components/VideoPlayer.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

import '../../Observables/SettingObservable.dart';

class Help extends StatefulWidget {
  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {

    final helpObserver = Provider.of<HelpObserver>(context);
    final MenuObserver menuObserver = Provider.of<MenuObserver>(context);
    final MainNavObserver navObserver = Provider.of<MainNavObserver>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child:
          HelpTable(helpObserver.helpItems, () => {"Displayed Help Content"}),

      // floatingActionButtonLocation:
      //         FloatingActionButtonLocation.startFloat,
      // floatingActionButton: FloatingActionButton(
      //         onPressed: () {
      //           menuObserver.changeScreen(MENU_SCREENS.MENU);
      //         },
      //         tooltip: I18n.of(context)!.back,
      //         child: Icon(Icons.arrow_back),
      //       )
    ));

  }
}

Divider addTopDivider() {
  return Divider(
    thickness: 2.0,
    indent: 5,
    endIndent: 5,
  );
}

Divider addBotDivider() {
  return Divider(
    thickness: 2.0,
    indent: 5,
    height: 20,
    endIndent: 5,
  );
}

///Method to remove the "TASKS:" (or other section) in each topic
String removeTitle(String s) {
  int i = s.indexOf(':') + 2;

  //return s;
  return s.substring(i, s.length).trim();
}

/// View Notes page
class HelpTable extends StatelessWidget {
  final List<HelpContent> helpItems;
  final Function? onListItemClickCallBackFn;
  //Flutter will autto assign this param to usersNotes
  HelpTable(this.helpItems, this.onListItemClickCallBackFn);
  static const ICON_SIZE = 40.00;
  @override
  Widget build(BuildContext context) {

    ///Font size for section headers
    double _sectionFontSize =
        (Theme.of(context).textTheme.bodyText1?.fontSize)! * 1.2;

    ///Font size for page title
    double _titleFontSize =
        (Theme.of(context).textTheme.bodyText1?.fontSize)! * 1.4;

    ///Font size for text on each topic button
    double? _buttonFontSize =
        Theme.of(context).textTheme.bodyText1?.fontSize;

    //noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
//----------------------------------TASKS
        SizedBox(height: 10.00),
        Text(
          '                  ' + I18n.of(context)!.helpTopics,
          style: TextStyle(
            //fontSize: getSize2(),
            fontSize: _titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),

        /// Task section header
        Text(
          '  ' + I18n.of(context)!.tasks.toUpperCase(),
          style: TextStyle(
            fontSize: _sectionFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            return Column(children: [
              if (helpItems[index].title.contains('TASK')) ...[
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        // child: Column(children: [
                        // Container(height: 10.0),

                        ListTile(
                            //textColor: Colors.white,
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => (VideoPlayerScreen(
                                            title: helpItems[index].title,
                                            videoUrl:
                                                "assets/help/example_help.mp4")
                                        )
                                    ),
                                  )
                                },
                            title: Text(
                                removeTitle('${helpItems[index].title}'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _buttonFontSize,
                                ),
                                //style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start),
                            //tileColor: Colors.lightBlue[900],
                            textColor: Colors.white,
                            trailing: Icon(
                              Icons.play_arrow,
                              size: ICON_SIZE,
                              color: Colors.white,
                            )),
                      ]),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                      //  border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.blue),
                ),
              ],
            ]);
          },
        ),

        addTopDivider(),
        addBotDivider(),

        /// Notes section
        Text(
          '  ' + I18n.of(context)!.notesScreenName.toUpperCase(),
          style: TextStyle(
            fontSize: _sectionFontSize,
              fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            return Column(children: [
              if (helpItems[index].title.contains('NOTES')) ...[
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        // child: Column(children: [
                        // Container(height: 10.0),

                        ListTile(
                            //textColor: Colors.white,
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => (VideoPlayerScreen(
                                            title: helpItems[index].title,
                                            videoUrl:
                                                "assets/help/example_help.mp4"))),
                                  )
                                },
                            title: Text(
                                removeTitle('${helpItems[index].title}'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _buttonFontSize),
                                //style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start),
                            //tileColor: Colors.lightBlue[900],
                            textColor: Colors.white,
                            trailing: Icon(
                              Icons.play_arrow,
                              size: ICON_SIZE,
                              color: Colors.white,
                            )),
                      ]),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                      //  border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.blue),
                ),
              ],
            ]);
          },
        ),

        addTopDivider(),
        addBotDivider(),

        /// Calendar section
        Text(
          '  ' + I18n.of(context)!.calendarScreenName.toUpperCase(),
          style: TextStyle(
            fontSize: _sectionFontSize,
              fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            return Column(children: [
              if (helpItems[index].title.contains('CALENDAR')) ...[
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                            //textColor: Colors.white,
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => (VideoPlayerScreen(
                                            title: helpItems[index].title,
                                            videoUrl:
                                                "assets/help/example_help.mp4"))),
                                  )
                                },
                            title: Text(
                                removeTitle('${helpItems[index].title}'),
                                style: TextStyle(
                                    color: Colors.white, fontSize: _buttonFontSize),
                                //style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start),
                            //tileColor: Colors.lightBlue[900],
                            textColor: Colors.white,
                            trailing: Icon(
                              Icons.play_arrow,
                              size: ICON_SIZE,
                              color: Colors.white,
                            )),
                      ]),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                      //  border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.blue),
                ),
              ],
            ]);
          },
        ),

        addTopDivider(),
        addBotDivider(),

        /// Profile section
        Text(
          '  ' + I18n.of(context)!.profile.toUpperCase(),
          style: TextStyle(
            fontSize: _sectionFontSize,
              fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            return Column(children: [
              if (helpItems[index].title.contains('PROFILE')) ...[
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        // child: Column(children: [
                        // Container(height: 10.0),

                        ListTile(
                            //textColor: Colors.white,
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => (VideoPlayerScreen(
                                            title: helpItems[index].title,
                                            videoUrl:
                                                "assets/help/example_help.mp4"))),
                                  )
                                },
                            title: Text(
                                removeTitle('${helpItems[index].title}'),
                                style: TextStyle(
                                    color: Colors.white, fontSize: _buttonFontSize),
                                //style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start),
                            //tileColor: Colors.lightBlue[900],
                            textColor: Colors.white,
                            trailing: Icon(
                              Icons.play_arrow,
                              size: ICON_SIZE,
                              color: Colors.white,
                            )),
                      ]),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                      //  border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.blue),
                ),
              ],
            ]);
          },
        ),
        addTopDivider(),
        addBotDivider(),

        /// Settings section
        Text(
          '  ' + I18n.of(context)!.generalSetting.toUpperCase(),
          style: TextStyle(
            fontSize: _sectionFontSize,
              fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            return Column(children: [
              if (helpItems[index].title.contains('SETTINGS')) ...[
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        // child: Column(children: [
                        // Container(height: 10.0),

                        ListTile(
                            //textColor: Colors.white,
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => (VideoPlayerScreen(
                                            title: helpItems[index].title,
                                            videoUrl:
                                                "assets/help/example_help.mp4"))),
                                  )
                                },
                            title: Text(
                                removeTitle('${helpItems[index].title}'),
                                style: TextStyle(
                                    color: Colors.white, fontSize: _buttonFontSize),
                                //style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start),
                            //tileColor: Colors.lightBlue[900],
                            textColor: Colors.white,
                            trailing: Icon(
                              Icons.play_arrow,
                              size: ICON_SIZE,
                              color: Colors.white,
                            )),
                      ]),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                      //  border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.blue),
                ),
              ],
            ]);
          },
        ),

        addTopDivider(),
        addBotDivider(),

        /// Chat section
        Text(
          '  ' + I18n.of(context)!.chat.toUpperCase(),
          style: TextStyle(
            fontSize: _sectionFontSize,
              fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            return Column(children: [
              if (helpItems[index].title.contains('CHAT')) ...[
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        // child: Column(children: [
                        // Container(height: 10.0),

                        ListTile(
                            //textColor: Colors.white,
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => (VideoPlayerScreen(
                                            title: helpItems[index].title,
                                            videoUrl:
                                                "assets/help/example_help.mp4"))),
                                  )
                                },
                            title: Text(
                                removeTitle('${helpItems[index].title}'),
                                style: TextStyle(
                                    color: Colors.white, fontSize: _buttonFontSize),
                                //style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start),
                            //tileColor: Colors.lightBlue[900],
                            textColor: Colors.white,
                            trailing: Icon(
                              Icons.play_arrow,
                              size: ICON_SIZE,
                              color: Colors.white,
                            )),
                      ]),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                      //  border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.blue),
                ),
              ],
            ]);
          },
        ),
      ],
    );
    //noteObserver.changeScreen(NOTE_SCREENS.NOTE);
  }
}

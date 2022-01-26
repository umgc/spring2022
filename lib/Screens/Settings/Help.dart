import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Help.dart';
import 'package:untitled3/Observables/HelpObservable.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Screens/Components/VideoPlayer.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

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
        resizeToAvoidBottomInset: false,
        body:HelpTable(helpObserver.helpItems, () => {"Displayed Help Content"}),
        floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
                onPressed: () {
                  menuObserver.changeScreen(MENU_SCREENS.MENU);
                },
                tooltip: I18n.of(context)!.back,
                child: Icon(Icons.arrow_back),
              )
        );
  }
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
    
    //noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    return ListView.builder(
       shrinkWrap: true,
      itemCount: helpItems.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            onTap: () => {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => (VideoPlayerScreen(title: helpItems[index].title, 
                      videoUrl: "assets/help/example_help.mp4"))),
                    )
            },
            title: Text(
                '${helpItems[index].title}',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center),
            trailing: 
            Icon( 
              Icons.play_arrow,
              size: ICON_SIZE,
            )
          ),
        );
      },
    );
  }
}

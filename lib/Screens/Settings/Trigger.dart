import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Components/CancelButton.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import 'dart:math' as math;

class Trigger extends StatefulWidget {
  @override
  TriggerState createState() => TriggerState();
}

class TriggerState extends State<Trigger> {
  @override
  Widget build(BuildContext context) {
    const ICON_SIZE = 80.00;
    return Scaffold(
        body: Center(
      child: ListView(
        padding: EdgeInsets.only(left: 12, top: 0, right: 12, bottom: 0),
        children: [
          buildText('To start recording:'),
          Container(
            child: Text('Can you say that again?'),
            padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(1),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                )),
          ),
          buildText('To end recording:'),
          Container(
            child: Text('Got'),
            padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(1),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                )),
          ),
          buildText('Playback notes:'),
          Container(
            child: Text('Talking about'),
            padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(1),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    final screenNav =
                        Provider.of<MenuObserver>(context, listen: false);
                    screenNav.changeScreen(MENU_SCREENS.MENU);
                  },
                  child: Column(
                    children: [
                      Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child: Icon(
                            Icons.exit_to_app_rounded,
                            size: ICON_SIZE,
                            color: Colors.amber,
                          )),
                      Text(
                        I18n.of(context)!.cancel,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  )),
              //SAVE BUTTON
              GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Icon(
                        Icons.save,
                        size: ICON_SIZE,
                        color: Colors.green,
                      ),
                      Text(
                        I18n.of(context)!.save,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    ));
  }

  Widget buildText(String text) => Container(
        margin: EdgeInsets.fromLTRB(0, 24, 0, 8),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      );
}

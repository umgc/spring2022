import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/Screens/Profile/profile_constants.dart';

class CareTeamCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
        child:
        SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Care Team', style: kSectionTitleTextStyle
                      ),
                      //SIZED BOX FOR SPACING
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Provider 1', style: kActiveTextChoiceStyle),
                      Text('Provider 2', style: kInactiveTextChoiceStyle),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                   CircleAvatar(
                     backgroundColor: Colors.blueGrey,
                     radius: 30.0,
                     child: Text (
                       'Image'),
                     ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text (
                        'Name', style: kSubText
                    ),
                    Text (
                        'Phone', style: kSubText
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}


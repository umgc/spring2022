import 'package:flutter/material.dart';
import 'package:untitled3/Screens/Profile/profile_constants.dart';


class ProfileCard extends StatelessWidget {

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
                      Text('About Me', style: kSectionTitleTextStyle
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Name', style: kLabelTextStyle),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Date of Birth', style: kLabelTextStyle),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Phone Number', style: kLabelTextStyle),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                alignment: Alignment.centerRight,
                child:    CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30.0,
                  child: Text (
                      'Image'),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

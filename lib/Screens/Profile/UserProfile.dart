import 'package:flutter/material.dart';
import 'package:untitled3/Screens/Profile/care_team_card.dart';
import 'package:untitled3/Screens/Profile/contact_card.dart';
import 'package:untitled3/Screens/Profile/profile_card.dart';
import 'package:untitled3/Screens/Profile/profile_constants.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: ProfileCard()),
          //SECTION LINE DIVIDER
          SizedBox(
            child: Divider(color: Colors.blueGrey),
          ),
          Expanded(child: ContactCard()),
          //SECTION LINE DIVIDER
          SizedBox(
            child: Divider(color: Colors.blueGrey),
          ),
          Expanded(child: CareTeamCard()),
          //SECTION LINE DIVIDER
          SizedBox(
            child: Divider(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/DatabaseHandler/DbHelper.dart';
import 'package:untitled3/Model/UserModel.dart';
import 'package:untitled3/Model/user.dart';
import 'package:untitled3/Screens/Profile/profile_constants.dart';
import 'package:untitled3/Screens/Profile/widget/profile_widget.dart';
import 'package:untitled3/utils/user_preferences.dart';

import '../Main.dart';
import 'edit_profile_page.dart';

class ContactCard extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<ContactCard> {
  final _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  var _conUserId = TextEditingController();

  UserModel? get userData => null;

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text = sp.getString("user_id")!;
    });
  }

  void removeSP(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return Builder(builder: (context) => buildContactCard(user));
  }

  Widget buildContactCard(User user) => Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Contacts', style: kSectionTitleTextStyle),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Contact 1', style: kLabelTextStyle),
                  Text(user.cont1),
                  Text(user.cont1ph),
                  const SizedBox(height: 24),
                  Text('Contact 2', style: kLabelTextStyle),
                  Text(user.cont2),
                  Text(user.cont2ph),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            alignment: Alignment.centerRight,
            child: ProfileWidget(
              imagePath: user.imagePath2,
              onClicked: () {
                _conUserId.text == 'Admin'
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EditProfilePage()))
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MainNavigator()));
              },
            ),
          ),
        ],
      );
}

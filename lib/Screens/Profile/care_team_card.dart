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

class CareTeamCard extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<CareTeamCard> {
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

    return Builder(builder: (context) => buildCareTeamCard(user));
  }

  Widget buildCareTeamCard(User user) => Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Care Team', style: kSectionTitleTextStyle),
                  //SIZED BOX FOR SPACING
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Provider 1', style: kLabelTextStyle),
                  Text(user.prov1),
                  Text(user.prov1ph),
                  const SizedBox(height: 24),
                  Text('Provider 2', style: kLabelTextStyle),
                  Text(user.prov2),
                  Text(user.prov2ph),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(30.0),
                alignment: Alignment.centerRight,
                child: ProfileWidget(
                  imagePath: user.imagePath3,
                  onClicked: () {
                    _conUserId.text == 'Admin'
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditProfilePage()))
                        : Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MainNavigator()));
                  },
                ),
              ),
            ],
          ),
        ],
      );
}

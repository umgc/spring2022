import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Model/user.dart';
import 'package:untitled3/Screens/AdminPage.dart';
import 'package:untitled3/Screens/HomePage.dart';
import 'package:untitled3/Screens/LoginPage.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Screens/Profile/edit_profile_page.dart';
import 'package:untitled3/Screens/Profile/profile_card.dart';
import 'package:untitled3/Screens/Profile/profile_constants.dart';
import 'package:untitled3/Screens/Profile/widget/button_widget.dart';
import 'package:untitled3/utils/user_preferences.dart';
import 'package:untitled3/Screens/Profile/widget/profile_widget.dart';
import 'package:untitled3/DatabaseHandler/DbHelper.dart';
import 'package:untitled3/Model/UserModel.dart';

import '../../Model/UserModel.dart';
import '../../Observables/ScreenNavigator.dart';
import '../../Utility/Constant.dart';
import 'care_team_card.dart';
import 'contact_card.dart';

class UserProfile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfile> {
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
    final screenNav = Provider.of<MainNavObserver>(context);
    final user = UserPreferences.getUser();

    return Builder(
      builder: (context) => Scaffold(
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileCard(),
            const SizedBox(child: Divider(color: Colors.blueGrey)),
            ContactCard(),
            const SizedBox(child: Divider(color: Colors.blueGrey)),
            CareTeamCard(),
            const SizedBox(height: 24),
            //If admin, show edit, else stay the same
            _conUserId.text == 'Admin'
                ? Container(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: ButtonWidget(
                      text: 'Edit',
                      onClicked: () {
                        screenNav
                            .changeScreen(PROFILE_SCREENS.UPDATE_USERPROFILE);
                      },
                    ),
                  )
                : Text(''),

            const SizedBox(height: 24),

            //If admin, show edit, else stay the same
            _conUserId.text == 'Admin'
                ? Container(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    child: ButtonWidget(
                      text: 'Logout',
                      onClicked: () {
                        removeSP("Admin");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => MainNavigator()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}

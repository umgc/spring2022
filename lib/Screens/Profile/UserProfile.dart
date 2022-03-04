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
import 'package:untitled3/Screens/Profile/profile_constants.dart';
import 'package:untitled3/Screens/Profile/widget/button_widget.dart';
import 'package:untitled3/utils/user_preferences.dart';
import 'package:untitled3/Screens/Profile/widget/profile_widget.dart';
import 'package:untitled3/DatabaseHandler/DbHelper.dart';
import 'package:untitled3/Model/UserModel.dart';

import '../../Model/UserModel.dart';
import '../../Observables/ScreenNavigator.dart';
import '../../Utility/Constant.dart';

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
            buildProfileCard(user),
            const SizedBox(child: Divider(color: Colors.blueGrey)),
            buildContactCard(user),
            const SizedBox(child: Divider(color: Colors.blueGrey)),
            buildCareTeamCard(user),
            const SizedBox(height: 24),
            //If admin, show edit, else stay the same
            _conUserId.text == 'Admin'
                ? Container(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: ButtonWidget(
                      text: 'Edit',
                      onClicked: () {
                        screenNav.changeScreen(PROFILE_SCREENS.UPDATE_USERPROFILE);
                      },
                    ),
                  )
                : Text(''),

            const SizedBox(height: 24),

            //If admin, show edit, else stay the same
            _conUserId.text == 'Admin'
                ? Container(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
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

  Widget buildProfileCard(User user) => Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('About Me', style: kSectionTitleTextStyle),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Name:', style: kLabelTextStyle),
                  Text(user.name),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Date of Birth', style: kLabelTextStyle),
                  Text(user.bday),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Phone Number', style: kLabelTextStyle),
                  Text(user.phone),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            alignment: Alignment.centerRight,
            child: ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () {
                _conUserId.text == 'Admin'
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EditProfilePage()))
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MainNavigator()));
                setState(() {});
              },
            ),
          ),
        ],
      );

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

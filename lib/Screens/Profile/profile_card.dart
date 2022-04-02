import 'package:flutter/material.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Model/user.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
import 'package:memorez/utils/user_preferences.dart';
import '../../Observables/ScreenNavigator.dart';


class ProfileCard extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<ProfileCard> {
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
    final screenNav = Provider.of<MainNavObserver>(context);
    return Builder(builder: (context) => buildProfileCard(user));
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
                  Text(I18n.of(context)!.aboutMe, style: kSectionTitleTextStyle),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(I18n.of(context)!.name, style: kLabelTextStyle),
                  Text(user.name),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(I18n.of(context)!.dateOfBirth, style: kLabelTextStyle),
                  Text(EncryptUtil.decryptNote(user.bday)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(I18n.of(context)!.phoneNumber, style: kLabelTextStyle),
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
                setState(() {});
              },
            ),
          ),
        ],
      );
}

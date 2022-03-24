import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:memorez/Screens/Settings/Setting.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Comm/comHelper.dart';
import 'package:memorez/Comm/genLoginSignupHeader.dart';
import 'package:memorez/Comm/genTextFormField.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/AdminPage.dart';
import 'package:memorez/Screens/CreateAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import 'package:memorez/Screens/UpdateAdmin.dart';

import '../Observables/ScreenNavigator.dart';
import '../Observables/SettingObservable.dart';
import '../Utility/Constant.dart';
import '../generated/i18n.dart';
import '../main.dart';
import 'Main.dart';
import 'package:telephony/telephony.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _conUserPhone = TextEditingController();
  final _truePassword = TextEditingController();
  final _conPassword = TextEditingController();

  String secondaryAction = '';
  String secondaryActionLink = '';
  final Telephony telephony = Telephony.instance;
  ValueNotifier<bool> _conUserIdUpdated = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  void resetPassword() {
    telephony.sendSms(to: _conUserPhone.text, message: "Hello World!");
  }

  void createCareGiver() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupForm()));
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    try {
      _conUserId.text = await sp.getString("user_id")!;
      _truePassword.text = await sp.getString("password")!;
      _conUserPhone.text = await sp.getString("phone")!;
    } catch (e) {
      print('CareGiver has been is Missing or has been Deleted!');
      _conUserId.text = "No_CareGiver";
    } finally {
      _conUserIdUpdated.value = !_conUserIdUpdated.value;
      _conUserId.text == 'No_CareGiver'
          ? secondaryAction = 'Need to create an account?'
          : secondaryAction = 'Need to reset your password?';
      _conUserId.text == 'No_CareGiver'
          ? secondaryActionLink = 'Create Caregiver'
          : secondaryActionLink = 'reset password?';
    }
  }

  setScreen() {
    final screenNav = Provider.of<MainNavObserver>(context, listen: false);

    screenNav.changeScreen(MENU_SCREENS.SETTING);
  }

  _login() async {
    String uid = 'Admin';
    String passwd = _conPassword.text;
    uid = EncryptUtil.encryptNote(uid);
    passwd = EncryptUtil.encryptNote(passwd);

    if (uid.isEmpty) {
      alertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        setSP(userData!).whenComplete(
          () {
            userData != null
                ? Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyApp()))
                : alertDialog(context, "Error: Please try again");
          },
        );
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    String uid = EncryptUtil.decryptNote(user.user_id);
    String phone = user.phone.toString();
    String password = EncryptUtil.decryptNote(user.password);
    sp.setString("user_id", uid);
    sp.setString("phone", phone);
    sp.setString("password", user.password);
    print('ARE WEEEEE DECRYPTING? =======> uid: ${uid}  password: ${password}');
  }

  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context, listen: false);

    final settingObserver = Provider.of<SettingObserver>(context);
    final supportedLocales = GeneratedLocalizationsDelegate().supportedLocales;

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          foregroundColor: Color(0xFF0D47A1),
          leading: BackButton(
            onPressed: () {
              setState(() {
                screenNav.changeScreen(MENU_SCREENS.SETTING);
                Navigator.pop(context);
              });
              //
              // Navigator.push(context, MaterialPageRoute(builder: (_)=>
              //     Settings()));
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.00,
                  ),
                  genLoginSignupHeader('Caregiver Login'),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _login),
                    decoration: BoxDecoration(
                      color: Color(0xFF0D47A1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _conUserIdUpdated,
                        builder: (context, value, _) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(secondaryAction),
                              ],
                            ),
                            Row(
                              children: [
                                FlatButton(
                                  textColor: Color(0xFF0D47A1),
                                  child: Text(secondaryActionLink),
                                  onPressed: () {
                                    _conUserId.text=='No_CareGiver'
                                        ? createCareGiver()
                                        : resetPassword();
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

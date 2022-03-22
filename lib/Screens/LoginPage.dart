import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:memorez/Screens/Settings/Setting.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Comm/comHelper.dart';
import 'package:memorez/Comm/genLoginSignupHeader.dart';
import 'package:memorez/Comm/genTextFormField.dart';
import 'package:memorez/DatabaseHandler/DbHelper.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/AdminPage.dart';
import 'package:memorez/Screens/CreateAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:memorez/Screens/UpdateAdmin.dart';

import '../Observables/ScreenNavigator.dart';
import '../Observables/SettingObservable.dart';
import '../Utility/Constant.dart';
import '../generated/i18n.dart';
import '../main.dart';
import 'Main.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _truePassword = TextEditingController();
  final _conPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();


  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _truePassword.text = sp.getString("password")!;
    });
  }

 setScreen(){
    final screenNav = Provider.of<MainNavObserver>(context, listen: false);

      screenNav.changeScreen(MENU_SCREENS.SETTING);


  }
  _login() async {

    String uid = 'Admin';
    String passwd = _conPassword.text;

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

    sp.setString("user_id", user.user_id);
    sp.setString("phone", user.phone);
    sp.setString("password", user.password);
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
              onPressed: (){

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Need to create an account?'),
                        FlatButton(
                          textColor: Color(0xFF0D47A1),
                          child: Text('Create Caregiver'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupForm()));
                          },
                        )
                      ],
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

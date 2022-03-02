import 'package:flutter/material.dart';
import 'package:untitled3/Comm/comHelper.dart';
import 'package:untitled3/Comm/genLoginSignupHeader.dart';
import 'package:untitled3/Comm/genTextFormField.dart';
import 'package:untitled3/DatabaseHandler/DbHelper.dart';
import 'package:untitled3/Model/UserModel.dart';
import 'package:untitled3/Screens/AdminPage.dart';
import 'package:untitled3/Screens/CreateAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:untitled3/Screens/UpdateAdmin.dart';

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

  login() async {
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
                context, MaterialPageRoute(builder: (_) => HomeForm2()))
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

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.00,),
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
                    onPressed: login,
                  ),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupForm()));
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
  }
}

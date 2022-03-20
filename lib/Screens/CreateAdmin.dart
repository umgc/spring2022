import 'package:flutter/material.dart';
import 'package:memorez/Comm/comHelper.dart';
import 'package:memorez/Comm/genLoginSignupHeader.dart';
import 'package:memorez/Comm/genTextFormField.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/HomePage.dart';
import 'package:memorez/Screens/LoginPage.dart';

import '../DatabaseHandler/database_helper_profile.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPhone = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = 'Admin';
    String phone = _conPhone.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Password Mismatch');
      } else {
        _formKey.currentState?.save();

        UserModel uModel = UserModel(uid, phone, passwd);
        print('XXXXXXXXXXX ${uModel.phone}');
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Saved");

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
                  (Route<dynamic> route) => true);


        }).catchError((error) {
          print('YYYYYYYYY $error');

          alertDialog(context, "Error: Admin already exist, pls log in");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Setup Caregiver'),
                  // getTextFormField(
                  //     controller: _conUserId,
                  //     icon: Icons.person,
                  //     hintName: 'User ID'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conPhone,
                      icon: Icons.phone,
                      inputType: TextInputType.phone,
                      hintName: 'Phone Number'),
                  // SizedBox(height: 10.0),
                  // getTextFormField(
                  //     controller: _conEmail,
                  //     icon: Icons.email,
                  //     inputType: TextInputType.emailAddress,
                  //     hintName: 'Email'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: signUp,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF0D47A1),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '),
                        FlatButton(
                          textColor: Color(0xFF0D47A1),
                          child: Text('Sign In'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                    (Route<dynamic> route) => true);
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
      ),
    );
  }
}

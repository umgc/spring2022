import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:memorez/Comm/comHelper.dart';
import 'package:memorez/Comm/genTextFormField.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/HomePage.dart';
import 'package:memorez/Screens/LoginPage.dart';
import 'package:memorez/Screens/Main.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import '../../Comm/genLoginSignupHeader.dart';
import '../../main.dart';

class UpdateAdmin extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<UpdateAdmin> {
  final _formKey = new GlobalKey<FormState>();
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conPhone = TextEditingController();
  final _conPassword = TextEditingController();

  get screenNav => null;

  @override
  void initState() {
    super.initState();

    dbHelper = DbHelper();
    getUserData();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    _conUserId.text = await sp.getString("user_id")!;
    _conDelUserId.text = await sp.getString("user_id")!;
    _conPhone.text = await sp.getString("phone")!;
    _conPassword.text = await sp.getString("password")!;

    _conUserId.text = EncryptUtil.decryptNote(_conUserId.text);
    _conDelUserId.text = EncryptUtil.decryptNote(_conDelUserId.text);
    _conPassword.text = EncryptUtil.decryptNote(_conPassword.text);
  }

  update() async {
    String uid = _conUserId.text;
    String phone = _conPhone.text;
    String passwd = _conPassword.text;

    ///Encrypt data for update
    uid = EncryptUtil.encryptNote(uid);
    passwd = EncryptUtil.encryptNote(passwd);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel user = UserModel(uid, phone, passwd);
      await dbHelper.updateUser(user).then((value) {
        if (value == 1) {
          alertDialog(context, "Successfully Updated");

          updateSP(user, true).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MyApp()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error Update");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error");
      });
    }
  }

  delete() async {
    String delUserID = _conDelUserId.text;
    delUserID = EncryptUtil.encryptNote(delUserID);
    await dbHelper.deleteUser(delUserID).then((value) {
      if (value == 1) {
        alertDialog(context, "Successfully Deleted");

        updateSP(null, false).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MyApp()),
              (Route<dynamic> route) => false);
        });
      }
    });
  }

  Future updateSP(UserModel? user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("phone", user!.phone);
      sp.setString("password", user.password);
    } else {
      sp.remove('user_id');
      sp.remove('phone');
      sp.remove('email');
      sp.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        foregroundColor: Color(0xFF0D47A1),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  genLoginSignupHeader('Update Caregiver'), //Update
                  getTextFormField(
                      controller: _conPhone,
                      icon: Icons.phone,
                      inputType: TextInputType.phone,
                      hintName: 'Phone Number'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),

                  //Update
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 30.0, right: 30),
                        width: double.infinity,
                        child: FlatButton(
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: update,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D47A1),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      //Delete
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 10, left: 30.0, right: 30),
                        width: double.infinity,
                        child: FlatButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: delete,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 30.0, right: 30),
                      //   width: double.infinity,
                      //   child: FlatButton(
                      //     child: Text(
                      //       'Cancel',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Colors.redAccent,
                      //     borderRadius: BorderRadius.circular(30.0),
                      //   ),
                      // ),
                    ],
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

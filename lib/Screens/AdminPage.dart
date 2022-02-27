import 'package:flutter/material.dart';
import 'package:untitled3/Comm/comHelper.dart';
import 'package:untitled3/Comm/genTextFormField.dart';
import 'package:untitled3/DatabaseHandler/DbHelper.dart';
import 'package:untitled3/Model/UserModel.dart';
import 'package:untitled3/Screens/LoginPage.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Screens/UpdateAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled3/Screens/AllAccessPage.dart';

import 'HomePage.dart';

class HomeForm2 extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm2> {
  final _formKey = new GlobalKey<FormState>();
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
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
      _conUserId.text = sp.getString("user_id")!;
    });
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: _conUserId.text == 'Admin'? Text('Admin Only ${_conUserId.text}'): Text('Admin Only User'),
      ),
      body:


      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                            color: Color(0xFF0D47A1),
                        // gradient: LinearGradient(
                        //   colors: <Color>[
                            // Color(0xFF0D47A1),
                            // Color(0xFF1976D2),
                            // Color(0xFF42A5F5),
                          // ],

                      ),
                    ),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return UpdateAdmin();
                        }),
                      );
                    },
                    child: const Text('Update Admin'),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return MainNavigator();
            }),
          );
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}

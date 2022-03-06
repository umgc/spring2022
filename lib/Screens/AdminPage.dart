import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Comm/comHelper.dart';
import 'package:untitled3/Comm/genTextFormField.dart';
import 'package:untitled3/DatabaseHandler/DbHelper.dart';
import 'package:untitled3/Model/UserModel.dart';
import 'package:untitled3/Screens/LoginPage.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Screens/UpdateAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled3/Screens/AllAccessPage.dart';

import '../Observables/ScreenNavigator.dart';
import '../Observables/SettingObservable.dart';
import '../Utility/Constant.dart';
import '../generated/i18n.dart';
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

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    sp.setString("user_id", 'Daryle');
  }

  void removeSP(String key) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
  }

  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);
    final settingObserver = Provider.of<SettingObserver>(context);
    final supportedLocales = GeneratedLocalizationsDelegate().supportedLocales;

    return Builder(

      builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [const SizedBox(height: 200),
                SizedBox(height: 30.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
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
                            },
                            ),
                          );
                        },
                        child: const Text('Update Admin'),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
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
                          removeSP("Admin");
                          screenNav.changeScreen(MAIN_SCREENS.MENU);
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)
                          {
                            return MainNavigator();
                          })); },
                        child: const Text('      Logout      '),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

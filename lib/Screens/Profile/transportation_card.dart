import 'package:flutter/material.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/DatabaseHandler/database_helper_transportation.dart';
import 'package:memorez/Model/Transportation.dart';
import 'package:memorez/Screens/Profile/add_transportation_card.dart';


class TransportationCard extends StatefulWidget {
  @override
  _TransportationCardState createState() => _TransportationCardState();
}

class _TransportationCardState extends State<TransportationCard> {
  //this code checks for admin mode
  late DbHelper dbHelper;
  final _pref = SharedPreferences.getInstance();
  var _conUserId = TextEditingController();
  UserModel? get userData => null;

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text = sp.getString("user_id")!;
    });
  }

  Future<List<Transportation>>? _transportationList;

  @override
  void initState() {
    super.initState();
    _updateTransportationList();

    //this initializes the admin mode check information
    getUserData();
    dbHelper = DbHelper();
  }

  _updateTransportationList() {
    setState(() {
      _transportationList = DatabaseHelper.instance.getTransportationList();
    });
  }

  Widget buildTransportation(Transportation transportation) {

    return Padding(

      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
              title: Text(
                transportation.name!,
                style: kLabelTextStyle,
              ),
              subtitle: Text(
                transportation.phone!,
                style: kSubText,
              ),
              trailing:

              Visibility(
                visible: _conUserId.text == 'Admin',
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddTransportationCard(
                            updateTransportationList: _updateTransportationList,
                            transportation: transportation),
                      ),
                    );
                  },
                ),
              )),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('xxxxxxxxxxxxxxxxxx${_conUserId.text}');

    return Row(
      children: [
        FutureBuilder(

            future: _transportationList,
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Expanded(
                child: ListView.builder(

                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  // padding: EdgeInsets.symmetric(vertical: 15.0),
                  itemCount: 1 + (snapshot.data as List<Transportation>).length,
                  itemBuilder: (BuildContext context, int index) {

                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  I18n.of(context)!.transportation,
                                  style: kSectionTitleTextStyle,
                                ),
                                SizedBox(
                                  height: 10.0,

                                ),
                                Visibility(
                                  visible: _conUserId.text == 'Admin',
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent,
                                      onPrimary: Colors.white,
                                      fixedSize: const Size(20,20),
                                      shape: const CircleBorder(),
                                    ),
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddTransportationCard(
                                              updateTransportationList:
                                              _updateTransportationList),
                                        ),
                                      ),
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return buildTransportation(

                        (snapshot.data as List<Transportation>)[index - 1]);

                  },
                ),
              );
            }),
      ],
    );
  }
}






















// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
// import 'package:memorez/Model/UserModel.dart';
// import 'package:memorez/Model/user.dart';
// import 'package:memorez/Screens/Profile/profile_constants.dart';
// import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
// import 'package:memorez/utils/user_preferences.dart';
//
// import '../Main.dart';
// import 'edit_profile_page.dart';
//
// class TransportationCard extends StatefulWidget {
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<TransportationCard> {
//   final _pref = SharedPreferences.getInstance();
//
//   late DbHelper dbHelper;
//   var _conUserId = TextEditingController();
//
//   UserModel? get userData => null;
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//
//     dbHelper = DbHelper();
//   }
//
//   Future<void> getUserData() async {
//     final SharedPreferences sp = await _pref;
//
//     setState(() {
//       _conUserId.text = sp.getString("user_id")!;
//     });
//   }
//
//   void removeSP(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove("user_id");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = UserPreferences.getUser();
//
//     return Builder(builder: (context) => buildTransportationCard(user));
//   }
//
//   Widget buildTransportationCard(User user) => Row(
//     children: [
//       Expanded(
//         child: Container(
//           padding: const EdgeInsets.only(left: 30, bottom: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('Transportation', style: kSectionTitleTextStyle),
//               //SIZED BOX FOR SPACING
//               SizedBox(
//                 height: 20.0,
//               ),
//               Text('Transportation 1', style: kLabelTextStyle),
//               Text(user.trans1),
//               Text(user.trans1ph),
//               const SizedBox(height: 24),
//               Text('Transportation 2', style: kLabelTextStyle),
//               Text(user.trans2),
//               Text(user.trans2ph),
//             ],
//           ),
//         ),
//       ),
//       Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(30.0),
//             alignment: Alignment.centerRight,
//
//           ),
//         ],
//       ),
//     ],
//   );
// }


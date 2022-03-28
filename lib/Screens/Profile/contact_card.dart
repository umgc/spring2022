import 'package:flutter/material.dart';
import 'package:memorez/Screens/Profile/add_medication_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Model/user.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
import 'package:memorez/utils/user_preferences.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/Model/Allergy.dart';
import 'package:memorez/Model/Medical.dart';
import 'package:memorez/DatabaseHandler/database_helper_contacts.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Model/Contacts.dart';
import 'package:memorez/Screens/Profile/add_contact_card.dart';

import '../Main.dart';
import 'add_allergy_card.dart';
import 'add_medical_history_card.dart';
import 'edit_profile_page.dart';

class ContactCard extends StatefulWidget {
  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
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

  Future<List<Contact>>? _contactList;

  @override
  void initState() {
    super.initState();
    _updateContactList();

    //this initializes the admin mode check information
    getUserData();
    dbHelper = DbHelper();
  }

  _updateContactList() {
    setState(() {
      _contactList = DatabaseHelper.instance.getContactList();
    });
  }

  Widget buildContact(Contact contact) {

    return Padding(

      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
              title: Text(
                contact.name!,
                style: kLabelTextStyle,
              ),
              subtitle: Text(
                contact.phone!,
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
                        builder: (_) => AddContactCard(
                            updateContactList: _updateContactList,
                            contact: contact),
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

            future: _contactList,
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
                  itemCount: 1 + (snapshot.data as List<Contact>).length,
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
                                  'Contacts',
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
                                          builder: (_) => AddContactCard(
                                              updateContactList:
                                              _updateContactList),
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
                    return buildContact(

                        (snapshot.data as List<Contact>)[index - 1]);

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






















//
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
// class CareTeamCard extends StatefulWidget {
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<CareTeamCard> {
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
//     return Builder(builder: (context) => buildCareTeamCard(user));
//   }
//
//   Widget buildCareTeamCard(User user) => Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(left: 30, bottom: 30),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text('Care Team', style: kSectionTitleTextStyle),
//                   //SIZED BOX FOR SPACING
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text('Provider 1', style: kLabelTextStyle),
//                   Text(user.prov1),
//                   Text(user.prov1ph),
//                   const SizedBox(height: 24),
//                   Text('Provider 2', style: kLabelTextStyle),
//                   Text(user.prov2),
//                   Text(user.prov2ph),
//                 ],
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(30.0),
//                 alignment: Alignment.centerRight,
//                 child: ProfileWidget(
//                   imagePath: user.imagePath3,
//                   onClicked: () {
//                     _conUserId.text == 'Admin'
//                         ? Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => EditProfilePage()))
//                         : Navigator.push(context,
//                             MaterialPageRoute(builder: (_) => MainNavigator()));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
// }

























//
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
// class ContactCard extends StatefulWidget {
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<ContactCard> {
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
//     return Builder(builder: (context) => buildContactCard(user));
//   }
//
//   Widget buildContactCard(User user) => Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(left: 30, bottom: 30),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text('Contacts', style: kSectionTitleTextStyle),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text('Contact 1', style: kLabelTextStyle),
//                   Text(user.cont1),
//                   Text(user.cont1ph),
//                   const SizedBox(height: 24),
//                   Text('Contact 2', style: kLabelTextStyle),
//                   Text(user.cont2),
//                   Text(user.cont2ph),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(30.0),
//             alignment: Alignment.centerRight,
//             child: ProfileWidget(
//               imagePath: user.imagePath2,
//               onClicked: () {
//                 _conUserId.text == 'Admin'
//                     ? Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => EditProfilePage()))
//                     : Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => MainNavigator()));
//               },
//             ),
//           ),
//         ],
//       );
// }

import 'package:flutter/material.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/DatabaseHandler/database_helper_contacts.dart';
import 'package:memorez/Model/Contacts.dart';
import 'package:memorez/Screens/Profile/add_contact_card.dart';


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
                                  I18n.of(context)!.contacts,
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

import 'package:flutter/material.dart';
import 'package:memorez/generated/i18n.dart';
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
import 'package:memorez/Model/Contacts.dart';

import '../Main.dart';
import 'edit_profile_page.dart';

class AddContactCard extends StatefulWidget {
  final Function? updateContactList;
  final Contact? contact;

  AddContactCard({this.updateContactList, this.contact});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<AddContactCard> {
  final _formKey = GlobalKey<FormState>();

  String? _name = "";
  String? _phone = "";
  TextEditingController _dateController = TextEditingController();

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_name, $_phone');

      // Insert contact name in Database
      Contact contact = Contact(name: _name, phone: _phone);
      if (widget.contact == null) {
        contact.status = 0;
        DatabaseHelper.instance.insertContact(contact);
      } else {
        // Update contact name in Database
        contact.id = widget.contact!.id;
        DatabaseHelper.instance.updateContact(contact);
      }

      widget.updateContactList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteContact(widget.contact!.id);
    widget.updateContactList!();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.contact == null ? I18n.of(context)!.add  + ' ' + I18n.of(context)!.contact :
                  I18n.of(context)!.update + ' ' + I18n.of(context)!.contact,
                  style: TextStyle(
                      color: Color(0xFF1565C0),
                      fontWeight: FontWeight.w800,
                      fontSize: 30.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration:
                          widget.contact != null?
                          InputDecoration(
                              labelText: I18n.of(context)!.contact + ' ' + I18n.of(context)!.name,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: I18n.of(context)!.contact,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              //? 'Please enter name'
                              ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.name
                              : null,
                          onSaved: (input) => _name = input,
                          initialValue: widget.contact?.name.toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(

                          style: TextStyle(fontSize: 18),
                          decoration:
                          widget.contact != null?
                          InputDecoration(
                              labelText: I18n.of(context)!.phone,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: I18n.of(context)!.phone,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              //? 'Please enter phone'
                                ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.phone
                              : null,
                          onSaved: (input) => _phone = input,
                          initialValue: widget.contact?.phone.toString(),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(
                            widget.contact == null ? I18n.of(context)!.add : I18n.of(context)!.update,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      widget.contact != null
                          ? Container(
                        margin:
                        EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                            BorderRadius.circular(30.0)),
                        child: TextButton(
                          onPressed: _delete,
                          child: Text(
                            I18n.of(context)!.delete,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      )
                          : SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
import 'package:memorez/DatabaseHandler/database_helper_careteam.dart';
import 'package:memorez/Model/CareTeam.dart';

import '../../generated/i18n.dart';
import '../Main.dart';
import 'edit_profile_page.dart';

class AddCareTeamCard extends StatefulWidget {
  final Function? updateCareTeamList;
  final CareTeam? careTeam;

  AddCareTeamCard({this.updateCareTeamList, this.careTeam});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<AddCareTeamCard> {
  final _formKey = GlobalKey<FormState>();

  String? _name = "";
  String? _phone = "";
  TextEditingController _dateController = TextEditingController();

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_name, $_phone');

      // Insert medical history to Users Database
      CareTeam careTeam = CareTeam(name: _name, phone: _phone);
      if (widget.careTeam == null) {
        careTeam.status = 0;
        DatabaseHelper.instance.insertCareTeam(careTeam);
      } else {
        // Update medical history in Users Database
        careTeam.id = widget.careTeam!.id;
        DatabaseHelper.instance.updateCareTeam(careTeam);
      }

      widget.updateCareTeamList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteCareTeam(widget.careTeam!.id);
    widget.updateCareTeamList!();
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
                  //widget.careTeam == null ? 'Add Care Team Member' : 'Update Care Team Member',
                  widget.careTeam == null ? I18n.of(context)!.addCareTeamMember : I18n.of(context)!.updateCareTeamMember,
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
                          widget.careTeam != null?
                          InputDecoration(
                              labelText: I18n.of(context)!.careTeam,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: I18n.of(context)!.careTeam,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.name
                              : null,
                          onSaved: (input) => _name = input,
                          initialValue: widget.careTeam?.name.toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration:
                          widget.careTeam != null?
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
                              ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.phone
                              : null,
                          onSaved: (input) => _phone = input,
                          initialValue: widget.careTeam?.phone.toString(),
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
                            widget.careTeam == null ? I18n.of(context)!.add : I18n.of(context)!.update,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      widget.careTeam != null
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

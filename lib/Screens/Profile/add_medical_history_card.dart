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
import 'package:memorez/DatabaseHandler/databse_helper_history.dart';
import 'package:memorez/Model/History.dart';
import '../../Utility/EncryptionUtil.dart';
import '../Main.dart';
import 'edit_profile_page.dart';

class AddHistoryCard extends StatefulWidget {
  final Function? updateHistoryList;
  final History? history;

  AddHistoryCard({this.updateHistoryList, this.history});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<AddHistoryCard> {
  final _formKey = GlobalKey<FormState>();

  String? _history = "";
  String? _desc = "";
  TextEditingController _dateController = TextEditingController();

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_history, $_desc');
      _history = EncryptUtil.encryptNote(_history);
      _desc = EncryptUtil.encryptNote(_desc);
      // Insert medical history to Users Database
      History history = History(history: _history, desc: _desc);
      if (widget.history == null) {
        history.status = 0;
        DatabaseHelper.instance.insertHistory(history);
      } else {
        // Update medical history in Users Database
        history.id = widget.history!.id;
        DatabaseHelper.instance.updateHistory(history);
      }

      widget.updateHistoryList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteHistory(widget.history!.id);
    widget.updateHistoryList!();
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
                  widget.history == null ? 'Add Past Medical History' : 'Update Past Medical History',
                  style: TextStyle(
                      color: Color(0xFF1565C0),
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0),
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
                          widget.history != null?
                          InputDecoration(
                              labelText: 'Past Medical History',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: 'Past Medical History',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter medical history (ex: Diabetes)'
                              : null,
                          onSaved: (input) => _history = input,
                          initialValue:
                            widget.history != null?
                            EncryptUtil.decryptNote(widget.history?.history.toString()):
                            _history,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration:
                          widget.history != null?
                          InputDecoration(
                              labelText: 'Note',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: 'Note',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter a note or description (ex: Managed by Dr. Evangelista- PCP)'
                              : null,
                          onSaved: (input) => _desc = input,
                          initialValue:
                            widget.history != null?
                            EncryptUtil.decryptNote(widget.history?.desc.toString()): _desc,
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
                            widget.history == null ? 'Add' : 'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      widget.history != null
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
                            'Delete',
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

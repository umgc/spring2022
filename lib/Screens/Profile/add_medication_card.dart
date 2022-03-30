import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Model/user.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
import 'package:memorez/utils/user_preferences.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/DatabaseHandler/database_helper.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import '../../generated/i18n.dart';
import '../Main.dart';
import 'edit_profile_page.dart';

class AddMedicationCard extends StatefulWidget {
  final Function? updateMedicationList;
  final Medication? medication;

  AddMedicationCard({this.updateMedicationList, this.medication});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<AddMedicationCard> {
  final _formKey = GlobalKey<FormState>();

  String? _title = "";
  String? _dose = "";
  TextEditingController _dateController = TextEditingController();

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_title, $_dose');
      _title = EncryptUtil.encryptNote(_title);
      _dose = EncryptUtil.encryptNote(_dose);
      // Insert medication to Users Database
      Medication medication = Medication(title: _title, dose: _dose);
      if (widget.medication == null) {
        medication.status = 0;
        DatabaseHelper.instance.insertMedication(medication);
        print('Inserted to medication table:  ${medication.toMap()}');
      } else {
        // Update medication to Users Database
        medication.id = widget.medication!.id;
        medication.status = widget.medication!.status;
        DatabaseHelper.instance.updateMedication(medication);

      }

      widget.updateMedicationList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteMedication(widget.medication!.id);
    widget.updateMedicationList!();
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
                  widget.medication == null ? I18n.of(context)!.add + ' ' + I18n.of(context)!.medication :
                  I18n.of(context)!.update + ' ' + I18n.of(context)!.medication,
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
                              widget.medication != null?
                                  InputDecoration(
                                    labelText: I18n.of(context)!.medication,
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: I18n.of(context)!.medication + ' ' + I18n.of(context)!.name,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              //? 'Please enter a medication name'
                              ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.medication + ' ' + I18n.of(context)!.name
                              : null,
                          onSaved: (input) => _title = input,
                          initialValue:
                            widget.medication != null?
                            EncryptUtil.decryptNote(widget.medication?.title.toString()):_title,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration:
                          widget.medication != null?
                          InputDecoration(
                              labelText: I18n.of(context)!.dose,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: I18n.of(context)!.medication + ' ' + I18n.of(context)!.dose,
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                             // ? 'Please enter dose'
                              ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.dose
                              : null,
                          onSaved: (input) => _dose = input,
                          initialValue:
                          widget.medication != null?
                          EncryptUtil.decryptNote(widget.medication!.dose) : _dose
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
                            widget.medication == null ? I18n.of(context)!.add : I18n.of(context)!.update,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      widget.medication != null
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

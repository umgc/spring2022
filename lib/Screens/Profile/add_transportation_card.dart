import 'package:flutter/material.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:memorez/DatabaseHandler/database_helper_transportation.dart';
import 'package:memorez/Model/Transportation.dart';
import 'package:provider/provider.dart';

import '../../Observables/SettingObservable.dart';
import '../../Utility/ThemeUtil.dart';


class AddTransportationCard extends StatefulWidget {
  final Function? updateTransportationList;
  final Transportation? transportation;

  AddTransportationCard({this.updateTransportationList, this.transportation});

  @override
  _UserProfileState createState() => _UserProfileState();
}
Color? textCol;

class _UserProfileState extends State<AddTransportationCard> {
  final _formKey = GlobalKey<FormState>();

  String? _name = "";
  String? _phone = "";
  TextEditingController _dateController = TextEditingController();

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_name, $_phone');

      // Insert  transportation to Database
      Transportation transportation =
          Transportation(name: _name, phone: _phone);
      if (widget.transportation == null) {
        transportation.status = 0;
        DatabaseHelper.instance.insertTransportation(transportation);
      } else {
        // Update transportation in Database
        transportation.id = widget.transportation!.id;
        DatabaseHelper.instance.updateTransportation(transportation);
      }

      widget.updateTransportationList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteTransportation(widget.transportation!.id);
    widget.updateTransportationList!();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingObserver = Provider.of<SettingObserver>(context);
    textCol = textMode(settingObserver.userSettings.darkMode);
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
                  widget.transportation == null
                      ? I18n.of(context)!.add + ' ' + I18n.of(context)!.transportation
                      : I18n.of(context)!.update + ' ' + I18n.of(context)!.transportation,
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
                          decoration: widget.transportation != null
                              ? InputDecoration(
                                  labelText: I18n.of(context)!.transportation,
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)))
                              : InputDecoration(
                                  labelText: I18n.of(context)!.transportation,
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              //? 'Please enter transportation name'
                              ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.transportation + ' ' + I18n.of(context)!.name
                              : null,
                          onSaved: (input) => _name = input,
                          initialValue: widget.transportation?.name.toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: widget.transportation != null
                              ? InputDecoration(
                                  labelText: I18n.of(context)!.phone,
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)))
                              : InputDecoration(
                                  labelText: I18n.of(context)!.phone,
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? I18n.of(context)!.pleaseEnter + ' ' + I18n.of(context)!.phone
                              : null,
                          onSaved: (input) => _phone = input,
                          initialValue: widget.transportation?.phone.toString(),
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
                            widget.transportation == null ? I18n.of(context)!.add : I18n.of(context)!.update,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      widget.transportation != null
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30.0)),
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

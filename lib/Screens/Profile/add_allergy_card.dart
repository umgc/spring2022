import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Model/user.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
import 'package:memorez/utils/user_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_allergy.dart';

import '../../Model/Allergy.dart';
import '../Main.dart';
import 'edit_profile_page.dart';

class AddAllergyCard extends StatefulWidget {
  final Function? updateAllergyList;
  final Allergy? allergy;

  AddAllergyCard({this.updateAllergyList, this.allergy});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<AddAllergyCard> {
  final _formKey = GlobalKey<FormState>();

  String? _allergy = "";
  String? _reaction = "";
  TextEditingController _dateController = TextEditingController();

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_allergy, $_reaction');

      // Insert medication to Users Database
      Allergy allergy = Allergy(allergy: _allergy, reaction: _reaction);
      if (widget.allergy == null) {
        allergy.status = 0;
        DatabaseHelper.instance.insertAllergy(allergy);
        print('Inserted to allergy table:  ${allergy.toMap()}');
      } else {
        // Update medication to Users Database
        allergy.id = widget.allergy!.id;
        allergy.status = widget.allergy!.status;
        DatabaseHelper.instance.updateAllergy(allergy);

      }

      widget.updateAllergyList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteAllergy(widget.allergy!.id);
    widget.updateAllergyList!();
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
                  widget.allergy == null ? 'Add Allergy' : 'Update Allergy',
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
                          widget.allergy != null?
                          InputDecoration(
                              labelText: widget.allergy?.allergy.toString(),
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: 'Allergy Name',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter a allergy name'
                              : null,
                          onSaved: (input) => _allergy = input,
                          initialValue: _allergy,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration:
                          widget.allergy != null?
                          InputDecoration(
                              labelText: widget.allergy?.reaction.toString(),
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))):
                          InputDecoration(
                              labelText: 'Allergy Reaction',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter dose'
                              : null,
                          onSaved: (input) => _reaction = input,
                          initialValue: _reaction,
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
                            widget.allergy == null ? 'Add' : 'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      widget.allergy != null
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














//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
// import 'package:memorez/Model/UserModel.dart';
// import 'package:memorez/Model/user.dart';
// import 'package:memorez/Screens/Profile/profile_constants.dart';
// import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
// import 'package:memorez/utils/user_preferences.dart';
// import 'package:memorez/Model/MedicationModel.dart';
// import 'package:memorez/Model/Allergy.dart';
// import 'package:memorez/DatabaseHandler/database_helper_allergy.dart';
//
// import '../Main.dart';
// import 'edit_profile_page.dart';
// class AddAllergyCard extends StatefulWidget {
//   final Function? updateAllergyList;
//   final Allergy? allergy;
//
//   AddAllergyCard({this.updateAllergyList, this.allergy});
//
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<AddAllergyCard> {
//   final _formKey = GlobalKey<FormState>();
//
//   String? _allergy = "";
//   String? _reaction = "";
//   TextEditingController _dateController = TextEditingController();
//
//   _submit() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       print('$_allergy, $_reaction');
//
//       // Insert Allergy to Users Database
//       Allergy allergy = Allergy(allergy: _allergy, reaction: _reaction);
//       if (widget.allergy == null) {
//         // allergy.status = 0;
//         DatabaseHelper.instance.insertAllergy(allergy);
//
//       } else {
//         // Update medication to Users Database
//         allergy.id = widget.allergy!.id;
//         DatabaseHelper.instance.updateAllergy(allergy);
//       }
//
//       widget.updateAllergyList!();
//       Navigator.pop(context);
//     }
//   }
//
//   _delete() {
//     DatabaseHelper.instance.deleteAllergy(widget.allergy!.id);
//     widget.updateAllergyList!();
//     Navigator.pop(context);
//   }
//
//   @override
//   void dispose() {
//     _dateController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     size: 30,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   widget.allergy == null ? 'Add Allergy' : 'Update Allergy',
//                   style: TextStyle(
//                       color: Color(0xFF1565C0),
//                       fontWeight: FontWeight.w800,
//                       fontSize: 30.0),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: TextFormField(
//                           style: TextStyle(fontSize: 18),
//                           decoration:
//                           widget.allergy != null?
//                           InputDecoration(
//                               labelText: widget.allergy?.allergy.toString(),
//                               labelStyle: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0))):
//                           InputDecoration(
//                               labelText: 'Allergy',
//                               labelStyle: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0))),
//                           validator: (input) => input!.trim().isEmpty
//                               ? 'Please enter an allergy'
//                               : null,
//                           onSaved: (input) => _allergy = input,
//                           initialValue: _allergy,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: TextFormField(
//                           style: TextStyle(fontSize: 18),
//                           decoration:
//                           widget.allergy != null?
//                           InputDecoration(
//                               labelText: widget.allergy?.reaction.toString(),
//                               labelStyle: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0))):
//                           InputDecoration(
//                               labelText: 'Reaction',
//                               labelStyle: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0))),
//                           validator: (input) => input!.trim().isEmpty
//                               ? 'Please enter a reaction'
//                               : null,
//                           onSaved: (input) => _reaction = input,
//                           initialValue: _reaction,
//                         ),
//                       ),
//
//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 20.0),
//                         height: 60.0,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: BorderRadius.circular(30.0)),
//                         child: TextButton(
//                           onPressed: _submit,
//                           child: Text(
//                             widget.allergy == null ? 'Add' : 'Update',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       ),
//                       widget.allergy != null
//                           ? Container(
//                         margin:
//                         EdgeInsets.symmetric(vertical: 20.0),
//                         height: 60.0,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius:
//                             BorderRadius.circular(30.0)),
//                         child: TextButton(
//                           onPressed: _delete,
//                           child: Text(
//                             'Delete',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       )
//                           : SizedBox.shrink(),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
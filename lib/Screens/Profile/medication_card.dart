import 'package:flutter/material.dart';
import 'package:memorez/Screens/Profile/add_medication_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/DbHelper.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Model/user.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
import 'package:memorez/utils/user_preferences.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/DatabaseHandler/database_helper.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';

import '../Main.dart';
import 'edit_profile_page.dart';

class MedicationCard extends StatefulWidget {
  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  Future<List<Medication>>? _medicationList;

  @override
  void initState() {
    super.initState();
    _updateMedicationList();
  }

  _updateMedicationList() {
    setState(() {
      _medicationList = DatabaseHelper.instance.getMedicationList();
    });
  }

  Widget buildMedication(Medication medication) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          ListTile(
              title: Text(
                medication.title!,
                style: kLabelTextStyle,
              ),
              subtitle: Text(
                medication.dose!,
                style: kSubText,
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddMedicationCard(
                          updateMedicationList: _updateMedicationList,
                          medication: medication),
                    ),
                  );
                },
              )),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder(
            future: _medicationList,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 60.0),
                  itemCount: 1 + (snapshot.data as List<Medication>).length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Medications',
                                  style: kSectionTitleTextStyle,
                                ),
                                SizedBox(
                                  height: 10.0,

                                ),
                                ElevatedButton(
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
                                        builder: (_) => AddMedicationCard(
                                            updateMedicationList:
                                                _updateMedicationList),
                                      ),
                                    ),
                                  },
                                  child: Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return buildMedication(
                        (snapshot.data as List<Medication>)[index - 1]);
                  },
                ),
              );
            }),
      ],
    );
  }
}

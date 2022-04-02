import 'package:flutter/material.dart';
import 'package:memorez/Screens/Profile/add_medication_card.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/DatabaseHandler/database_helper.dart';

import '../../Observables/SettingObservable.dart';
import '../../Utility/ThemeUtil.dart';


class MedicationCard extends StatefulWidget {
  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
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

  Color? textCol;
  Future<List<Medication>>? _medicationList;

  @override
  void initState() {
    super.initState();
    _updateMedicationList();

    //this initializes the admin mode check information
    getUserData();
    dbHelper = DbHelper();
  }

  _updateMedicationList() {
    setState(() {
      _medicationList = DatabaseHelper.instance.getMedicationList();



    });
  }

  Widget buildMedication(Medication medication) {
    String _mTitle = EncryptUtil.decryptNote(medication.title!);
    String _mDose = EncryptUtil.decryptNote(medication.dose!);
    return Padding(

      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(

              title: Text(
                _mTitle,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  color: textCol
                ),
              ),
              subtitle: Text(
                _mDose,
                style: TextStyle(
                  fontSize: 12.0,
                  color: textCol,
                ),
              ),
              trailing:

              Visibility(
                visible: _conUserId.text == 'Admin',
                child: IconButton(
                  icon: Icon(Icons.edit, color: textCol,),
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
    final settingObserver = Provider.of<SettingObserver>(context);
    textCol = textMode(settingObserver.userSettings.darkMode);

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
                  physics: const ClampingScrollPhysics(),
                  // padding: EdgeInsets.symmetric(vertical: 15.0),
                  itemCount: 1 + (snapshot.data as List<Medication>).length,
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
                                  I18n.of(context)!.medications,
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
                                          builder: (_) => AddMedicationCard(
                                              updateMedicationList:
                                                  _updateMedicationList),
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

import 'package:flutter/material.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/DatabaseHandler/database_helper_profile.dart';
import 'package:memorez/Model/UserModel.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/DatabaseHandler/databse_helper_history.dart';
import 'package:memorez/Model/History.dart';
import '../../Observables/SettingObservable.dart';
import '../../Utility/ThemeUtil.dart';
import '../../generated/i18n.dart';
import 'add_medical_history_card.dart';


class HistoryCard extends StatefulWidget {
  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
  Future<List<History>>? _historyList;

  @override
  void initState() {
    super.initState();
    _updateHistoryList();

    //this initializes the admin mode check information
    getUserData();
    dbHelper = DbHelper();
  }

  _updateHistoryList() {
    setState(() {
      _historyList = DatabaseHelper.instance.getHistoryList();
    });
  }

  Widget buildHistory(History history) {
    String mh = EncryptUtil.decryptNote(history.history!);
    String dh = EncryptUtil.decryptNote(history.desc!);
    return Padding(

      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
              title: Text(
                mh,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  color: textCol
                ),
              ),
              subtitle: Text(
                dh,
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
                        builder: (_) => AddHistoryCard(
                            updateHistoryList: _updateHistoryList,
                            history: history),
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

            future: _historyList,
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
                  itemCount: 1 + (snapshot.data as List<History>).length,
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
                                  I18n.of(context)!.medicalHistory,
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
                                          builder: (_) => AddHistoryCard(
                                              updateHistoryList:
                                              _updateHistoryList),
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
                    return buildHistory(
                        (snapshot.data as List<History>)[index - 1]);
                  },
                ),
              );
            }),
      ],
    );
  }
}

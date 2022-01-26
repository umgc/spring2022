import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/OnboardObservable.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  var language = (I18n.locale?.countryCode != null &&
          I18n.locale?.languageCode != null)
      ? I18n.locale
      // its simply not supported unless it has a language code and a country code
      : Locale("en", "US");

  Future<void> requestPermissionNO() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      await Permission.microphone.request();
      print(status);
    } else {
      await Permission.microphone.request();
      print(status);
    }
  }

  Future<void> requestPermissionYes() async {
    var status = await Permission.microphone.status;

    if (status.isDenied) {
      await Permission.microphone.request();
      await Permission.camera.request();
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    } else if (status.isPermanentlyDenied) {
      status = PermissionStatus.granted;
    } else {
      await Permission.microphone.request();
      print(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onboardingObserver = Provider.of<OnboardObserver>(context);
    var yesText = toBeginningOfSentenceCase(I18n.of(context)!.yes) ??
        I18n.of(context)!.yes;
    var noText = toBeginningOfSentenceCase(I18n.of(context)!.no) ??
        I18n.of(context)!.yes;

    VoiceOverTextService.speakOutLoud(I18n.of(context)!.promptPermission,
        (language as Locale).languageCode.toString());

    return Observer(
        builder: (_) => Scaffold(
                body: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
                  child: Text(
                    I18n.of(context)!.promptPermission,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: onboardingObserver.id,
                      onChanged: (value) {
                        onboardingObserver.permissionYes(1);
                        requestPermissionYes();
                      },
                      groupValue: 1,
                    ),
                    Text(
                      yesText,
                      style: new TextStyle(fontSize: 17.0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(70.0, 22.0, 0.0, 8.0),
                    ),
                    Radio(
                      value: onboardingObserver.id,
                      onChanged: (val) {
                        onboardingObserver.permissionNo(2);
                        requestPermissionNO();
                      },
                      groupValue: 2,
                    ),
                    Text(
                      noText,
                      style: new TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                    child: Container(
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 3),
                      ),
                      child: Text(
                        I18n.of(context)!.permissionNote,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                if (onboardingObserver.denied)
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 200, 15, 0),
                        child: Container(
                          child: Text(
                            I18n.of(context)!.micLimitedAccess,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        )),
                  ),
              ],
            )));
  }
}

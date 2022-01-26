import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Components/VideoPlayer.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:untitled3/Utility/Video_Player.dart';
import 'package:untitled3/generated/i18n.dart';

class WalkthroughScreen extends StatefulWidget {
  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  var language = (I18n.locale?.countryCode != null &&
          I18n.locale?.languageCode != null)
      ? I18n.locale
      // its simply not supported unless it has a language code and a country code
      : Locale("en", "US");

  @override
  Widget build(BuildContext context) {
    VoiceOverTextService.speakOutLoud(I18n.of(context)!.walkthroughVideoLine,
        (language as Locale).languageCode.toString());
    final settingObserver = Provider.of<SettingObserver>(context);
    
    return Scaffold(
        body: VideoPlayerScreen(title: "App Walk-through", videoUrl: "assets/help/example_help.mp4"),
        persistentFooterButtons: [
              Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            ElevatedButton(
                              child: Text(I18n.of(context)!.next.toUpperCase()),
                              onPressed: () {
                                  settingObserver.userSettings.isFirstRun = false;
                                  settingObserver.saveSetting();
                                   Navigator.pushReplacement<void, void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => MainNavigator(),
                                      ));
                                },
                            ),
                          ])
              ],
    );
  }
}
//https://pub.dev/packages/showcaseview/example
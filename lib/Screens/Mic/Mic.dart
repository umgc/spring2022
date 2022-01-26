import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/NLUState.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Mic/ChatBubble.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Utility/FontUtil.dart';
import 'package:untitled3/generated/i18n.dart';

final recordNoteScaffoldKey = GlobalKey<ScaffoldState>();

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  _SpeechScreenState();

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    //onListen(micObserver);
    final micObserver = Provider.of<MicObserver>(context);
    final noteObserver = Provider.of<NoteObserver>(context);
    final mainNavObserver = Provider.of<MainNavObserver>(context);
    final settingObserver = Provider.of<SettingObserver>(context);
    micObserver.setMainNavObserver(mainNavObserver);
    micObserver.setNoteObserver(noteObserver);
    micObserver.setLocale(settingObserver.userSettings.locale);
    micObserver.setI18n(I18n.of(context));

    double bubbleFontSize =
        fontSizeToPixelMap(settingObserver.userSettings.noteFontSize, false);

    TextStyle bubbleTextStyle = TextStyle(fontSize: bubbleFontSize);

    return Observer(
        builder: (_) => Scaffold(
            key: recordNoteScaffoldKey,
            body: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: Text(micObserver.messageInputText,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _controller,
                      itemCount: micObserver.systemUserMessage.length,
                      itemBuilder: (BuildContext context, int index) {
                        dynamic chatObj = micObserver.systemUserMessage[index];
                        //Display text at the top before moving it to the chat bubble
                        if (chatObj is String) {
                          return ChatMsgBubble(
                              message: chatObj.toString(), isSender: true);
                        } else if (chatObj is AppMessage) {
                          AppMessage appfollowUp = chatObj;
                          return ChatMsgBubble(
                            message: appfollowUp.message,
                            actionOption: appfollowUp.responsOptions,
                            followUpType: appfollowUp.followupType,
                            textStyle: bubbleTextStyle,
                          );
                        } else {
                          NLUResponse nluResponse = chatObj;

                          //NLU will send question with options of responses to chose from.
                          print(
                              "nluResponse.resolvedValues ${nluResponse.resolvedValues}");
                          if (nluResponse.actionType == ActionType.ANSWER &&
                              nluResponse.resolvedValues != null) {
                            return ChatMsgBubble(
                              message: nluResponse.response,
                              textStyle: bubbleTextStyle,
                              actionOption: nluResponse.resolvedValues,
                              followUpType: FollowUpTypes.NLU_FOLLOWUP,
                            );
                          }

                          return ChatMsgBubble(message: nluResponse.response);
                        }
                      })),
            ])));
  }
}


// floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerDocked,
//             floatingActionButton: AvatarGlow(
//                 animate: micObserver.micIsExpectedToListen,
//                 glowColor: Theme.of(context).primaryColor,
//                 endRadius: 80,
//                 duration: Duration(milliseconds: 2000),
//                 repeatPauseDuration: const Duration(milliseconds: 100),
//                 repeat: true,
//                 child: Container(
//                   width: 200.0,
//                   height: 200.0,
//                   child: new RawMaterialButton(
//                     shape: new CircleBorder(),
//                     elevation: 0.0,
//                     child: Column(children: [
//                       Image(
//                         image: AssetImage("assets/images/mic.png"),
//                         color: Color(0xFF33ACE3),
//                         height: 100,
//                         width: 100.82,
//                       ),
//                       Text(I18n.of(context)!.notesScreenName,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ))
//                     ]),
//                     onPressed: () => micObserver.toggleListeningMode(),
//                   ),
//                 )),
//             body: Column(children: <Widget>[
//               Container(
//                 padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
//                 child: Text(micObserver.messageInputText,
//                     style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500)),
//               ),

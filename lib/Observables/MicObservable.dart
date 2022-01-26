import 'dart:async';
import 'dart:ui';
import 'package:mobx/mobx.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/NLUState.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Services/NLU/Bot/NLULibService.dart';
import 'package:untitled3/Services/TranslationService.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

part 'MicObservable.g.dart';

/**
 * TODO:
 * - Bubble buttons are responsive.
 *
 */
class MicObserver = _AbstractMicObserver with _$MicObserver;

abstract class _AbstractMicObserver with Store {
  late final NLULibService nluLibService;

  _AbstractMicObserver() {
    nluLibService = NLULibService();
  }

  //messageInputText will be initialize, read and added to the systemUserMessage to be displayed in the chat bubble.
  @observable
  String messageInputText = "";

  //Flag is turn on when the system expects the user to speak. And off otherwise.
  @observable
  bool micIsExpectedToListen = false;

  @observable
  bool expectingUserFollowupResponse = false;

  //Tracks the systems confidence in transcribing the users voice to text.
  @observable
  double speechConfidence = 0;

  //Holds Message interaction between the NLU and the User to be displayed in the UI.
  @observable
  ObservableList<dynamic> systemUserMessage = ObservableList();

  //Instance of MainNavObserver to be passed in from Mic.dart
  @observable
  dynamic mainNavObserver;

  //Instance of Notebservable to be passed in from Mic.dart
  @observable
  dynamic noteObserver;

  //Instance of Notebservable to be passed in from Mic.dart
  @observable
  Locale? locale;

  @observable
  NLUResponse? lastNluMessage;

  @observable
  FollowUpTypes? followUpTypesForMsgSent;

  @observable
  I18n? i18n;

  late NLUResponse nluCreateNote;

  //Speech library user for interfacing with the device's mic resource.
  SpeechToText _speech = SpeechToText();

  int index = 0;

  @action
  Future<void> toggleListeningMode() async {
    /**
     * User activates mic's listening mode
     *  -micIsExpectedToListen = true;
     * Call listen()
     *  -Begin idle time count down (reset time each time the user speaks)
     *  -Gets user voice input stream
     *  -Stop listening
     *      * on mic button click [x]
     *      * on timeout [x]
     *      * on sleep word []
     *  -update the UI message diplay.
     *  -Send message collected to the NLU []
     *  -Recieve NLU Response and call fulfill response
     */
    print("toggleListeningMode: micIsExpectedToListen  $micIsExpectedToListen");

    if (micIsExpectedToListen == false) {
      micIsExpectedToListen = true;
      _listen(micIsExpectedToListen);
    } else {
      micIsExpectedToListen = false;
      _speech.stop();
      systemUserMessage.clear();
      clearMsgTextInput();
      //Reset all values on stopping
    }
  }

  @action
  void setLocale(mlocale) {
    locale = mlocale;
  }

  @action
  void setI18n(mi18n) {
    i18n = mi18n;
  }

  @action
  void _clearChatHistory() {
    systemUserMessage.clear();
  }

  @action
  void addUserMessage(String userMsg) {
    expectingUserFollowupResponse = false;
    print("added user message");
    systemUserMessage.insert(0, userMsg);
  }

  @action
  void addSystemMessage(NLUResponse nluResponse) {
    VoiceOverTextService.speakOutLoud(
        nluResponse.response!, locale!.languageCode.toString());
    systemUserMessage.insert(0, nluResponse);
  }

  @action
  void addFollowUpMessage(
      String message, List<String> responsOptions, FollowUpTypes followupType) {
    if (expectingUserFollowupResponse == true) {
      print(
          "addFollowUpMessage: Still waiting user to respond to the previous followup message");

      //call the listener function
      //_listen(micIsExpectedToListen);
      return;
    }
    VoiceOverTextService.speakOutLoud(message, locale!.languageCode.toString());

    expectingUserFollowupResponse = true;

    followUpTypesForMsgSent = followupType;

    //reply with a no action followup "Ok I will not create note"
    AppMessage appMessage = AppMessage(
        message: message,
        responsOptions: responsOptions,
        followupType: followupType);
    systemUserMessage.insert(0, appMessage);

    //call _listener to wait for user's input
    micIsExpectedToListen = false;

    //_listen(micIsExpectedToListen);
  }

  @action
  void setNoteObserver(observer) {
    noteObserver = observer;
  }

  @action
  void setMainNavObserver(observer) {
    mainNavObserver = observer;
  }

  @action
  void clearMsgTextInput() {
    messageInputText = "";
  }

  @action
  void setVoiceMsgTextInput(value) {
    print("setVoiceMsgTextInput: $value");

    messageInputText = value;
  }

  /*
   * 
   * fufillNLUTask: As its name implies, it recieves an NLURespons
   *  message object and process it based on its actionType
   */
  @action
  Future<void> fufillNLUTask(NLUResponse nluResponse) async {
    //final noteObserver = Provider.of<NoteObserver>(context);
    print("Processing NLU message with action type ${nluResponse.actionType}");
    MainNavObserver resolvedMainNav = (mainNavObserver as MainNavObserver);

    switch (nluResponse.actionType) {
      case ActionType.APP_NAV:
        String screenName = nluResponse.response!;
        switch (screenName) {
          case 'menu':
            resolvedMainNav.changeScreen(MAIN_SCREENS.MENU);
            break;
          case "notes":
            resolvedMainNav.changeScreen(MAIN_SCREENS.NOTE);
            break;
          case "notifications":
            resolvedMainNav.changeScreen(MAIN_SCREENS.NOTIFICATION);
            break;
          case "settings":
            resolvedMainNav.changeScreen(MENU_SCREENS.SETTING);
            break;
          case "help":
            resolvedMainNav.changeScreen(MENU_SCREENS.HELP);
            break;
          case "trigger":
            resolvedMainNav.changeScreen(MENU_SCREENS.TRIGGER);
            break;
          //case "profile":
          //resolvedMainNav.changeScreen(MENU_SCREENS.PROFILE);
          // break;
          //case "security":
          //  resolvedMainNav.changeScreen(MENU_SCREENS.SECURITY);
          // break;
          case "calendar":
            resolvedMainNav.changeScreen(MAIN_SCREENS.CALENDAR);
            break;
          case "checklist":
            resolvedMainNav.changeScreen(MAIN_SCREENS.MENU);
            break;

          default: //TODO ask for more info.
        }
        //create note
        break;

      case ActionType.USER_LOCATION:
        //get the user current location
        //inform the user.
        //Follow up if the user needs additional help

        break;
      case ActionType.APP_HELP:
        //Open the help instructions
        //(mainNavObserver as MainNavObserver).changeScreen(MAIN_SCREENS.CALENDAR)
        break;

      //we probably don't need this
      case ActionType.CREATE_NOTE:

        //ask user if they will like the note create for the event.
        //Pre-followup
        print(
            " case ActionType.CREATE_NOTE: expectingUserFollowupResponse $expectingUserFollowupResponse");

        if (expectingUserFollowupResponse == false) {
          //send followup message.
          print(
              "case ActionType.CREATE_NOTE: ask user if note should be created");
          //temporarily hold the note tobe created
          nluCreateNote = nluResponse;

          addFollowUpMessage(i18n!.shouldICreateANote, [i18n!.yes, i18n!.no],
              FollowUpTypes.CREATE_NOTE);
        } else {
          //recieve follow up response
          if (messageInputText.contains(i18n!.yes)) {
            //create note
            _createNote(nluResponse);
            //FollowUpMessage
            //addSystemMessage("An event has been created to 'eventType' on 'eventTime'");
          }
          //else send NEE_HELP followup
          //addSystemMessage("Is there anything I can help you with?");
          //call _listen to get user input.
        }

        break;
      case ActionType.NOTFOUND:
        break;

      case ActionType.ANSWER:
        //display the text from NLU
        //and follow up with
        print("Case ActionType.ANSWER: ${nluResponse.state}");
        if (locale != Locale("en", "US")) {
          GoogleTranslator translator = GoogleTranslator();
          var translatedResponse = await TranslationService.translate(
              textToTranslate: nluResponse.response ?? '',
              translator: translator,
              toLocale: locale!);
          nluResponse.response = translatedResponse;
        }

        if (nluResponse.state == NLUState.IN_PROGRESS) {
          expectingUserFollowupResponse = true;
          //get user input and send to the NLU
          //use a flag, expectingUserInput, to know when the user is expected to speak
          //micIsExpectedToListen = true;
          addSystemMessage(nluResponse);
          //_restartListening();
        } else {
          expectingUserFollowupResponse = false;

          //display message to the SCREEN
          addSystemMessage(nluResponse);

          micIsExpectedToListen = false;

          //_restartListening();
        }

        break;
    }
  }

  //internally defined actionTypes will include
  //CREATE_NOTE
  //NEED_HELP
  void processFollowups(
      dynamic userSelection, FollowUpTypes followUpType) async {
    //display the users response in the screen.
    print("processFollowups: Selection $userSelection ");
    print("processFollowups: followUpType $followUpType ");
    expectingUserFollowupResponse = false;

    switch (followUpType) {
      case FollowUpTypes.NLU_FOLLOWUP:
        //Call the NLU service with user response to process the information
        //pass response from the NLU to fufillNLUTask
        await nluLibService
            .getNLUResponse(userSelection, "en-US")
            .then((value) => {
                  print(
                      "processFollowups: response from NLU ${(value as NLUResponse).actionType}"),
                  fufillNLUTask(value),
                });
        break;

      case FollowUpTypes.CREATE_NOTE:
        //call the create event service

        addUserMessage(userSelection);

        if (userSelection == i18n!.yes) {
          //get the last message from the user.

          print(
              "Processing NLU message with action type ${nluCreateNote.actionType}");

          print("processFollowups(): creating note ${nluCreateNote.toJson()} ");

          _createNote(nluCreateNote);
        } else {
          //reply with a no action followup "Ok I will not create note"
          //addFollowUpMessage(
          //   "Ok I will not create note", [], FollowUpTypes.NO_ACTION);

          //initiate a NEED_HELP followup: "Is there anything else I can do for you?"
          //idealy, it will be more accurate to wait for the readtime of the previous statement.
          Timer(
              Duration(seconds: 3),
              () => {
                    addFollowUpMessage(
                        i18n!.willNotCreateNote, [], FollowUpTypes.NEED_HELP)
                  });
        }
        break;
      case FollowUpTypes.NEED_HELP:
        if (userSelection == i18n!.yes) {
          print("processFollowups(): user needs more asistance ");
          //reply: "Sure! how can I help you?"
          addFollowUpMessage(
              i18n!.sureHowCanIHelp, [], FollowUpTypes.NO_ACTION);
        } else {
          //reply with "Ok thank you! Bye bye"
          addFollowUpMessage(i18n!.thxBye, [], FollowUpTypes.NO_ACTION);
          if (micIsExpectedToListen == true) {
            toggleListeningMode();
          }
        }
        break;

      default:
        print("processFollowups: Do nothing");
    } //switch (followUpType)
  } //processFollowups Ends

  /*
   * Function creates and save notes.
   */
  Future<void> _createNote(NLUResponse nluResponse) async {
    //get the last message from the user.

    //call the create event service
    TextNote note = TextNote();
    GoogleTranslator translator = GoogleTranslator();
    note.text = nluResponse.response!;
    if (locale != Locale("en", "US")) {
      note.localText = await TranslationService.translate(
          textToTranslate: nluResponse.response!,
          translator: translator,
          toLocale: locale!);
    } else {
      note.localText = nluResponse.response!;
    }

    note.eventDate =
        ((nluResponse.eventDate != null) ? nluResponse.eventDate : "")!;

    note.eventTime =
        ((nluResponse.eventTime != null) ? nluResponse.eventTime : "")!;
    note.isCheckList = (nluResponse.recurringType != null);

    if ((nluResponse.recurringType != null)) {
      note.recurrentType = nluResponse.recurringType!;
    }
    //note.recordLocale = (nluResponse.recurringType != null);
    note.recordedTime = DateTime.now();
    note.language = locale!.languageCode;
    (noteObserver as NoteObserver).addNote(note);

    //Note has been created.
    //addSystemMessage(nluResponse);
    addFollowUpMessage('${i18n!.createdTheFollowingNote} "${note.localText}"', [],
        FollowUpTypes.NO_ACTION);
    //FollowUpMessage
    //addSystemMessage("Is there anything I can help you with?");
  }

  /*
   * Call back function called when system is done listening.
   */
  void _onDone(status) async {
    print('_onDone: onStatus: $status');
    print('_onDone: micIsExpectedToListen $micIsExpectedToListen');

    if (status == "done") {
      //if messageInputText is populated (user's voice was captured), call the NLU
      if (messageInputText.isNotEmpty) {
        addUserMessage(messageInputText);
        if (locale != Locale("en", "US")) {
          GoogleTranslator translator = GoogleTranslator();
          messageInputText = await TranslationService.translate(
              textToTranslate: messageInputText,
              translator: translator,
              fromLocale: locale!);
        }
        await nluLibService
            .getNLUResponse(messageInputText, "en-US")
            .then((value) => {
                  print(
                      "_onDone: response from NLU ${(value as NLUResponse).toJson()}"),
                  fufillNLUTask(value),
                });
        micIsExpectedToListen = false;
        messageInputText = "";
      }
    }
  }

  /*
   * Call back function called when system experiences an error while listening.
   * When error occurs, it calls the _listen() function to re-initiate the listening mode
   * Note that this function is first call in the _listen() and by it calling _listen() results
   * to recursive calls.
   */
  void _onError(status) async {
    print('_onError: onStatus: $status');
    //Re-initiate speech service on error
    micIsExpectedToListen = false;

    //_restartListening();
  }

  _getLocaleId() async {
    var locales = await _speech.locales();
    if (locale == Locale("zh", "CN")) {
      return locales
          .firstWhere((element) => element.localeId == 'cmn_CN')
          .localeId;
    }
    if (locale == Locale("ar", "SY")) {
      return locales
          .firstWhere((element) => element.localeId == 'ar_EG')
          .localeId;
    }
    return locales
        .firstWhere((element) => element.localeId == locale.toString())
        .localeId;
  }

  /*
   * This function initialized the speech interface and turns on listening mode
   * It has two call back functions:
   * _onDone - called when app is done listening.
   * _onErro - called if an error occurs during the listening process.
   *
   */
  Future<void> _listen(micIsExpectedToListen) async {
    bool available = await _speech.initialize(
      onStatus: (val) => _onDone(val),
      onError: (val) => _onError(val),
    );

    print("available $available");
    if (available) {
      final selectedLocaleId = await _getLocaleId();
      _speech.listen(
        localeId: selectedLocaleId,
        //listenFor: Duration(minutes: 15),
        onResult: (val) => {
          setVoiceMsgTextInput(val.recognizedWords),
          if (val.hasConfidenceRating && val.confidence > 0)
            speechConfidence = val.confidence
        },
      );
    }
  }
}

enum FollowUpTypes { CREATE_NOTE, NEED_HELP, NO_ACTION, NLU_FOLLOWUP }

class AppMessage {
  String message;
  List<String> responsOptions;
  FollowUpTypes followupType;

  AppMessage(
      {this.message = "Is there anything else I can help you with?",
      this.responsOptions = const ["Yes", "No"],
      this.followupType = FollowUpTypes.NEED_HELP});
}

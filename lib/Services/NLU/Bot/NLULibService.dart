import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/Model/LexResponse.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/NLUState.dart';
import 'LexService.dart';
import 'package:untitled3/Model/Note.dart';
import '../../NoteService.dart';
import '../BertQA/BertQaService.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Location;

class NLULibService {
  late final BertQAService bertQAService;
  late final LexService lexService;
  static const String FallbackResponse = "Sorry not able to understand.";
  static const String AppHelp = "AppHelp";
  static const String AppNav = "AppNav";
  static const String SearchNotes = "SearchNotes";
  static const String CreateNote = "CreateNote";
  static const String CreateEvent = "CreateEvent";
  static const String CreateActionEvent = "CreateActionEvent";
  static const String CreateRecurringEvent = "CreateRecurringEvent";
  static const String CreateRecurringActionEvent = "CreateRecurringActionEvent";
  static const String HowAreYou = "HowAreYou";
  static const String Hello = "Hello";
  static const String WhatIsYourName = "WhatIsYourName";
  static const String ThankYou = "ThankYou";
  static const String LastThingSaid = "LastThingSaid";
  static const String Compliment = "Compliment";
  static const String Insult = "Insult";
  static const String Goodbye = "Goodbye";
  static const String UserLocation = "UserLocation";
  static const String WhyAmIHere = "WhyAmIHere";
  static const String InterpretationsJsonStr = "interpretations";

  String lastValidInput = "";

  static const String DefaultLocale = "en-US";
  String previousSessionId = "";

  NLULibService() {
    lexService = LexService();
    bertQAService = BertQAService();
  }

  NLULibService.fromtest(LexService _lexService, BertQAService _bertQAService) {
    lexService = _lexService;
    bertQAService = _bertQAService;
  }

  Future<String> getNLUResponseUITest(String text) async {
    NLUResponse nluResponse = (await getNLUResponse(text, DefaultLocale));
    String response = nluResponse.toJson().toString();
    print(response);
    return response;
  }

  Future<NLUResponse> getNLUResponse(String inputText, String locale) async {
    NLUResponse? nluResponse;
    String sessionId = getSessionId();
    Map<String, dynamic> lexResponse = await lexService.getLexResponse(
        text: inputText, userId: sessionId, locale: locale);
    if (lexResponse[InterpretationsJsonStr] != null) {
      var lexResponseObj = LexResponse.fromJson(lexResponse);
      if (lexResponseObj != null) {
        String intentName = getIntentName(lexResponseObj);
        String currentState = getState(lexResponseObj);
        Slots? currentSlots = getSlots(lexResponseObj);
        String outputText = getMessage(lexResponseObj);

        if (intentName.isNotEmpty) {
          if (intentName.startsWith(AppHelp)) {
            nluResponse = getAppHelpResponse(
                lexResponseObj, currentState, inputText, outputText);
          } else if (intentName.startsWith(AppNav)) {
            nluResponse = getAppNavResponse(
                lexResponseObj, currentState, inputText, outputText);
          } else if (intentName == CreateNote) {
            nluResponse = getCreateNoteResponse(
                lexResponseObj, currentState, inputText, outputText);
          } else if (intentName == CreateEvent ||
              intentName == CreateRecurringEvent) {
            nluResponse = getCreateEventResponse(lexResponseObj, currentState,
                inputText, outputText, currentSlots);
          } else if (intentName == CreateActionEvent ||
              intentName == CreateRecurringActionEvent) {
            nluResponse = getCreateActionEventResponse(lexResponseObj,
                currentState, inputText, outputText, currentSlots);
          } else if (intentName == SearchNotes) {
            nluResponse = (await getSearchNoteResponse(inputText));
          } else if (intentName == LastThingSaid) {
            nluResponse = getLastThingSaidResponse(
                lexResponseObj, currentState, inputText, outputText);
          } else if (intentName == UserLocation || intentName == WhyAmIHere) {
            nluResponse = await getUserLocationResponse(
                lexResponseObj, currentState, inputText, outputText);
          } else if (intentName == HowAreYou ||
              intentName == Hello ||
              intentName == WhatIsYourName ||
              intentName == ThankYou ||
              intentName == Compliment ||
              intentName == Insult ||
              intentName == Goodbye) {
            nluResponse = getChitChatResponse(
                lexResponseObj, currentState, inputText, outputText);
          } else {
            nluResponse = (await getSearchNoteResponse(inputText));
          }
        }
      }
    }
    if (nluResponse == null) {
      nluResponse = getFallBackResponse(inputText);
    }
    if (nluResponse.state == NLUState.IN_PROGRESS) {
      previousSessionId = sessionId;
    } else {
      previousSessionId = "";
    }
    String response = nluResponse.toJson().toString();
    return nluResponse;
  }

  /*
     * Generate new Session if the Previous session is not set.
     */
  String getSessionId() {
    String sessionId = "";
    if (previousSessionId.isEmpty)
      sessionId = TextNoteService.generateUUID();
    else
      sessionId = previousSessionId;
    return sessionId;
  }

  String getIntentName(LexResponse lexResponseObj) {
    double highestScore = 0;
    String intentName = "";
    Interpretations? selectedInterpretations = null;
    if (lexResponseObj != null) {
      if (lexResponseObj.sessionState != null &&
          lexResponseObj.sessionState.intent != null &&
          lexResponseObj.sessionState.intent.name.isNotEmpty) {
        intentName = lexResponseObj.sessionState.intent.name;
      } else {
        for (int i = 0; i < lexResponseObj.interpretations.length; i++) {
          Interpretations interpretations =
              lexResponseObj.interpretations.elementAt(i);
          if (interpretations != null &&
              interpretations.intent != null &&
              interpretations.nluConfidence != null &&
              interpretations.nluConfidence.score > 0) {
            if (interpretations.nluConfidence.score > highestScore) {
              highestScore = interpretations.nluConfidence.score;
              selectedInterpretations = interpretations;
            }
          }
        }
        if (selectedInterpretations != null) {
          intentName = selectedInterpretations.intent.name;
        }
      }
    }
    return intentName;
  }

  String getMessage(LexResponse lexResponseObj) {
    String outputText = "";
    try {
      if (lexResponseObj != null &&
          lexResponseObj.messages != null &&
          lexResponseObj.messages.length > 0) {
        for (int i = 0; i < lexResponseObj.messages.length; i++) {
          Messages messages = lexResponseObj.messages.elementAt(i);
          if (messages != null && messages.content.isNotEmpty) {
            outputText = messages.content.toString();
          }
        }
      }
    } catch (error) {}
    return outputText;
  }

  String getState(LexResponse lexResponseObj) {
    String state = "";
    if (lexResponseObj != null) {
      if (lexResponseObj.sessionState != null &&
          lexResponseObj.sessionState.intent != null &&
          lexResponseObj.sessionState.intent.name.isNotEmpty &&
          lexResponseObj.sessionState.intent.state != null &&
          lexResponseObj.sessionState.intent.state.isNotEmpty) {
        state = lexResponseObj.sessionState.intent.state;
      }
    }
    return state;
  }

  Future<String> searchNotesByInput(String message) async {
    String answer = "";
    String notes = await getNotes();
    if (notes != null && notes != "") {
      try {
        answer = bertQAService.answer(notes, message).first.text;
      } catch (Exception) {}
    }
    return answer;
  }

  Future<String> getNotes() async {
    List<TextNote> lstTextNote = await TextNoteService.loadNotes();

    var strBuffer = new StringBuffer();
    String notes = "";
    if (lstTextNote != null && lstTextNote.length > 0) {
      for (int i = 0; i < lstTextNote.length; i++) {
        TextNote textNote = lstTextNote.elementAt(i);
        if (textNote != null &&
            textNote.noteId != null &&
            textNote.noteId != "" &&
            textNote.text != null &&
            textNote.text != "") {
          if (textNote.text.substring(textNote.text.length - 1) == ".") {
            strBuffer
                .write(textNote.text.substring(0, textNote.text.length - 1));
          } else {
            strBuffer.write(textNote.text);
          }
          if (textNote.recurrentType == "none") {
            strBuffer.write(formatDate(textNote.eventDate));
            strBuffer.write(formatTime(textNote.eventTime));
          } else {
            strBuffer.write(formatRecurrence(textNote.recurrentType));
          }
          strBuffer.write(". ");
        }
      }
      print(strBuffer.toString());
    }
    if (strBuffer != null &&
        strBuffer.toString() != null &&
        strBuffer.toString() != "") {
      notes = strBuffer.toString();
    }
    return notes;
  }

  Slots getSlots(LexResponse lexResponseObj) {
    Slots slots = new Slots(
        eventType: new EventType(
            value: new Value(
                interpretedValue: "",
                originalValue: "",
                resolvedValues: new List.empty())),
        date: new EventType(
            value: new Value(
                interpretedValue: "",
                originalValue: "",
                resolvedValues: new List.empty())),
        time: new EventType(
            value: new Value(
                interpretedValue: "",
                originalValue: "",
                resolvedValues: new List.empty())),
        recurringType: new RecurringType(
            value: new Value(
                interpretedValue: "",
                originalValue: "",
                resolvedValues: new List.empty())),
        actionEventType: new ActionEventType(
            value: new Value(
                interpretedValue: "",
                originalValue: "",
                resolvedValues: new List.empty())),
        auxiliaryVerbType: new AuxiliaryVerbType(
            value: new Value(
                interpretedValue: "",
                originalValue: "",
                resolvedValues: new List.empty())));
    if (lexResponseObj != null) {
      if (lexResponseObj.sessionState != null &&
          lexResponseObj.sessionState.intent != null &&
          lexResponseObj.sessionState.intent.slots != null) {
        slots = lexResponseObj.sessionState.intent.slots;
      }
    }
    return slots;
  }

  NLUResponse getAppHelpResponse(LexResponse lexResponseObj,
      String currentState, String inputText, String outputText) {
    ActionType actionType = ActionType.APP_HELP;
    NLUState state = NLUState.COMPLETE;
    lastValidInput = inputText;
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  NLUResponse getAppNavResponse(LexResponse lexResponseObj, String currentState,
      String inputText, String outputText) {
    ActionType actionType = ActionType.APP_NAV;
    NLUState state = NLUState.COMPLETE;
    lastValidInput = inputText;
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  NLUResponse getCreateNoteResponse(LexResponse lexResponseObj,
      String currentState, String inputText, String outputText) {
    ActionType actionType = ActionType.CREATE_NOTE;
    NLUState state = NLUState.COMPLETE;
    lastValidInput = inputText;
    outputText = inputText;
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  Future<NLUResponse?> getSearchNoteResponse(String inputText) async {
    ActionType actionType = ActionType.ANSWER;
    NLUState state = NLUState.COMPLETE;
    lastValidInput = inputText;
    String outputText = await searchNotesByInput(inputText);
    if (outputText.isNotEmpty) {
      outputText = firstToSecond(outputText);
      outputText = capitalizeAndPunctuate(outputText);
    } else {
      outputText = "Sorry I could not understand";
    }
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  NLUResponse getLastThingSaidResponse(LexResponse lexResponseObj,
      String currentState, String inputText, String outputText) {
    ActionType actionType = ActionType.ANSWER;
    NLUState state = NLUState.COMPLETE;
    if (lastValidInput.trim().isNotEmpty) {
      outputText = "You said '$lastValidInput'.";
    } else {
      outputText = "You didn't say anything.";
    }
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  Future<NLUResponse?> getUserLocationResponse(LexResponse lexResponseObj,
      String currentState, String inputText, String outputText) async {
    ActionType actionType = ActionType.ANSWER;
    NLUState state = NLUState.COMPLETE;
    String place = await getUserLocation();
    String outputText = await searchNotesByInput(place);
    if (outputText.isNotEmpty) {
      outputText = firstToSecond(outputText);
      outputText = capitalizeAndPunctuate(outputText);
    } else {
      outputText = "Sorry I could not understand";
    }
    lastValidInput = inputText;
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  NLUResponse getChitChatResponse(LexResponse lexResponseObj,
      String currentState, String inputText, String outputText) {
    ActionType actionType = ActionType.ANSWER;
    NLUState state = NLUState.COMPLETE;
    lastValidInput = inputText;
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  NLUResponse? getCreateActionEventResponse(
      LexResponse lexResponseObj,
      String currentState,
      String inputText,
      String outputText,
      Slots currentSlots) {
    ActionType actionType;
    NLUState state;

    String? recurringType = getRecurringType(currentSlots);
    String? subjectType = getSubjectType(currentSlots);
    String? auxiliaryVerbType = getAuxiliaryVerbType(currentSlots);
    String? actionEventType = getActionEventType(currentSlots);
    String? eventDate = getEventDate(currentSlots, recurringType);
    List<String>? eventTimeResolved = getEventTime(currentSlots, recurringType);
    List<String>? resolvedValues;

    String eventTime = "";

    if (currentState == "InProgress") {
      actionType = ActionType.ANSWER;
      state = NLUState.IN_PROGRESS;
      if (eventTimeResolved != null &&
          eventTimeResolved.length > 1 &&
          outputText == "At what time?") {
        resolvedValues = formatResolvedTimes(eventTimeResolved);
      }
    } else {
      actionType = ActionType.CREATE_NOTE;
      state = NLUState.COMPLETE;
      if (eventTimeResolved != null && eventTimeResolved.length > 0) {
        eventTime = eventTimeResolved.first;
      }
      if (subjectType != null &&
          auxiliaryVerbType != null &&
          actionEventType != null) {
        outputText =
            subjectType + " " + auxiliaryVerbType + " " + actionEventType;
        lastValidInput = outputText;
        if (recurringType != null) {
          lastValidInput += " " + recurringType;
        }
        if (eventDate != null &&
            eventDate.isNotEmpty &&
            recurringType != null) {
          outputText += " on " + eventDate;
          lastValidInput += " on " + eventDate;
        }
        if (eventTime.isNotEmpty && recurringType != null) {
          outputText += " at " + formatRecurringTime(eventTime);
          lastValidInput += " at " + formatRecurringTime(eventTime);
        }
      }
    }
    return new NLUResponse(
        actionType,
        inputText,
        outputText,
        state,
        actionEventType,
        eventDate,
        eventTime,
        resolvedValues,
        recurringType,
        null);
  }

  NLUResponse getCreateEventResponse(
      LexResponse lexResponseObj,
      String currentState,
      String inputText,
      String outputText,
      Slots? currentSlots) {
    ActionType actionType;
    NLUState state;

    String? recurringType = getRecurringType(currentSlots);
    String? subjectType = getSubjectType(currentSlots);
    String? eventType = getEventType(currentSlots);
    String? haveType = getHaveType(currentSlots);
    String? beType = getBeType(currentSlots);

    String? eventDate = getEventDate(currentSlots, recurringType);
    List<String>? eventTimeResolved = getEventTime(currentSlots, recurringType);
    List<String>? resolvedValues;

    String eventTime = "";

    if (currentState == "InProgress") {
      actionType = ActionType.ANSWER;
      state = NLUState.IN_PROGRESS;
      if (eventTimeResolved != null &&
          eventTimeResolved.length > 1 &&
          outputText == "At what time?") {
        resolvedValues = formatResolvedTimes(eventTimeResolved);
      }
    } else {
      actionType = ActionType.CREATE_NOTE;
      state = NLUState.COMPLETE;
      if (eventTimeResolved != null && eventTimeResolved.length > 0) {
        eventTime = eventTimeResolved.first;
      }
      if (subjectType != null && haveType != null && eventType != null) {
        outputText = subjectType + " " + haveType + " " + eventType;
        lastValidInput = outputText;
        if (recurringType != null) {
          lastValidInput += " " + recurringType;
        }
        if (eventDate != null &&
            eventDate.isNotEmpty &&
            recurringType != null) {
          outputText += " on " + eventDate;
          lastValidInput += " on " + eventDate;
        }
        if (eventTime.isNotEmpty && recurringType != null) {
          outputText += " at " + formatRecurringTime(eventTime);
          lastValidInput += " at " + formatRecurringTime(eventTime);
        }
      } else if (beType != null && eventType != null) {
        outputText = "There " + beType + " " + eventType;
        lastValidInput = outputText;
        if (recurringType != null) {
          lastValidInput += " " + recurringType;
        }
        if (eventDate != null &&
            eventDate.isNotEmpty &&
            recurringType != null) {
          outputText += " on " + eventDate;
          lastValidInput += " on " + eventDate;
        }
        if (eventTime.isNotEmpty && recurringType != null) {
          outputText += " at " + formatRecurringTime(eventTime);
          lastValidInput += " at " + formatRecurringTime(eventTime);
        }
      }
    }
    return new NLUResponse(actionType, inputText, outputText, state, eventType,
        eventDate, eventTime, resolvedValues, recurringType, null);
  }

  TimeOfDay getTimeOfDay(String eventTime) {
    int currentHour = 0, currentMin = 0;
    if (eventTime.isNotEmpty) {
      List<String> hourMin = eventTime.split(":");
      if (hourMin != null && hourMin.length > 0) {
        if (hourMin.first != null && hourMin.first.isNotEmpty) {
          currentHour = int.parse(hourMin.first);
        }
        if (hourMin.last != null && hourMin.last.isNotEmpty) {
          currentMin = int.parse(hourMin.last);
        }
      }
    }
    return TimeOfDay(hour: currentHour, minute: currentMin);
  }

  String? getRecurringType(Slots? slots) {
    if (slots != null &&
        slots.recurringType != null &&
        slots.recurringType!.value != null &&
        slots.recurringType!.value!.interpretedValue.isNotEmpty) {
      return slots.recurringType!.value!.interpretedValue;
    }
    return null;
  }

  String? getSubjectType(Slots? slots) {
    if (slots != null &&
        slots.subjectType != null &&
        slots.subjectType!.value != null &&
        slots.subjectType!.value!.interpretedValue.isNotEmpty) {
      return slots.subjectType!.value!.interpretedValue;
    }
    return null;
  }

  String? getAuxiliaryVerbType(Slots? slots) {
    if (slots != null &&
        slots.auxiliaryVerbType != null &&
        slots.auxiliaryVerbType!.value != null &&
        slots.auxiliaryVerbType!.value!.interpretedValue.isNotEmpty) {
      return slots.auxiliaryVerbType!.value!.interpretedValue;
    }
    return null;
  }

  String? getHaveType(Slots? slots) {
    if (slots != null &&
        slots.haveType != null &&
        slots.haveType!.value != null &&
        slots.haveType!.value!.interpretedValue.isNotEmpty) {
      return slots.haveType!.value!.interpretedValue;
    }
    return null;
  }

  String? getBeType(Slots? slots) {
    if (slots != null &&
        slots.beType != null &&
        slots.beType!.value != null &&
        slots.beType!.value!.interpretedValue.isNotEmpty) {
      return slots.beType!.value!.interpretedValue;
    }
    return null;
  }

  String? getEventType(Slots? slots) {
    if (slots != null &&
        slots.eventType != null &&
        slots.eventType!.value != null &&
        slots.eventType!.value!.interpretedValue.isNotEmpty) {
      return slots.eventType!.value!.interpretedValue;
    }
    return null;
  }

  String? getActionEventType(Slots? slots) {
    if (slots != null &&
        slots.actionEventType != null &&
        slots.actionEventType!.value != null &&
        slots.actionEventType!.value!.interpretedValue.isNotEmpty) {
      return slots.actionEventType!.value!.interpretedValue;
    }
    return null;
  }

  String? getEventDate(Slots? slots, String? recurringType) {
    if (recurringType != null) {
      if (slots != null &&
          slots.date != null &&
          slots.date!.value != null &&
          slots.date!.value!.originalValue.isNotEmpty) {
        return slots.date!.value!.originalValue;
      }
    } else if (slots != null &&
        slots.date != null &&
        slots.date!.value != null &&
        slots.date!.value!.interpretedValue.isNotEmpty) {
      return slots.date!.value!.interpretedValue;
    }
    return null;
  }

  List<String>? getEventTime(Slots? slots, recurringType) {
    if (slots != null &&
        slots.time != null &&
        slots.time!.value != null &&
        slots.time!.value!.resolvedValues.length > 0) {
      return slots.time!.value!.resolvedValues;
    } else if (slots != null &&
        slots.time != null &&
        slots.time!.value != null &&
        slots.time!.value!.interpretedValue.isNotEmpty) {
      return new List.from([slots.time!.value!.interpretedValue]);
    }
    return null;
  }

  NLUResponse getFallBackResponse(String inputText) {
    ActionType actionType = ActionType.NOTFOUND;
    String outputText = FallbackResponse;
    NLUState state = NLUState.COMPLETE;
    return new NLUResponse(actionType, inputText, outputText, state, null, null,
        null, null, null, null);
  }

  String formatDate(String date) {
    try {
      DateTime dt = DateTime.parse(date);
      return " on " +
          DateFormat.EEEE().format(dt) +
          ", " +
          DateFormat.yMMMMd().format(dt);
    } catch (e) {
      return date;
    }
  }

  String formatTime(String time) {
    try {
      int hour = int.parse(time.substring(0, 2));
      String minute = time.substring(3);
      if (hour > 12) {
        hour -= 12;
        return " at " + hour.toString() + ":" + minute.toString() + " PM";
      } else {
        return " at " + hour.toString() + ":" + minute.toString() + " AM";
      }
    } catch (e) {
      return time;
    }
  }

  String formatRecurringTime(String time) {
    try {
      int hour = int.parse(time.substring(0, 2));
      String minute = time.substring(3);
      if (hour > 12) {
        hour -= 12;
        return hour.toString() + ":" + minute.toString() + " PM";
      } else {
        return hour.toString() + ":" + minute.toString() + " AM";
      }
    } catch (e) {
      return time;
    }
  }

  String firstToSecond(String text) {
    String invertedText = "";
    var words = text.split(" ");
    for (var i = 0; i < words.length; i++) {
      words[i] = " " + words[i] + " ";
      words[i] = words[i]
          .replaceAll(" i ", " you ")
          .replaceAll(" I ", " you ")
          .replaceAll(" i'm ", " you're ")
          .replaceAll(" I'm ", " you're ")
          .replaceAll(" am ", " are ")
          .replaceAll(" Am ", " are ")
          .replaceAll(" was ", " were ")
          .replaceAll(" Was ", " were ")
          .replaceAll(" me ", " you ")
          .replaceAll(" Me ", " you ")
          .replaceAll(" we ", " you ")
          .replaceAll(" We ", " you ")
          .replaceAll(" we're ", " you're ")
          .replaceAll(" We're ", " you're ")
          .replaceAll(" us ", " you ")
          .replaceAll(" Us ", " you ")
          .replaceAll(" my ", " your ")
          .replaceAll(" My ", " your ")
          .replaceAll(" mine ", " yours ")
          .replaceAll(" Mine ", " yours ")
          .replaceAll(" our ", " your ")
          .replaceAll(" Our ", " your ")
          .replaceAll(" ours ", " yours ")
          .replaceAll(" Ours ", " yours ")
          .replaceAll(" myself ", " yourself ")
          .replaceAll(" Myself ", " yourself ")
          .replaceAll(" ourselves ", " yourselves ")
          .replaceAll(" Ourselves ", " yourselves ")
          .replaceAll(" i. ", " you. ")
          .replaceAll(" I. ", " you. ")
          .replaceAll(" i'm. ", " you're. ")
          .replaceAll(" I'm. ", " you're. ")
          .replaceAll(" am. ", " are. ")
          .replaceAll(" Am. ", " are. ")
          .replaceAll(" was. ", " were. ")
          .replaceAll(" Was. ", " were. ")
          .replaceAll(" me. ", " you. ")
          .replaceAll(" Me. ", " you. ")
          .replaceAll(" we. ", " you. ")
          .replaceAll(" We. ", " you. ")
          .replaceAll(" we're. ", " you're. ")
          .replaceAll(" We're. ", " you're. ")
          .replaceAll(" us. ", " you. ")
          .replaceAll(" Us. ", " you. ")
          .replaceAll(" my. ", " your. ")
          .replaceAll(" My. ", " your. ")
          .replaceAll(" mine. ", " yours. ")
          .replaceAll(" Mine. ", " yours. ")
          .replaceAll(" our. ", " your. ")
          .replaceAll(" Our. ", " your. ")
          .replaceAll(" ours. ", " yours. ")
          .replaceAll(" Ours. ", " yours. ")
          .replaceAll(" myself. ", " yourself. ")
          .replaceAll(" Myself. ", " yourself. ")
          .replaceAll(" ourselves. ", " yourselves. ")
          .replaceAll(" Ourselves. ", " yourselves. ")
          .replaceAll(" i, ", " you, ")
          .replaceAll(" I, ", " you, ")
          .replaceAll(" i'm, ", " you're, ")
          .replaceAll(" I'm, ", " you're, ")
          .replaceAll(" am, ", " are, ")
          .replaceAll(" Am, ", " are, ")
          .replaceAll(" was, ", " were, ")
          .replaceAll(" Was, ", " were, ")
          .replaceAll(" me, ", " you, ")
          .replaceAll(" Me, ", " you, ")
          .replaceAll(" we, ", " you, ")
          .replaceAll(" We, ", " you, ")
          .replaceAll(" we're, ", " you're, ")
          .replaceAll(" We're, ", " you're, ")
          .replaceAll(" us, ", " you, ")
          .replaceAll(" Us, ", " you, ")
          .replaceAll(" my, ", " your, ")
          .replaceAll(" My, ", " your, ")
          .replaceAll(" mine, ", " yours, ")
          .replaceAll(" Mine, ", " yours, ")
          .replaceAll(" our, ", " your, ")
          .replaceAll(" Our, ", " your, ")
          .replaceAll(" ours, ", " yours, ")
          .replaceAll(" Ours, ", " yours, ")
          .replaceAll(" myself, ", " yourself, ")
          .replaceAll(" Myself, ", " yourself, ")
          .replaceAll(" ourselves, ", " yourselves, ")
          .replaceAll(" Ourselves, ", " yourselves, ")
          .replaceAll(" i; ", " you; ")
          .replaceAll(" I; ", " you; ")
          .replaceAll(" i'm; ", " you're; ")
          .replaceAll(" I'm; ", " you're; ")
          .replaceAll(" am; ", " are; ")
          .replaceAll(" Am; ", " are; ")
          .replaceAll(" was; ", " were; ")
          .replaceAll(" Was; ", " were; ")
          .replaceAll(" me; ", " you; ")
          .replaceAll(" Me; ", " you; ")
          .replaceAll(" we; ", " you; ")
          .replaceAll(" We; ", " you; ")
          .replaceAll(" we're; ", " you're; ")
          .replaceAll(" We're; ", " you're; ")
          .replaceAll(" us; ", " you; ")
          .replaceAll(" Us; ", " you; ")
          .replaceAll(" my; ", " your; ")
          .replaceAll(" My; ", " your; ")
          .replaceAll(" mine; ", " yours; ")
          .replaceAll(" Mine; ", " yours; ")
          .replaceAll(" our; ", " your; ")
          .replaceAll(" Our; ", " your; ")
          .replaceAll(" ours; ", " yours; ")
          .replaceAll(" Ours; ", " yours; ")
          .replaceAll(" myself; ", " yourself; ")
          .replaceAll(" Myself; ", " yourself; ")
          .replaceAll(" ourselves; ", " yourselves; ")
          .replaceAll(" Ourselves; ", " yourselves; ")
          .replaceAll(" i? ", " you? ")
          .replaceAll(" I? ", " you? ")
          .replaceAll(" i'm? ", " you're? ")
          .replaceAll(" I'm? ", " you're? ")
          .replaceAll(" am? ", " are? ")
          .replaceAll(" Am? ", " are? ")
          .replaceAll(" was? ", " were? ")
          .replaceAll(" Was? ", " were? ")
          .replaceAll(" me? ", " you? ")
          .replaceAll(" Me? ", " you? ")
          .replaceAll(" we? ", " you? ")
          .replaceAll(" We? ", " you? ")
          .replaceAll(" we're? ", " you're? ")
          .replaceAll(" We're? ", " you're? ")
          .replaceAll(" us? ", " you? ")
          .replaceAll(" Us? ", " you? ")
          .replaceAll(" my? ", " your? ")
          .replaceAll(" My? ", " your? ")
          .replaceAll(" mine? ", " yours? ")
          .replaceAll(" Mine? ", " yours? ")
          .replaceAll(" our? ", " your? ")
          .replaceAll(" Our? ", " your? ")
          .replaceAll(" ours? ", " yours? ")
          .replaceAll(" Ours? ", " yours? ")
          .replaceAll(" myself? ", " yourself? ")
          .replaceAll(" Myself? ", " yourself? ")
          .replaceAll(" ourselves? ", " yourselves? ")
          .replaceAll(" Ourselves? ", " yourselves? ")
          .replaceAll(" i! ", " you! ")
          .replaceAll(" I! ", " you! ")
          .replaceAll(" i'm! ", " you're! ")
          .replaceAll(" I'm! ", " you're! ")
          .replaceAll(" am! ", " are! ")
          .replaceAll(" Am! ", " are! ")
          .replaceAll(" was! ", " were! ")
          .replaceAll(" Was! ", " were! ")
          .replaceAll(" me! ", " you! ")
          .replaceAll(" Me! ", " you! ")
          .replaceAll(" we! ", " you! ")
          .replaceAll(" We! ", " you! ")
          .replaceAll(" we're! ", " you're! ")
          .replaceAll(" We're! ", " you're! ")
          .replaceAll(" us! ", " you! ")
          .replaceAll(" Us! ", " you! ")
          .replaceAll(" my! ", " your! ")
          .replaceAll(" My! ", " your! ")
          .replaceAll(" mine! ", " yours! ")
          .replaceAll(" Mine! ", " yours! ")
          .replaceAll(" our! ", " your! ")
          .replaceAll(" Our! ", " your! ")
          .replaceAll(" ours! ", " yours! ")
          .replaceAll(" Ours! ", " yours! ")
          .replaceAll(" myself! ", " yourself! ")
          .replaceAll(" Myself! ", " yourself! ")
          .replaceAll(" ourselves! ", " yourselves! ")
          .replaceAll(" Ourselves! ", " yourselves! ");
      if (i > 0) {
        invertedText += " ";
      }
      invertedText += words[i].trim();
    }
    return invertedText;
  }

  String capitalizeAndPunctuate(String text) {
    text = text.substring(0, 1).toUpperCase() + text.substring(1);
    if (text.substring(text.length - 1) != ".") {
      text += ".";
    }
    return text;
  }

  List<String> formatResolvedTimes(List resolvedValues) {
    // NumberFormat formatter = new NumberFormat("00");

    print(resolvedValues);

    List<String> formattedResolvedValues = [];
    for (String resolvedValue in resolvedValues) {
      try {
        int hour = int.parse(resolvedValue.substring(0, 2));
        String minute = resolvedValue.substring(3);
        if (hour > 12) {
          hour -= 12;
          formattedResolvedValues.add("$hour:$minute PM");
        } else {
          formattedResolvedValues.add("$hour:$minute AM");
        }
      } catch (e) {}
    }
    return formattedResolvedValues;
  }

  String formatRecurrence(String recurrence) {
    switch (recurrence.toLowerCase()) {
      case "hourly":
        return " every hour";
      case "daily":
        return " every day";
      case "weekly":
        return " every week";
      case "biweekly":
        return " every two weeks";
      case "monthly":
        return " every month";
      case "quarterly":
        return " every three months";
      case "semi-annual":
        return " every six months";
      case "annual":
        return " every year";
      default:
        return " "+recurrence;
    }
  }

  getUserLocation() async {
    //call this async method from whereever you need
    Location.LocationData? myLocation;
    String error;
    Location.Location location = new Location.Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    if (myLocation != null &&
        myLocation.latitude != null &&
        myLocation.longitude != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          myLocation.latitude!, myLocation.longitude!);
      Placemark placeMark = placemarks[0];
      String? name = placeMark.name;
      String? subLocality = placeMark.subLocality;
      String? locality = placeMark.locality;
      String? administrativeArea = placeMark.administrativeArea;
      String? postalCode = placeMark.postalCode;
      String? country = placeMark.country;
      String? address = "${locality}";

      String addressSearch = "";
      if (name != null && name != "") {
        addressSearch += name + " ";
      }
      if (subLocality != null && subLocality != "") {
        addressSearch += subLocality + " ";
      }
      if (administrativeArea != null && administrativeArea != "") {
        addressSearch += administrativeArea + " ";
      }
      if (postalCode != null && postalCode != "") {
        addressSearch += postalCode + " ";
      }
      if (name != null && name != "") {
        addressSearch += name + " ";
      }
      if (country != null && country != "") {
        addressSearch += country + " ";
      }
      if (address != null && address != "") {
        addressSearch += address + " ";
      }
      print(addressSearch);
      return addressSearch;
    }
    return "";
  }
}

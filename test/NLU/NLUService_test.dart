import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Services/NLU/BertQA/BertQaService.dart';
import 'package:untitled3/Services/NLU/Bot/LexService.dart';
import 'dart:convert';
import 'NLUService_test.mocks.dart';
import 'package:untitled3/Services/NLU/Bot/NLULibService.dart';


@GenerateMocks([BertQAService, LexService])
void main() {
  Map<String, dynamic> getMockGreetingData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"Hello\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"FallbackIntent\",\"slots\":{}}},{\"intent\":{\"name\":\"HowAreYou\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"AppHelpNotes\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"CreateRecurringEvent\",\"slots\":{\"BeType\":null,\"Date\":null,\"EventType\":null,\"HaveType\":null,\"RecurringType\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\"]}},\"Time\":null}},\"nluConfidence\":{\"score\":0.08}}],\"messages\":[{\"content\":\"Hello.\",\"contentType\":\"PlainText\"}],\"sessionId\":\"cce910c3-2e46-482b-a976-8e7ac8555ba9\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"Hello\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"63d07000-4192-4627-9471-6f86eac2d39b\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockCreateEventData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"CreateActionEvent\",\"slots\":{\"ActionEventType\":{\"value\":{\"interpretedValue\":\"pick up eggs\",\"originalValue\":\"pick up eggs\",\"resolvedValues\":[\"pick up eggs\",\"picking up eggs\"]}},\"AuxiliaryVerbType\":{\"value\":{\"interpretedValue\":\"need to\",\"originalValue\":\"need to\",\"resolvedValues\":[\"need to\",\"needs to\",\"needed to\",\"need to be\",\"do need to\"]}},\"Date\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\",\"i\"]}},\"Time\":null},\"state\":\"InProgress\"},\"nluConfidence\":{\"score\":0.95}},{\"intent\":{\"name\":\"FallbackIntent\",\"slots\":{}}}],\"messages\":[{\"content\":\"On what date?\",\"contentType\":\"PlainText\"}],\"sessionId\":\"eacc3d9e-e4ee-494c-8c7d-737812174502\",\"sessionState\":{\"dialogAction\":{\"slotToElicit\":\"Date\",\"type\":\"ElicitSlot\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"CreateActionEvent\",\"slots\":{\"ActionEventType\":{\"value\":{\"interpretedValue\":\"pick up eggs\",\"originalValue\":\"pick up eggs\",\"resolvedValues\":[\"pick up eggs\",\"picking up eggs\"]}},\"AuxiliaryVerbType\":{\"value\":{\"interpretedValue\":\"need to\",\"originalValue\":\"need to\",\"resolvedValues\":[\"need to\",\"needs to\",\"needed to\",\"need to be\",\"do need to\"]}},\"Date\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\",\"i\"]}},\"Time\":null},\"state\":\"InProgress\"},\"originatingRequestId\":\"fb00930b-b27a-418c-aa98-6d8dc436aff8\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockHowAreYouData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"HowAreYou\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"WhatIsYourName\",\"slots\":{}},\"nluConfidence\":{\"score\":0.14}},{\"intent\":{\"name\":\"Hello\",\"slots\":{}},\"nluConfidence\":{\"score\":0.14}},{\"intent\":{\"name\":\"AppHelpNotes\",\"slots\":{}},\"nluConfidence\":{\"score\":0.09}},{\"intent\":{\"name\":\"Compliment\",\"slots\":{}},\"nluConfidence\":{\"score\":0.09}}],\"messages\":[{\"content\":\"I'm fine. Thanks.\",\"contentType\":\"PlainText\"}],\"sessionId\":\"2723b612-5ec8-418a-a341-2aba10e64453\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"HowAreYou\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"cfec4477-4805-4f24-87c4-6ccfc2a177a8\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockWhatsIsYourNameData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"WhatIsYourName\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"UserLocation\",\"slots\":{}},\"nluConfidence\":{\"score\":0.15}},{\"intent\":{\"name\":\"LastThingSaid\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"Goodbye\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavMic\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}}],\"messages\":[{\"content\":\"You can call me Sam.\",\"contentType\":\"PlainText\"}],\"sessionId\":\"68f0e57c-f0eb-4caf-ae45-4cd788e10128\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"WhatIsYourName\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"7edc028e-b3c9-4eb7-b186-101f1618f2ca\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockIHateYouData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"Insult\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"ThankYou\",\"slots\":{}},\"nluConfidence\":{\"score\":0.12}},{\"intent\":{\"name\":\"CreateEvent\",\"slots\":{\"BeType\":null,\"Date\":null,\"EventType\":null,\"HaveType\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\"]}},\"Time\":null}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"Compliment\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"CreateActionEvent\",\"slots\":{\"ActionEventType\":null,\"AuxiliaryVerbType\":{\"value\":{\"interpretedValue\":\"will\",\"originalValue\":\"will\",\"resolvedValues\":[\"will\"]}},\"Date\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\"]}},\"Time\":null}},\"nluConfidence\":{\"score\":0.08}}],\"messages\":[{\"content\":\"If you don't have anything nice to say, don't say anything at all.\",\"contentType\":\"PlainText\"}],\"sessionId\":\"1143ff92-cc16-4255-af25-30239cc69523\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"Insult\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"b419b0db-e66f-4ae9-8868-364871b7f5f7\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockThankYouData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"ThankYou\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"Hello\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"HowAreYou\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"Insult\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"AppNavHelp\",\"slots\":{}},\"nluConfidence\":{\"score\":0.07}}],\"messages\":[{\"content\":\"I'm happy to help.\",\"contentType\":\"PlainText\"}],\"sessionId\":\"f62cb0cc-51ec-4457-ad0d-2f9cd305b2d4\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"ThankYou\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"835a3afa-851f-4db6-ac27-6d8eca92bbd0\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockGoodByeData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"ThankYou\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"Hello\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"HowAreYou\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"Insult\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"AppNavHelp\",\"slots\":{}},\"nluConfidence\":{\"score\":0.07}}],\"messages\":[{\"content\":\"I'm happy to help.\",\"contentType\":\"PlainText\"}],\"sessionId\":\"f62cb0cc-51ec-4457-ad0d-2f9cd305b2d4\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"ThankYou\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"835a3afa-851f-4db6-ac27-6d8eca92bbd0\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockIWantToSeeMyEventsData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavCalendar\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"AppNavSettings\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavChecklist\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavMenu\",\"slots\":{}},\"nluConfidence\":{\"score\":0.09}},{\"intent\":{\"name\":\"Compliment\",\"slots\":{}},\"nluConfidence\":{\"score\":0.09}}],\"messages\":[{\"content\":\"calendar\",\"contentType\":\"PlainText\"}],\"sessionId\":\"be2cdad6-c314-4dad-b3db-a73ace7ad1c2\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavCalendar\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"4ea6957a-0045-482f-b8a3-beb7c264ce69\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockShowMeCheckListData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavChecklist\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":0.62}},{\"intent\":{\"name\":\"AppNavTrigger\",\"slots\":{}},\"nluConfidence\":{\"score\":0.14}},{\"intent\":{\"name\":\"Compliment\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"LastThingSaid\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"AppNavMenu\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}}],\"messages\":[{\"content\":\"checklist\",\"contentType\":\"PlainText\"}],\"sessionId\":\"efdfe86b-0952-4635-8041-a34e6af12f5b\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavChecklist\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"d610cf04-4ea2-4680-8bc8-a1aeb1339ac4\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockINeedHelpWithAppData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavHelp\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"AppHelpTheme\",\"slots\":{}},\"nluConfidence\":{\"score\":0.17}},{\"intent\":{\"name\":\"SearchNotes\",\"slots\":{\"ActionEventType\":null,\"AuxiliaryVerbType\":null,\"BeType\":null,\"Date\":null,\"EventType\":null,\"HaveType\":null,\"QuestionAuxiliaryVerbType\":{\"value\":{\"interpretedValue\":\"will\",\"originalValue\":\"will\",\"resolvedValues\":[\"will\"]}},\"QuestionType\":null,\"RecurringType\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\"]}},\"Time\":null}},\"nluConfidence\":{\"score\":0.15}},{\"intent\":{\"name\":\"AppHelpSound\",\"slots\":{}},\"nluConfidence\":{\"score\":0.14}},{\"intent\":{\"name\":\"AppHelpCalendar\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}}],\"messages\":[{\"content\":\"help\",\"contentType\":\"PlainText\"}],\"sessionId\":\"b6bc0325-89d6-4d50-a54a-82b95c15ee76\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavHelp\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"6b5811d1-0479-46d4-a051-5fd3156d9dd2\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockTakeMeToHomePageData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavMenu\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":0.61}},{\"intent\":{\"name\":\"AppNavSettings\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavCalendar\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"AppNavChecklist\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"AppNavNotes\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}}],\"messages\":[{\"content\":\"menu\",\"contentType\":\"PlainText\"}],\"sessionId\":\"4333cac1-23ae-41cd-9c1d-cad68d7d6689\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavMenu\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"bd183358-60fd-40eb-84a7-8038612bcfac\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockIWantToMakeANoteData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavNotes\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"AppNavMic\",\"slots\":{}},\"nluConfidence\":{\"score\":0.12}},{\"intent\":{\"name\":\"AppHelpNotes\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavNotifications\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"AppNavSettings\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}}],\"messages\":[{\"content\":\"notes\",\"contentType\":\"PlainText\"}],\"sessionId\":\"b66b2266-c4e0-4fbc-8d60-67c7832ac0e5\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavNotes\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"25ce75a2-04fb-43c8-a14d-c3c27b3d000e\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockIWantToCheckMyNotificationData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavNotifications\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":0.7}},{\"intent\":{\"name\":\"AppNavSettings\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"AppHelpNotifications\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"CreateActionEvent\",\"slots\":{\"ActionEventType\":null,\"AuxiliaryVerbType\":{\"value\":{\"interpretedValue\":\"will\",\"originalValue\":\"will\",\"resolvedValues\":[\"will\"]}},\"Date\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\"]}},\"Time\":null}},\"nluConfidence\":{\"score\":0.08}},{\"intent\":{\"name\":\"AppNavSecurity\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}}],\"messages\":[{\"content\":\"notifications\",\"contentType\":\"PlainText\"}],\"sessionId\":\"93726912-30c7-496e-ae22-a93a13b99bf3\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavNotifications\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"c47de84c-804a-4bb1-b668-82786a9e63e3\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockINeedToAdjustMySettingsData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavSettings\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":0.71}},{\"intent\":{\"name\":\"AppNavCloud\",\"slots\":{}},\"nluConfidence\":{\"score\":0.13}},{\"intent\":{\"name\":\"AppNavCalendar\",\"slots\":{}},\"nluConfidence\":{\"score\":0.13}},{\"intent\":{\"name\":\"AppNavSecurity\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavNotifications\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}}],\"messages\":[{\"content\":\"settings\",\"contentType\":\"PlainText\"}],\"sessionId\":\"ba7f4d15-0182-4540-aa87-4f938f5753f1\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavSettings\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"f90938aa-a48c-4c99-aabc-8f046159a3a2\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getMockINeedToChangeTriggerPhraseData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavTrigger\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":0.6}},{\"intent\":{\"name\":\"AppNavCloud\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"AppHelpTrigger\",\"slots\":{}},\"nluConfidence\":{\"score\":0.11}},{\"intent\":{\"name\":\"AppNavCalendar\",\"slots\":{}},\"nluConfidence\":{\"score\":0.09}},{\"intent\":{\"name\":\"Compliment\",\"slots\":{}},\"nluConfidence\":{\"score\":0.08}}],\"messages\":[{\"content\":\"trigger\",\"contentType\":\"PlainText\"}],\"sessionId\":\"1240bddc-2a1c-4797-ada0-c02985bc746f\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"AppNavTrigger\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"87b1e8c1-d473-457a-b569-cd79cbf7ea05\"}}";
    return json.decode(lexResponse);
  }


  Map<String, dynamic> getMockCreateNoteData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"CreateNote\",\"slots\":{},\"state\":\"Fulfilled\"},\"nluConfidence\":{\"score\":0.32}},{\"intent\":{\"name\":\"WhatIsYourName\",\"slots\":{}},\"nluConfidence\":{\"score\":0.17}},{\"intent\":{\"name\":\"FallbackIntent\",\"slots\":{}}},{\"intent\":{\"name\":\"AppNavCalendar\",\"slots\":{}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavSecurity\",\"slots\":{}},\"nluConfidence\":{\"score\":0.09}}],\"messages\":[{\"content\":\"[CREATE NOTE] I have created a new note for you.\",\"contentType\":\"PlainText\"}],\"sessionId\":\"e8cd8c76-f2bc-4dfc-aa25-0257bb3a4bb9\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"CreateNote\",\"slots\":{},\"state\":\"Fulfilled\"},\"originatingRequestId\":\"a94d3338-007e-4588-92bc-884504678868\"}}";
    return json.decode(lexResponse);
  }

  Map<String, dynamic> getCreateEventData() {
    String lexResponse = "{\"interpretations\":[{\"intent\":{\"confirmationState\":\"None\",\"name\":\"CreateEvent\",\"slots\":{\"BeType\":null,\"Date\":{\"value\":{\"interpretedValue\":\"2021-11-05\",\"originalValue\":\"tomorrow\",\"resolvedValues\":[\"2021-11-05\"]}},\"EventType\":{\"value\":{\"interpretedValue\":\"meeting\",\"originalValue\":\"meeting\",\"resolvedValues\":[\"meeting\",\"breakfast meeting\",\"meeting with my boss\"]}},\"HaveType\":{\"value\":{\"interpretedValue\":\"have a\",\"originalValue\":\"have a\",\"resolvedValues\":[\"have a\",\"have an\",\"will have a\",\"will have  an\",\"should have a\"]}},\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\",\"i\"]}},\"Time\":{\"value\":{\"interpretedValue\":\"18:00\",\"originalValue\":\"at 6pm\",\"resolvedValues\":[\"18:00\"]}}},\"state\":\"ReadyForFulfillment\"},\"nluConfidence\":{\"score\":1.0}},{\"intent\":{\"name\":\"Goodbye\",\"slots\":{}},\"nluConfidence\":{\"score\":0.17}},{\"intent\":{\"name\":\"AppNavMic\",\"slots\":{}},\"nluConfidence\":{\"score\":0.13}},{\"intent\":{\"name\":\"CreateRecurringEvent\",\"slots\":{\"BeType\":null,\"Date\":null,\"EventType\":{\"value\":{\"interpretedValue\":\"meeting\",\"originalValue\":\"meeting\",\"resolvedValues\":[\"meeting\",\"breakfast meeting\",\"meeting with my boss\"]}},\"HaveType\":{\"value\":{\"interpretedValue\":\"have a\",\"originalValue\":\"have\",\"resolvedValues\":[\"have a\",\"have an\",\"will have a\",\"will have  an\",\"should have a\"]}},\"RecurringType\":null,\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\"]}},\"Time\":{\"value\":{\"interpretedValue\":\"18:00\",\"originalValue\":\"6pm\",\"resolvedValues\":[\"18:00\"]}}}},\"nluConfidence\":{\"score\":0.1}},{\"intent\":{\"name\":\"AppNavCalendar\",\"slots\":{}},\"nluConfidence\":{\"score\":0.09}}],\"sessionId\":\"238a4f69-130d-4e5c-baff-900c7cc4dcb6\",\"sessionState\":{\"dialogAction\":{\"type\":\"Close\"},\"intent\":{\"confirmationState\":\"None\",\"name\":\"CreateEvent\",\"slots\":{\"BeType\":null,\"Date\":{\"value\":{\"interpretedValue\":\"2021-11-05\",\"originalValue\":\"tomorrow\",\"resolvedValues\":[\"2021-11-05\"]}},\"EventType\":{\"value\":{\"interpretedValue\":\"meeting\",\"originalValue\":\"meeting\",\"resolvedValues\":[\"meeting\",\"breakfast meeting\",\"meeting with my boss\"]}},\"HaveType\":{\"value\":{\"interpretedValue\":\"have a\",\"originalValue\":\"have a\",\"resolvedValues\":[\"have a\",\"have an\",\"will have a\",\"will have  an\",\"should have a\"]}},\"SubjectType\":{\"value\":{\"interpretedValue\":\"I\",\"originalValue\":\"I\",\"resolvedValues\":[\"I\",\"i\"]}},\"Time\":{\"value\":{\"interpretedValue\":\"18:00\",\"originalValue\":\"at 6pm\",\"resolvedValues\":[\"18:00\"]}}},\"state\":\"ReadyForFulfillment\"},\"originatingRequestId\":\"44c734aa-39dd-4bd6-bc4b-b5d207a38097\"}}";
    return json.decode(lexResponse);
  }


  group('Unit tests - NLU Service', () {
    final mockBertQAService = MockBertQAService();
    final mockLexService = MockLexService();
    test("Greeting Test", () async {
      Map<String, dynamic> value = getMockGreetingData();
      when(mockLexService
          .getLexResponse(
          text: "hello", userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          "hello", "en-US");
      expect("Hello.", nluResponse.response);
    });

    test("Greeting Test2", () async {
      Map<String, dynamic> value = getMockGreetingData();
      String inputText = "Hey There";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("Hello.", nluResponse.response);
    });

    test("Create Event", () async {
      Map<String, dynamic> value = getMockCreateEventData();
      String inputText = "Create Event";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("On what date?", nluResponse.response);
    });

    test("How are you test", () async {
      Map<String, dynamic> value = getMockHowAreYouData();
      String inputText = "How are you";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("I'm fine. Thanks.", nluResponse.response);
    });

    test("What is your name test", () async {
      Map<String, dynamic> value = getMockWhatsIsYourNameData();
      String inputText = "What is your name";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("You can call me Sam.", nluResponse.response);
    });

    test("I like you test", () async {
      Map<String, dynamic> value = getMockWhatsIsYourNameData();
      String inputText = "I like you";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("You can call me Sam.", nluResponse.response);
    });

    test("I hate you test", () async {
      Map<String, dynamic> value = getMockIHateYouData();
      String inputText = "I hate you";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("If you don't have anything nice to say, don't say anything at all.", nluResponse.response);
    });

    test("thank you test", () async {
      Map<String, dynamic> value = getMockThankYouData();
      String inputText = "thank you";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("I'm happy to help.", nluResponse.response);
    });

    test("goodbye test", () async {
      Map<String, dynamic> value = getMockGoodByeData();
      String inputText = "thank you";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("I'm happy to help.", nluResponse.response);
    });

    test("I want to see my events test", () async {
      Map<String, dynamic> value = getMockIWantToSeeMyEventsData();
      String inputText = "I want to see my events";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("calendar", nluResponse.response);
    });

    test("show me my checklist test", () async {
      Map<String, dynamic> value = getMockShowMeCheckListData();
      String inputText = "show me my checklist";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("checklist", nluResponse.response);
    });

    test("I need help with the app test", () async {
      Map<String, dynamic> value = getMockINeedHelpWithAppData();
      String inputText = "I need help with the app";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("help", nluResponse.response);
    });

    test("take me to the home page test", () async {
      Map<String, dynamic> value = getMockTakeMeToHomePageData();
      String inputText = "take me to the home page";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("menu", nluResponse.response);
    });

    test("I want to make a note test", () async {
      Map<String, dynamic> value = getMockIWantToMakeANoteData();
      String inputText = "I want to make a note";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("notes", nluResponse.response);
    });

    test("I want to check my notifications test", () async {
      Map<String, dynamic> value = getMockIWantToCheckMyNotificationData();
      String inputText = "I want to check my notifications";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("notifications", nluResponse.response);
    });

    test("I need to adjust my settings test", () async {
      Map<String, dynamic> value = getMockINeedToAdjustMySettingsData();
      String inputText = "I need to adjust my settings";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("settings", nluResponse.response);
    });

    test("I want to change my trigger phrase test", () async {
      Map<String, dynamic> value = getMockINeedToChangeTriggerPhraseData();
      String inputText = "I want to change my trigger phrase";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("trigger", nluResponse.response);
    });

    test("I have a son named David test", () async {
      Map<String, dynamic> value = getMockCreateNoteData();
      String inputText = "I have a son named David";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect(ActionType.CREATE_NOTE, nluResponse.actionType);
    });

    test("I have a son named David test", () async {
      Map<String, dynamic> value = getMockCreateNoteData();
      String inputText = "I have a son named David";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect(ActionType.CREATE_NOTE, nluResponse.actionType);
    });

    test("I have a meeting tomorrow at 6pm test", () async {
      Map<String, dynamic> value = getCreateEventData();
      String inputText = "I have a son named David";

      when(mockLexService
          .getLexResponse(
          text: inputText, userId: anyNamed("userId"), locale: "en-US"))
          .thenAnswer((_) async => value);
      NLULibService nluService = NLULibService.fromtest(
          mockLexService, mockBertQAService);

      NLUResponse nluResponse = await nluService.getNLUResponse(
          inputText, "en-US");
      expect("meeting", nluResponse.eventType);
    });
  });
}


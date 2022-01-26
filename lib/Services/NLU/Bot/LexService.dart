library LexService;

import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';

///The different types of responses a [LexResponse] can be
enum DialogState {
  ElicitIntent,
  ConfirmIntent,
  ElicitSlot,
  Fulfilled,
  ReadyForFulfillment,
  Failed,
}

enum MessageFormat { PlainText, CustomPayload, SSML, Composite }

///The base class for [LexService].
///
///Create a local instance to use.
class LexService {
  late String _accessKey;
  late String _secretKey;
  late String _url;
  late String _region;
  late String _serviceName;
  late String _botId;
  late String _botAliasId;
  late String _localeId;

  LexService() {
    this.loadCredentials();
  }

  Future<void> loadCredentials() async {
    String xmlBody = await rootBundle.loadString('assets/NLU/Lex_Credentials.xml');
    XmlDocument xml = XmlDocument.parse(xmlBody);
    this._accessKey = xml.getElement("credentials")!.getElement("accessKey")!.text;
    this._secretKey = xml.getElement("credentials")!.getElement("secretKey")!.text;
    this._botId = xml.getElement("credentials")!.getElement("botId")!.text;
    this._botAliasId = xml.getElement("credentials")!.getElement("botAliasId")!.text;
    this._url = xml.getElement("credentials")!.getElement("serviceUrl")!.text;
    this._region = xml.getElement("credentials")!.getElement("region")!.text;
    this._serviceName = xml.getElement("credentials")!.getElement("serviceName")!.text;
    this._localeId = xml.getElement("credentials")!.getElement("defaultLocale")!.text;
  }


  Future<Map<String, dynamic>> getLexResponse({
    @required String? text,
    ///[userId] is the unique ID for the current user/session/etc
    ///This can be fixed, generated randomly, or taken from a known source.
    required String userId,
    required String locale
  }) async {
    Map<String, dynamic> value = new Map();
    try {
      Map<String, String>? mapHeader = Map<String, String>.from({
        'Content-Type': 'application/json; charset=utf-8',
      });
      AwsSigV4Client client = AwsSigV4Client(
          _accessKey,
          _secretKey,
          _url,
          region: _region,
          serviceName: _serviceName);
      final signedRequest = SigV4Request(
        client,
        method: 'POST',
        path: '/bots/$_botId/botAliases/$_botAliasId/botLocales/$_localeId/sessions/$userId/text',
        headers: mapHeader,
        body: Map<String, dynamic>.from({"text": text}),
      );
      Uri uri = Uri.parse(signedRequest.url.toString());
      String? body = signedRequest.body;
      final response = await http.post(
        uri,
        headers: mapHeader,
        body: body,
      );
      if (response.statusCode == 200) {
        value = json.decode(response.body);
      }
    } catch (error) {
      print('Error occured during getLexResponse: $error');
    }
    return value;
  }
}
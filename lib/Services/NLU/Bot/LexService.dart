library LexService;

import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
// import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';
import 'package:sigv4/sigv4.dart';

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
    String xmlBody =
    await rootBundle.loadString('assets/NLU/Lex_Credentials.xml');
    XmlDocument xml = XmlDocument.parse(xmlBody);
    this._accessKey =
        xml.getElement("credentials")!.getElement("accessKey")!.text;
    this._secretKey =
        xml.getElement("credentials")!.getElement("secretKey")!.text;
    this._botId = xml.getElement("credentials")!.getElement("botId")!.text;
    this._botAliasId =
        xml.getElement("credentials")!.getElement("botAliasId")!.text;
    this._url = xml.getElement("credentials")!.getElement("serviceUrl")!.text;
    this._region = xml.getElement("credentials")!.getElement("region")!.text;
    this._serviceName =
        xml.getElement("credentials")!.getElement("serviceName")!.text;
    this._localeId =
        xml.getElement("credentials")!.getElement("defaultLocale")!.text;
  }

  Future<Map<String,dynamic>> getLexResponse(
      {@required String? text,

        ///[userId] is the unique ID for the current user/session/etc
        ///This can be fixed, generated randomly, or taken from a known source.
        // required String userId,
        required String locale}
      ) async {
    var response;

    String requestUrl= "https://runtime-v2-lex."+_region+".amazonaws.com/bots/"+_botId+"/botAliases/"+_botAliasId+"/botLocales/en_US/sessions/aef5d1c4-96a6-4b60-af41-182cadae5084/text";

    Sigv4Client client = Sigv4Client(
      region: _region,
      serviceName: 'lex',
      defaultContentType: 'application/json; charset=utf-8',
      keyId: _accessKey,
      accessKey: _secretKey,
    );

    final request = client.request(
      requestUrl,
      method: 'POST',
      body: jsonEncode({'text': text}),
    );

    response = await http.post(request.url,
        headers: request.headers, body: request.body);
    var result = jsonDecode(response.body.toString());
    print("XXXXXXX $requestUrl 88888888888: ${response.body}");
    print("Result: ${result.toString()}");
    return result;
  }
}

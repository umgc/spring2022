import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:translator/translator.dart';
import 'package:untitled3/Services/TranslationService.dart';

void main() {
  group('Integration tests - call server', ()
  {
    test("English to English", () async {
      GoogleTranslator translator = new GoogleTranslator();
      var retVal = await TranslationService.translate(
          textToTranslate: 'hello world', translator: translator);
      expect(retVal.toString(), 'hello world');
    });
    test("English to Spanish", () async {
      GoogleTranslator translator = new GoogleTranslator();
      var retVal = await TranslationService.translate(
          textToTranslate: 'hello world',
          translator: translator,
          fromLocale: Locale("en", "US"),
          toLocale: Locale("es", "US"));
      expect(retVal.toString(), 'Hola Mundo');
    });
  });

}
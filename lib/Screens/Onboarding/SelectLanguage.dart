import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Services/LocaleService.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:untitled3/Observables/OnboardObservable.dart';
import 'package:provider/provider.dart';

class SelectLanguageScreen extends StatefulWidget {
  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  var language = (I18n.locale?.countryCode != null &&
          I18n.locale?.languageCode != null)
      ? I18n.locale
      // its simply not supported unless it has a language code and a country code
      : Locale("en", "US");

  @override
  Widget build(BuildContext context) {
    VoiceOverTextService.speakOutLoud(I18n.of(context)!.selectLanguage,
        (language as Locale).languageCode.toString());

    final onboardingObserver = Provider.of<OnboardObserver>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Text(I18n.of(context)!.selectLanguage,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 22.0, 275.0, 8.0),
          child: Text(I18n.of(context)!.language,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: 385,
            height: 40,
            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: DropdownButton(
              hint: Text(
                I18n.of(context)!.selectLanguage,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              //icon: Icon(                // Add this
              //  Icons.arrow_drop_down_outlined,  // Add this
              //  color: Colors.blue,   // Add this
              //),
              icon: Image.asset(
                // Add this
                //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
                "assets/images/dropdownarrow.png",
                width: 28,
                height: 18,
                //Icons.arrow_drop_down_outlined,
                //size: 31,
                color: Colors.blue, // Add this
              ),
              value: language,

              onChanged: (Locale? locale) {
                language = locale;
                onboardingObserver.languageChange(language);
              },
              isExpanded: true,
              underline: SizedBox(),
              style: Theme.of(context).textTheme.bodyText1,
              items: GeneratedLocalizationsDelegate()
                  .supportedLocales
                  .map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem,
                    child: Text((LocaleService.getDisplayLanguage(
                        valueItem.languageCode)["name"])));
              }).toList(),
            ),
          ),
        ),
      ],
    ));
  }
}

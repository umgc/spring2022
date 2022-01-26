import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/OnboardObservable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class CloudSetupScreen extends StatefulWidget {
  @override
  _CloudSetupScreenState createState() => _CloudSetupScreenState();
}

class _CloudSetupScreenState extends State<CloudSetupScreen> {
  @override
  Widget build(BuildContext context) {
    final onboardingObserver = Provider.of<OnboardObserver>(context);
    var yesText = toBeginningOfSentenceCase(I18n.of(context)!.yes) ?? I18n.of(context)!.yes;
    var noText = toBeginningOfSentenceCase(I18n.of(context)!.no) ?? I18n.of(context)!.yes;

    return Observer(builder: (_) =>
        Scaffold(
        body: Scaffold(
            body: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Text(
            I18n.of(context)!.cloudSetupPrompt,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value:onboardingObserver.id,
              onChanged:(value) {
                onboardingObserver.permissionYes(1);
              },

              groupValue: 1 ,
            ),
            Text(
              yesText,
              style: new TextStyle(fontSize: 17.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(70.0, 22.0, 0.0, 8.0),
            ),
            Radio(
              value:onboardingObserver.id ,
              onChanged: (val) => onboardingObserver.permissionNo(2),
              groupValue: 2,
            ),
            Text(
              noText,
              style: new TextStyle(fontSize: 17.0),
            ),
          ],
        )
      ],
    ))));
  }
}

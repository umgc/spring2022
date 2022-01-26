import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

final cancelButton = (BuildContext context) => Container(
      padding: const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
      child: ElevatedButton(
        onPressed: () {
          final screenNav = Provider.of<MenuObserver>(context, listen: false);
          screenNav.changeScreen(MENU_SCREENS.MENU);
        },
        child: Text(
          I18n.of(context)!.cancel,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        style: ElevatedButton.styleFrom(
            fixedSize: Size(30, 40), primary: Colors.grey),
      ),
    );

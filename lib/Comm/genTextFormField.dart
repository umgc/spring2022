

import 'package:flutter/material.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:provider/provider.dart';

import '../Observables/ScreenNavigator.dart';
import 'comHelper.dart';

class getTextFormField extends StatelessWidget {

  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool isEnable;

  getTextFormField(
      {required this.controller,
        required this.hintName,
        required this.icon,
        this.isObscureText = false,
        this.inputType = TextInputType.text,
        this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onTap: (){screenNav.changeScreen(MENU_SCREENS.SETTING);},
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintName';
          }

          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}

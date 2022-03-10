import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorez/Model/user.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  static const myUser = User(
      imagePath:
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      imagePath2:
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      imagePath3:
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',

      name: 'Naruto Uzumaki',
      phone: '123456',
      bday: 'October 10, 2001',
      cont1: 'Not Assigned',
      cont1ph: 'na',
      cont2: 'Not Assigned',
      cont2ph: 'na',
      prov1: 'Not Assigned',
      prov1ph: 'na',
      prov2: 'Not Assigned',
      prov2ph: 'na'
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}

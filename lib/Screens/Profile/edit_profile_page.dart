import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/user.dart';
import 'package:memorez/Screens/Profile/profile_constants.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/utils/user_preferences.dart';
import 'package:memorez/Screens/Profile/widget/button_widget.dart';
import 'package:memorez/Screens/Profile/widget/profile_widget.dart';
import 'package:memorez/Screens/Profile/widget/textfield_widget.dart';
import 'package:path/path.dart';
import '../../Comm/comHelper.dart';
import '../../Observables/ScreenNavigator.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);
    return Builder(
      builder: (context) => Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              I18n.of(context)!.aboutMe,
              style: kSectionTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ProfileWidget(
                    imagePath: user.imagePath,
                    isEdit: true,
                    onClicked: () async {
                      final image = await ImagePicker()
                          .getImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final directory =
                          await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${directory.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);

                      setState(
                          () => user = user.copy(imagePath: newImage.path));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_a_photo),
                    iconSize: 40,
                    color: Colors.black87,
                    onPressed: () async {
                      final image = await ImagePicker()
                          .getImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final directory =
                          await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${directory.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);

                      setState(
                          () => user = user.copy(imagePath: newImage.path));
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: I18n.of(context)!.name,
              text: user.name,
              onChanged: (name) => user = user.copy(name: name),
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: I18n.of(context)!.phone,
              text: user.phone,
              onChanged: (phone) => user = user.copy(phone: phone),
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: I18n.of(context)!.dateOfBirth,
              text: EncryptUtil.decryptNote(user.bday),
              maxLines: 1,
              onChanged: (bday) {
                bday = EncryptUtil.encryptNote(bday);
                user = user.copy(bday: bday);
              }
            ),
            const SizedBox(height: 24),
            const SizedBox(
                height: 34,
                child: Divider(
                  color: Colors.blueGrey,
                )),

            ButtonWidget(
              text: I18n.of(context)!.save,
              onClicked: () {
                screenNav.changeScreen(MENU_SCREENS.USERPROFILE);
                UserPreferences.setUser(user);
                UserPreferences.getUser();
                alertDialog(context, "Updated User Profile");
                print('Encrypted data: Birthdate: ${user.bday}');
              },
            ),
            const SizedBox(height: 10),
            ButtonWidget(
              text: 'Cancel',
              color: Colors.red,
              onClicked: () {
                screenNav.changeScreen(MENU_SCREENS.USERPROFILE);
                alertDialog(context, "No Changes Saved");
              },
            )
          ],
        ),
      ),
    );
  }
}

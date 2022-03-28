import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memorez/Utility/EncryptionUtil.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/user.dart';
import 'package:memorez/Screens/Profile/UserProfile.dart';
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

            //
            // Text('Contacts',
            //     style: kSectionTitleTextStyle, textAlign: TextAlign.center),
            // SizedBox(
            //   height: 24,
            // ),
            // Container(
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: <Widget>[
            //       ProfileWidget(
            //         imagePath: user.imagePath2,
            //         isEdit: true,
            //         onClicked: () async {
            //           final image = await ImagePicker()
            //               .getImage(source: ImageSource.gallery);
            //
            //           if (image == null) return;
            //
            //           final directory =
            //               await getApplicationDocumentsDirectory();
            //           final name = basename(image.path);
            //           final imageFile = File('${directory.path}/$name');
            //           final newImage =
            //               await File(image.path).copy(imageFile.path);
            //
            //           setState(
            //               () => user = user.copy(imagePath2: newImage.path));
            //         },
            //       ),
            //       Icon(
            //         Icons.add_a_photo,
            //         size: 40,
            //         color: Colors.black87,
            //       )
            //     ],
            //   ),
            // ),
            // TextFieldWidget(
            //   label: 'Contact 1 Name',
            //   text: user.cont1,
            //   maxLines: 1,
            //   onChanged: (cont1) => user = user.copy(cont1: cont1),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Contact 1 Phone',
            //   text: user.cont1ph,
            //   maxLines: 1,
            //   onChanged: (cont1ph) => user = user.copy(cont1ph: cont1ph),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Contact 2 Name',
            //   text: user.cont2,
            //   maxLines: 1,
            //   onChanged: (cont2) => user = user.copy(cont2: cont2),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Contact 2 Phone',
            //   text: user.cont2ph,
            //   maxLines: 1,
            //   onChanged: (cont2ph) => user = user.copy(cont2ph: cont2ph),
            // ),
            // const SizedBox(height: 24),
            // const SizedBox(
            //     height: 34,
            //     child: Divider(
            //       color: Colors.blueGrey,
            //     )),
            // Text('Care Team',
            //     style: kSectionTitleTextStyle, textAlign: TextAlign.center),
            // SizedBox(
            //   height: 24,
            // ),
            // Container(
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: <Widget>[
            //       ProfileWidget(
            //         imagePath: user.imagePath3,
            //         isEdit: true,
            //         onClicked: () async {
            //           final image = await ImagePicker()
            //               .getImage(source: ImageSource.gallery);
            //
            //           if (image == null) return;
            //
            //           final directory =
            //               await getApplicationDocumentsDirectory();
            //           final name = basename(image.path);
            //           final imageFile = File('${directory.path}/$name');
            //           final newImage =
            //               await File(image.path).copy(imageFile.path);
            //
            //           setState(
            //               () => user = user.copy(imagePath3: newImage.path));
            //         },
            //       ),
            //       Icon(
            //         Icons.add_a_photo,
            //         size: 40,
            //         color: Colors.black87,
            //       )
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Provider 1 Name',
            //   text: user.prov1,
            //   maxLines: 1,
            //   onChanged: (prov1) => user = user.copy(prov1: prov1),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Provider 1 Phone',
            //   text: user.prov1ph,
            //   maxLines: 1,
            //   onChanged: (prov1ph) => user = user.copy(prov1ph: prov1ph),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Provider 2 Name',
            //   text: user.prov2,
            //   maxLines: 1,
            //   onChanged: (prov2) => user = user.copy(prov2: prov2),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Provider 2 Phone',
            //   text: user.prov2ph,
            //   maxLines: 1,
            //   onChanged: (prov2ph) => user = user.copy(prov2ph: prov2ph),
            // ),
            // const SizedBox(height: 24),
            //
            // //Transportation
            // Text('Transportation',
            //     style: kSectionTitleTextStyle, textAlign: TextAlign.center),
            // SizedBox(
            //   height: 24,
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Transportation 1',
            //   text: user.trans1,
            //   maxLines: 1,
            //   onChanged: (trans1) => user = user.copy(trans1: trans1),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Transportation 1 Phone',
            //   text: user.trans1ph,
            //   maxLines: 1,
            //   onChanged: (trans1ph) => user = user.copy(trans1ph: trans1ph),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Transportation 2',
            //   text: user.trans2,
            //   maxLines: 1,
            //   onChanged: (trans2) => user = user.copy(trans2: trans2),
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Transportation 2 Phone',
            //   text: user.trans2ph,
            //   maxLines: 1,
            //   onChanged: (trans2ph) => user = user.copy(trans2ph: trans2ph),
            // ),
            // const SizedBox(height: 24),

            ButtonWidget(
              text: 'Save',
              onClicked: () {
                screenNav.changeScreen(MENU_SCREENS.USERPROFILE);
                UserPreferences.setUser(user);
                UserPreferences.getUser();
                alertDialog(context, "Updated User Profile");
                print('Encrypted data: Birthdate: ${user.bday}');
              },
            ),
          ],
        ),
      ),
    );
  }
}

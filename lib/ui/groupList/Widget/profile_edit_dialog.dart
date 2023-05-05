import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditDialog extends StatefulHookConsumerWidget {
  @override
  ProfileEditDialogState createState() => ProfileEditDialogState();
}

class ProfileEditDialogState extends ConsumerState<ProfileEditDialog> {
  final ImagePicker _picker = ImagePicker();
  // プロフィール変更ダイアログ
  @override
  Widget build(BuildContext context) {
    final sideMenuStatus = ref.watch(groupListViewModelProvider);
    return AlertDialog(
      title: const Text('プロフィールを編集'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    var image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    log("画像選択");
                    if (image != null) {
                      var imageTemp = File(image.path);
                      sideMenuStatus.setNewProfileImage(imageTemp);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: sideMenuStatus.newProfileImage != null
                        ? FileImage(sideMenuStatus.newProfileImage!)
                        : sideMenuStatus.loginUser != null &&
                                sideMenuStatus.loginUser!.image != null &&
                                sideMenuStatus.loginUser!.image!.isNotEmpty
                            ? NetworkImage(sideMenuStatus.loginUser!.image!)
                                as ImageProvider<Object>
                            : AssetImage('assets/no_image_square.jpeg'),
                    radius: 40,
                  ),
                ),
                TextFormField(
                  initialValue: sideMenuStatus.loginUser!.nickName,
                  decoration: const InputDecoration(
                    labelText: '名前',
                  ),
                  onChanged: sideMenuStatus.setNewUserName,
                ),
                TextFormField(
                  initialValue: "",
                  decoration: const InputDecoration(
                    labelText: '自己紹介',
                  ),
                  onChanged: sideMenuStatus.setNewIntro,
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            sideMenuStatus.updateUserInfo(() {});
            Navigator.pop(context);
          },
          child: const Text('プロフィール更新'),
        ),
      ],
    );
  }
}

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
  File? _profileFile;
  // プロフィール変更ダイアログ
  @override
  Widget build(BuildContext context) {
    final sideMenuStatus = ref.watch(groupListViewModelProvider);
    return ElevatedButton(
      child: const Text(''),
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
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
                        final ImagePicker _picker = ImagePicker();
                        var image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          // what you get if you cancel
                          setState(() {
                            _profileFile = image as File?;
                          });
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          sideMenuStatus.loginUser!.image!,
                        ),
                        radius: 40,
                      ),
                    ),
                    TextFormField(
                      initialValue: sideMenuStatus.loginUser!.nickName,
                      decoration: const InputDecoration(
                        labelText: '名前',
                      ),
                    ),
                    TextFormField(
                      initialValue: "",
                      decoration: const InputDecoration(
                        labelText: '自己紹介',
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('プロフィール更新'),
            ),
          ],
        ),
      ),
    );
  }
}

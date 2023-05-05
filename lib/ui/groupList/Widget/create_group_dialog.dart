import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CreateGroupDialog extends StatefulHookConsumerWidget {
  @override
  CreateGroupDialogState createState() => CreateGroupDialogState();
}

class CreateGroupDialogState extends ConsumerState<CreateGroupDialog> {
  void initState() {
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(groupListViewModelProvider);
    return AlertDialog(
      title: const Text('グループ作成'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'グループ名',
                  ),
                  onChanged: provider.setGroupName,
                  initialValue: provider.groupName ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '説明',
                  ),
                  onChanged: provider.setDescription,
                  initialValue: provider.description ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'パスワード',
                  ),
                  onChanged: provider.setPass,
                  initialValue: provider.password ?? "",
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () async {
                      var image =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        var imageTemp = File(image.path);
                        provider.setGroupImage(imageTemp);
                      }
                    },
                    child: const Text('画像を選択'))
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: provider.groupName == null ||
                  provider.password == null ||
                  provider.groupName!.isEmpty ||
                  provider.password!.isEmpty
              ? null
              : () {
                  // グループ作成
                  provider.createGroup();
                  Navigator.pop(context);
                },
          child: const Text('作成'),
        ),
      ],
    );
  }
}

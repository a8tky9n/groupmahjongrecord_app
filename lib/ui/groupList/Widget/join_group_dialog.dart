import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/snackbar.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JoinGroupDialog extends StatefulHookConsumerWidget {
  @override
  JoinGroupDialogState createState() => JoinGroupDialogState();
}

class JoinGroupDialogState extends ConsumerState<JoinGroupDialog> {
  // メッセージ表示
  void showErrorMessage(String eMsg) {
    showErrorSnackbar(context: context, message: eMsg);
  }

  // プロフィール変更ダイアログ
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(groupListViewModelProvider);
    return AlertDialog(
      title: const Text('グループに参加'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              children: <Widget>[
                TextFormField(
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'グループID',
                  ),
                  onChanged: (value) => provider.setJoinGroupId(value),
                ),
                TextFormField(
                  enableInteractiveSelection: true,
                  initialValue: "",
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: 'パスワード',
                  ),
                  onChanged: (value) => provider.setJoinPassword(value),
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: provider.joinGroupID == null ||
                  provider.joinPassword == null ||
                  provider.joinGroupID!.isEmpty ||
                  provider.joinPassword!.isEmpty
              ? null
              : () {
                  // グループ作成
                  provider.joinGroup((String msg) {
                    showErrorSnackbar(context: context, message: msg);
                  });
                  Navigator.pop(context);
                },
          child: const Text('参加'),
        ),
      ],
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:groupmahjongrecord/ui/groupList/Widget/profile_edit_dialog.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupSideMenu extends StatefulHookConsumerWidget {
  @override
  GroupSideMenuState createState() => GroupSideMenuState();
}

class GroupSideMenuState extends ConsumerState<GroupSideMenu> {
  void initState() {
    super.initState();
    Future(() {
      final provider = ref.watch(groupViewModelProvider);
      provider.getLoginUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuStatus = ref.watch(groupViewModelProvider);
    final loginUser = sideMenuStatus.loginUser;
    final state = ref.watch(sceneTitleProvider);
    return SizedBox(
      width: 200,
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                loginUser == null ||
                        loginUser.nickName == null ||
                        loginUser.nickName!.isEmpty
                    ? 'ぷれいやー'
                    : loginUser.nickName!,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: GestureDetector(
                onTap: () => {ProfileEditDialog()},
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    loginUser == null ||
                            loginUser.image == null ||
                            loginUser.image!.isEmpty
                        ? "https://1.bp.blogspot.com/-TpkVjESR3SM/X6tmgytYOTI/AAAAAAABcMM/twe_dbteoPM0Gfr6dCRVNKmRLZ-TWWLhgCNcBGAsYHQ/s795/souji_table_fuku_schoolboy.png"
                        : loginUser.image!,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.grid_view),
              title: const Text(
                'グループリスト',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                ref
                    .read(sceneTitleProvider.notifier)
                    .update((state) => AppScene.groupList.name);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text(
                'ログアウト',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('ログアウトしますか？'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('いいえ'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(lastSceneProvider.notifier).state =
                            AppScene.groupList;
                        ref
                            .read(sceneTitleProvider.notifier)
                            .update((state) => AppScene.top.name);
                        sideMenuStatus.signOut();
                      },
                      child: const Text('はい'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
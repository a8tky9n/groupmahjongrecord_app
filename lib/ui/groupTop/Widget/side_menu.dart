import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:groupmahjongrecord/ui/groupList/Widget/profile_edit_dialog.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/group_top_profile_edit_dialog.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupSideMenu extends StatefulHookConsumerWidget {
  @override
  GroupSideMenuState createState() => GroupSideMenuState();
}

class GroupSideMenuState extends ConsumerState<GroupSideMenu> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = ref.watch(groupViewModelProvider);
      provider.getLoginUser(() => ref
          .read(sceneTitleProvider.notifier)
          .update((state) => AppScene.top.name));
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
                onTap: () {
                  sideMenuStatus.newProfileImage = null;
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          GroupTopProfileEditDialog());
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: loginUser != null &&
                          loginUser.image != null &&
                          loginUser.image!.isNotEmpty
                      ? NetworkImage(loginUser.image!) as ImageProvider<Object>
                      : AssetImage('assets/no_image_square.jpeg'),
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

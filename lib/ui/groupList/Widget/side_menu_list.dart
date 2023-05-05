import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:groupmahjongrecord/ui/groupList/Widget/profile_edit_dialog.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginSideMenu extends StatefulHookConsumerWidget {
  @override
  LoginSideMenuState createState() => LoginSideMenuState();
}

class LoginSideMenuState extends ConsumerState<LoginSideMenu> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuStatus = ref.watch(groupListViewModelProvider);
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
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: GestureDetector(
                onTap: () {
                  sideMenuStatus.newProfileImage = null;
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => ProfileEditDialog());
                },
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: loginUser != null &&
                            loginUser.image != null &&
                            loginUser.image!.isNotEmpty
                        ? NetworkImage(loginUser.image!)
                            as ImageProvider<Object>
                        : AssetImage('assets/no_image_square.jpeg')),
              ),
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
                        // Navigator.of(context).pushReplacementNamed("/");
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

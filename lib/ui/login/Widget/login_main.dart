import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/ui/login/Widget/forget_password_menu.dart';
import 'package:groupmahjongrecord/ui/login/login_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/ui/login/Widget/create_account_menu.dart';
import 'package:groupmahjongrecord/ui/login/Widget/login_menu.dart';

class LoginMain extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStatus =
        ref.watch(loginViewModelProvider.select((value) => value.loginStatus));
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          child: Image.asset(
            'assets/login/IMG_0016.png',
            fit: BoxFit.fitHeight,
            height: 530,
          ),
        ),
        Column(
          children: <Widget>[
            const Text(
              'グループ麻雀レコード',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.0,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 127, 127, 127),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'グループごとに麻雀の成績を管理',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 127, 127, 127),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Builder(builder: (_) {
              switch (loginStatus) {
                case 0:
                  return LoginMenu();
                case 1:
                  return CreateAccountMenu();
                case 2:
                  return ForgetPasswordMenu();
                default:
                  return LoginMenu();
              }
            }),
          ],
        ),
      ],
    );
  }
}

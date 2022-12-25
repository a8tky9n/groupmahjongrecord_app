import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/view/footer/Footer.dart';
import 'package:groupmahjongrecord/ui/login/Widget/login_main.dart';
import 'package:groupmahjongrecord/ui/login/Widget/abstruct_main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // ログイン部分
              LoginMain(),
              // 説明、使い方
              const SizedBox(height: 20),
              Abstruct(),
              const SizedBox(height: 20),
              // フッター
              const Footer(),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

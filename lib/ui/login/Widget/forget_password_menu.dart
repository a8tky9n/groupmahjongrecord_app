import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/snackbar.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/ui/login/login_viewmodel.dart';

class ForgetPasswordMenu extends StatefulHookConsumerWidget {
  @override
  ForgetPasswordMenuStatus createState() => ForgetPasswordMenuStatus();
}

class ForgetPasswordMenuStatus extends ConsumerState<ForgetPasswordMenu> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(loginViewModelProvider);
    final _formKey = GlobalKey<FormState>();
    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.passthrough,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: const Color.fromARGB(220, 255, 255, 255),
            height: 400,
            width: 350,
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'パスワードリセット',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 50.0, right: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        // controller: provider.email,
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        onChanged: provider.setEmail,
                        decoration: const InputDecoration(
                          hintText: 'email',
                          labelText: 'メールアドレス',
                        ),
                        validator: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'メールアドレスを入力してください。';
                          } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(val)) {
                            return 'メールアドレスの形式が不正です';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                child: const Text('送信'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  _formKey.currentState!.validate();
                  var provider = ref.read(loginViewModelProvider);
                  if (provider.email != null && provider.email!.isNotEmpty) {
                    // アカウント作成
                    // signOn(provider);
                  } else {
                    null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                final loginProv = ref.read(loginViewModelProvider);
                loginProv.setLoginStatus(0);
              },
              child: const Text('パスワードを思い出した方はこちら'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}

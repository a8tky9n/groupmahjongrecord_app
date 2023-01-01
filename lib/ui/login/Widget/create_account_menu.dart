import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/snackbar.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/ui/login/login_viewmodel.dart';

class CreateAccountMenu extends StatefulHookConsumerWidget {
  @override
  CreateAccountMenuState createState() => CreateAccountMenuState();
}

class CreateAccountMenuState extends ConsumerState<CreateAccountMenu> {
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
              'アカウント作成',
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
                        onChanged: provider.setEmail,
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'email',
                          labelText: 'メールアドレス',
                          errorStyle: TextStyle(
                            height: 0.5,
                          ),
                        ),

                        validator: (val) {
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
                    // パスワード
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        // controller: provider.password,
                        onChanged: provider.setPass,
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          labelText: 'パスワード',
                          errorStyle: TextStyle(
                            height: 0.5,
                          ),
                        ),
                        validator: (String? val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'パスワードを入力してください。';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        // controller: provider.confPassword,

                        onChanged: provider.setConfPass,
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          labelText: '確認のためもう一度パスワード入力',
                          errorStyle: TextStyle(
                            height: 0.5,
                          ),
                        ),
                        validator: (String? val) {
                          if (val!.isNotEmpty) {
                            if (val.contains(ref
                                    .read(loginViewModelProvider)
                                    .password!) &&
                                ref
                                        .read(loginViewModelProvider)
                                        .confPassword!
                                        .length ==
                                    ref
                                        .read(loginViewModelProvider)
                                        .password!
                                        .length) {
                              return null;
                            } else {
                              return '入力されたパスワードが一致しません。';
                            }
                          } else {
                            return 'パスワードを入力してください。';
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                child: const Text('アカウント作成'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  _formKey.currentState!.validate();
                  var provider = ref.read(loginViewModelProvider);
                  if (provider.email != null &&
                      provider.email!.isNotEmpty &&
                      provider.password != null &&
                      provider.password!.isNotEmpty &&
                      provider.confPassword != null &&
                      provider.confPassword!.isNotEmpty) {
                    // アカウント作成
                    signOn(provider);
                  } else {
                    null;
                  }
                },
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                final loginProv = ref.read(loginViewModelProvider);
                loginProv.setLoginStatus(0);
                // loginViewModelProvider.setLoginStatus(0);
              },
              child: const Text('アカウントをお持ちの方はこちら'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> signOn(LoginViewModel login) async {
    try {
      log("サインインするよ");
      await login.signOn(context, showErrorMessage);
      // サインイン確認
      await signOnComplete();
      log("サインインしたよ");
    } catch (e) {
      log("サインインできなかったよ" + e.toString());
    }
  }

  // サインオン完了
  Future<void> signOnComplete() async {
    final scene = ref.watch(sceneTitleProvider);
    final provider = ref.watch(loginViewModelProvider);
    if (provider.signInComplete()) {
      log("サインイン完了している");
      log("Firebaseの情報 " + provider.getUser().toString());
      await provider.registerId(() {
        log("登録完了");
        // 登録
        ref
            .read(sceneTitleProvider.notifier)
            .update((state) => AppScene.groupList.name);
      }, () {
        try {
          // 削除
          provider.getUser().delete();
          log("Delete User");
        } on NoSuchMethodError catch (e) {
          log(e.toString());
        }
      });
    } else {
      log("まだ完了していない");
    }
  }

  // メッセージ表示
  void showErrorMessage(String eMsg) {
    showErrorSnackbar(context: context, message: eMsg);
  }
}

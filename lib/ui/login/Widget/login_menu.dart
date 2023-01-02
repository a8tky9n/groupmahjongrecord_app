import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/snackbar.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/ui/login/login_viewmodel.dart';

class LoginMenu extends StatefulHookConsumerWidget {
  @override
  LoginMenuState createState() => LoginMenuState();
}

class LoginMenuState extends ConsumerState<LoginMenu> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future(
        () {
          final scene = ref.watch(sceneTitleProvider);
          final provider = ref.watch(loginViewModelProvider);
          if (provider.signInComplete()) {
            log("User" + provider.getUser().toString());
            final jwt = provider.getUser().getIdToken(true);
            jwt.then(
              (value) {
                log(value);
                final isRegistered = provider.isRegistered();
                isRegistered.then((val) {
                  if (val) {
                    ref
                        .read(sceneTitleProvider.notifier)
                        .update((state) => AppScene.groupList.name);
                  }
                });
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final provider = ref.watch(loginViewModelProvider);
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
              'ログイン',
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
                        onChanged: (val) {
                          provider.setEmail(val);
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'メールアドレスを入力してください';
                          } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(val)) {
                            return 'メールアドレスの形式が不正です';
                          } else {
                            return null;
                          }
                        },
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'email',
                          labelText: 'メールアドレス',
                        ),
                      ),
                    ),
                    // パスワード
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        onChanged: (val) {
                          provider.setPass(val);
                        },
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          labelText: 'パスワード',
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'パスワードを入力してください';
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
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                child: const Text('ログイン'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  _formKey.currentState!.validate();
                  final login = ref.read(loginViewModelProvider);
                  if (login.email != null &&
                      login.email!.isNotEmpty &&
                      login.password != null &&
                      login.password!.isNotEmpty) {
                    signin(login);
                  } else {
                    null;
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                final loginProv = ref.read(loginViewModelProvider);
                loginProv.setLoginStatus(1);
              },
              child: const Text('アカウントをお持ちでないですか？'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                final loginProv = ref.read(loginViewModelProvider);
                loginProv.setLoginStatus(2);
              },
              child: const Text('パスワードをお忘れですか？'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> signin(LoginViewModel login) async {
    try {
      log("サインインするよ");
      await login.signIn(context, showErrorMessage);
      // サインイン確認
      await signinComplete();
      log("サインインしたよ");
    } catch (e) {
      log("サインインできなかったよ" + e.toString());
    }
  }

  // サインイン完了
  Future<void> signinComplete() async {
    final scene = ref.watch(sceneTitleProvider);
    final provider = ref.watch(loginViewModelProvider);
    if (provider.signInComplete()) {
      log("ログイン完了している");
      log(provider.getUser().toString());
      final jwt = provider.getUser().getIdToken(true);
      jwt.then((value) {
        log(value);
        final isRegistered = provider.isRegistered();
        isRegistered.then((value) {
          if (value) {
            ref
                .read(sceneTitleProvider.notifier)
                .update((state) => AppScene.groupList.name);
          }
        });
      });
    }
  }

  // メッセージ表示
  void showErrorMessage(String eMsg) {
    showErrorSnackbar(context: context, message: eMsg);
  }
}

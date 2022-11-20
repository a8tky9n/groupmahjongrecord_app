import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Contact extends StatefulHookConsumerWidget {
  @override
  contactMainPage createState() => contactMainPage();
}

class contactMainPage extends ConsumerState<Contact> {
  @override
  void initState() {
    super.initState();
  }

  final snackBar = SnackBar(
    content: Text('送信!'),
  );
  final GlobalKey<FormState> _key = GlobalKey();
  bool _isValidateEmail = true;
  String _email = '';
  void _handleEmail(String m) {
    setState(() {
      _email = m;
    });
  }

  String _subject = '';
  void _handleSubject(String s) {
    setState(() {
      _subject = s;
    });
  }

  String _message = '';
  void _handleMessage(String ms) {
    setState(() {
      _message = ms;
    });
  }

  Widget _contact() {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          const Text(
            'お問い合わせ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 50.0, right: 50),
            child: Column(
              children: <Widget>[
                Container(
                  width: 330.0,
                  child: TextFormField(
                    enabled: true,
                    style: TextStyle(color: Colors.black),
                    obscureText: false,
                    maxLines: 1,
                    onChanged: _handleEmail,
                    decoration: const InputDecoration(
                      hintText: 'email',
                      labelText: 'メールアドレス',
                    ),
                    validator: (String? val) {
                      if (RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(val!)) {
                        _handleEmail(val);
                        return null;
                      } else {
                        _handleEmail('');
                        return 'メールアドレスの形式が不正です';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // パスワード
                Container(
                  width: 330.0,
                  child: TextFormField(
                    enabled: true,
                    style: TextStyle(color: Colors.black),
                    obscureText: false,
                    maxLines: 1,
                    onChanged: _handleSubject,
                    decoration: const InputDecoration(
                      hintText: 'subject',
                      labelText: '件名',
                    ),
                    validator: (String? val) {
                      if (val!.isNotEmpty) {
                        _handleSubject(val);
                        return null;
                      } else {
                        _handleSubject('');
                        return '件名は必須です。';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 330.0,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    enabled: true,
                    style: TextStyle(color: Colors.black),
                    obscureText: false,
                    maxLines: 7,
                    onChanged: _handleMessage,
                    decoration: const InputDecoration(
                      hintText: 'message',
                      label: Text('お問い合わせ内容'),
                      alignLabelWithHint: true, // テキスト上よせ
                    ),
                    validator: (String? val) {
                      if (val!.isNotEmpty) {
                        _handleMessage(val);
                        return null;
                      } else {
                        _handleMessage('');
                        return 'お問い合わせ内容は必須です。';
                      }
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                      child: const Text('送信'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        _key.currentState!.validate();
                        if (_email.isNotEmpty &&
                            _subject.isNotEmpty &&
                            _message.isNotEmpty) {
                          // フォームに送信
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: IconButton(
          onPressed: () {
            // ref
            //     .read(sceneTitleProvider.notifier)
            //     .update((state) => Scene.notice.name);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        // タイトルテキスト
        // title: Text('Hello'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            // crossAxisAlignment: CrossAxisAlignment.start,
            child: _contact(),
          ),
        ),
      ),
    );
  }
}

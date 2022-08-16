// ignore: file_names
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/view/footer/Footer.dart';
import 'package:groupmahjongrecord/configs/serverInfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => loginMainPage();
}

// ignore: camel_case_types
class loginMainPage extends State<LoginPage> with TickerProviderStateMixin {
  late List<Tab> _tabs;
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _tabs = [
      const Tab(
        child: Text(
          'What is',
        ),
      ),
      const Tab(
        child: Text(
          'How to use',
        ),
      )
    ];
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '';
  void _handleEmail(String m) {
    setState(() {
      _email = m;
    });
  }

  String _pass = '';
  void _handlePass(String p) {
    setState(() {
      _pass = p;
    });
  }

  String _confPass = '';
  void _handleConfPass(String p) {
    setState(() {
      _confPass = p;
    });
  }

  void _showCreateAccount() {
    setState(() {
      _loginMenu = 1;
    });
  }

  void _showForgetPassword() {
    setState(() {
      _loginMenu = 2;
    });
  }

  void _showLogIn() {
    setState(() {
      _loginMenu = 0;
    });
  }

  void _groupList() {
    _sendLogin();
  }

  int _loginMenu = 0;
  Widget _logInMain() {
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
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
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
                    // パスワード
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        maxLines: 1,
                        onChanged: _handlePass,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          labelText: 'パスワード',
                        ),
                        validator: (String? val) {
                          if (val!.isNotEmpty) {
                            _handlePass(val);
                            return null;
                          } else {
                            _handlePass('');
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
                child: const Text('ログイン'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: _email.isEmpty || _pass.isEmpty
                    ? null
                    : () {
                        _formKey.currentState!.validate();
                        if (_email.isNotEmpty && _pass.isNotEmpty) {
                          // ログイン
                          _groupList();
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
                _showCreateAccount();
              },
              child: const Text('アカウントをお持ちでないですか？'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                _showForgetPassword();
              },
              child: const Text('パスワードをお忘れですか？'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createAccountMain() {
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
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
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
                    // パスワード
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        maxLines: 1,
                        onChanged: _handlePass,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          labelText: 'パスワード',
                        ),
                        validator: (String? val) {
                          if (val!.isNotEmpty) {
                            _handlePass(val);
                            return null;
                          } else {
                            _handlePass('');
                            return 'パスワードを入力してください。';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        maxLines: 1,
                        onChanged: _handleConfPass,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          labelText: '確認のためもう一度パスワード入力',
                        ),
                        validator: (String? val) {
                          if (val!.isNotEmpty) {
                            _handleConfPass(val);
                            if (_confPass.contains(_pass) &&
                                _confPass.length == _pass.length) {
                              return null;
                            } else {
                              _handleConfPass('');
                              return '入力されたパスワードが一致しません。';
                            }
                          } else {
                            _handleConfPass('');
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
                onPressed: _email.isEmpty || _pass.isEmpty || _confPass.isEmpty
                    ? null
                    : () {
                        _formKey.currentState!.validate();
                        if (_email.isNotEmpty &&
                            _pass.isNotEmpty &&
                            _confPass.isNotEmpty) {
                          // アカウント作成
                          _createUid();
                        }
                      },
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                _showLogIn();
              },
              child: const Text('アカウントをお持ちの方はこちら'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _forgetPasswordMain() {
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
              'パスワード再設定',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              '登録したメールアドレスを入力してください。\nパスワード再設定用のURLをメールに送信します。',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.only(left: 50.0, right: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 330.0,
                      child: TextFormField(
                        enabled: true,
                        style: const TextStyle(color: Colors.black),
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
                    // パスワード
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
                onPressed: _email.isEmpty || _pass.isEmpty
                    ? null
                    : () {
                        _formKey.currentState!.validate();
                        if (_email.isNotEmpty && _pass.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('パスワード再発行')));
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
                _showLogIn();
              },
              child: const Text('パスワードを思い出した方はこちら'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }

  Widget _logIn() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          //decoration:
          //BoxDecoration(border: Border.all(color: Colors.blue, width: 5)),
          child: Image.asset(
            'assets/testimage-300x225.png',
            fit: BoxFit.none,
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
              switch (_loginMenu) {
                case 0:
                  return _logInMain();
                case 1:
                  return _createAccountMain();
                case 2:
                  return _forgetPasswordMain();
                default:
                  return _logIn();
              }
            }),
          ],
        ),
      ],
    );
  }

  int _selectedTabbar = 0;

  // 概要
  Widget _whatis() {
    return Container(
      color: const Color.fromARGB(255, 155, 212, 234),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: Column(
                children: const [
                  SizedBox(height: 18),
                  Text(
                    'グループ麻雀レコードとは',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'グループを作成してグループごとに麻雀の成績を管理することができます。',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'グループ数に上限はないため何個でもグループを作成、参加することができます。',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'そのためグループ内で誰が一番勝っているか一目瞭然！',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '麻雀の成績は累計、1日、1週間、と好きな区間で集計結果を表示できます。',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 使い方
  Widget _howtouse() {
    return Container(
      color: const Color.fromARGB(255, 155, 212, 234),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(width: double.infinity, height: 32),
          const Text(
            '使い方',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  '1. ログイン又はアカウントを作成します',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '2. グループを作成します',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '作成せずに友人などからの招待でグループに参加することも可能です。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  'グループは何個でも作成、参加できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/home.62c4063f.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  '麻雀の成績は累計、1日、1週間、と好きな区間で集計結果を表示できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '3. グループのホームに移動します',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'シェアボタンからグループをシェアできます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/grouphome.ecc8c5d2.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  'グループホームでの各機能紹介',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '3-1.対局',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '対局ボタンを押すことで対局画面へと移行します。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/battle.64b36da2.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  '対局者4人を選択します。この際選択順で東南西北が決定します。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '合計得点が100000点になるように入力することで記録できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  'ウマは5-10、10-20、10-30から選択します。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '3-2.メンバー',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/profiledetail.c7baf832.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  'グループに参加しているメンバーが表示されます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  'アイコンをクリックすることでメンバーごとの成績が表示できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '3-3.対局記録',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/recode.42fd27bf.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  '対局記録を表示します。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '日付を選択することで表示したい記録の区間を選択できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '日付を選択していない場合すべての累計が表示されます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/editrecode.59e0fc17.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  '対局記録を選択することで記録の編集・削除を行えます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '編集画面では得点の合計が0になるようにしてください。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '3-4.設定',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/setting.2d0603b3.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  '設定モーダルを開きます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '画像、名前、紹介文、パスワードを変更できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '名前、パスワードは30文字、紹介文は200文字まで設定できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  'グループを抜けるをクリックするとグループを抜けることができます。グループを抜けてもデータは残るので再度グループに参加することで引き続き記録できます。',
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  '4. ルールとマナーを守って楽しく対局しよう!!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/login/mahjong.b672d188.jpg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                const Text(
                  '※オカ(トップ賞)は+20です。',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                const Text(
                  '※レートの初期値は1500です。',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                const Text(
                  '※ヘッダーのユーザーアイコンでユーザー名等の変更が行えます。',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                const Text(
                  '※ヘッダーのユーザーアイコンからログアウトできます。',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 概要、使い方
  Widget _abstruct() {
    return Column(
      children: <Widget>[
        // タブ
        SizedBox(
          width: 330.0,
          child: TabBar(
            onTap: (index) {
              setState(() {
                _selectedTabbar = index;
              });
            },
            controller: _controller,
            tabs: _tabs,
            labelStyle: const TextStyle(
              fontSize: 18.0,
            ),
            labelColor: Colors.black,
          ),
        ),
        Builder(builder: (_) {
          if (_selectedTabbar == 0) {
            return _whatis(); //1st custom tabBarView
          } else {
            return _howtouse(); //2nd tabView
          }
        }),
      ],
    );
  }

  // ログイン
  Future<void> _sendLogin() async {
// メール/パスワードでログイン
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _pass,
      );
      // ログインに成功した場合
      final User user = result.user!;
      setState(() {
        Navigator.pushNamed(context, '/groupList');
      });
    } catch (e) {
      // ログインに失敗した場合
      setState(() {
        print('Request failed with status: ${e.toString()}.');
      });
    }

    // var url = Uri(scheme: 'https', host: 'reqres.in', path: '/api/login');
    // Map<String, String> headers = {'content-type': 'application/json'};
    // String body = json.encode({'email': _email, 'password': _pass});
    // var response = await http.post(url, headers: headers, body: body);
    // if (response.statusCode == 200) {
    //   // var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    //   // var itemCount = jsonResponse['totalItems'];
    //   // print('Number of books about http: $itemCount.');
    //   setState(() {
    //     Navigator.pushNamed(context, '/groupList');
    //   });
    // } else {
    //   // print('Request failed with status: ${response.statusCode}.');
    // }
  }

  // uidを作成
  Future<void> _createUid() async {
    try {
      // メール/パスワードでユーザー登録
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: _email,
        password: _pass,
      );
      // ログインに成功した場合
      final User user = result.user!;

      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('アカウント作成')));
        // サーバーにuidを登録する
        _registerUid(user.uid);
        print('Request failed with status: ${result.toString()}.');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        setState(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('パスワードを複雑にしてください。')));
        });
      } else if (e.code == 'email-already-in-use') {
        _getUid();
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // uidを取得
  Future<void> _getUid() async {
    try {
      // メール/パスワードでサインイン
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _pass,
      );
      // ログインに成功した場合
      final User user = result.user!;

      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('サインイン完了')));
        // サーバーにuidを登録する
        _registerUid(user.uid);
        user.getIdToken().then((String result) {
          print('JWT：' + result);
        });
        print('Request failed with status: ${result.toString()}.');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // uidを登録
  Future<void> _registerUid(String uid) async {
    try {
      print('サーバーにUidを登録する : ${uid}');
      var url = Uri(
        scheme: ServerInfo.protocol,
        host: ServerInfo.host,
        port: 8000,
        path: '/api/register',
      );
      String body = json.encode({'firebase_uid': uid, 'is_active': true});
      print('RequestBody : ${body}');
      var response = await http
          .post(url, body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        print('uid の登録完了');
        setState(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('ユーザーの登録が完了しました。')));
        });
        // setState(() {
        //   Navigator.pushNamed(context, '/groupList');
        // });
      } else {
        print('uidの登録失敗: ${response.body}');
      }
    } catch (e) {
      print('error: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // ログイン部分
              _logIn(),
              // 説明、使い方
              const SizedBox(height: 20),
              _abstruct(),
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

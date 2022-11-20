// ignore: file_names
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/view/footer/Footer.dart';
import 'package:groupmahjongrecord/ui/login/Widget/login_main.dart';
import 'package:groupmahjongrecord/ui/login/Widget/abstruct_main.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class LoginPage extends StatelessWidget {
  // @override
  // State<StatefulWidget> createState() => loginMainPage();
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

// ignore: camel_case_types
// class loginMainPage extends State<LoginPage> with TickerProviderStateMixin {
//   late List<Tab> _tabs;
//   late TabController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _tabs = [
//       const Tab(
//         child: Text(
//           'What is',
//         ),
//       ),
//       const Tab(
//         child: Text(
//           'How to use',
//         ),
//       )
//     ];
//     _controller = TabController(length: _tabs.length, vsync: this);
//     _autoLobing();
//   }

//   Future<void> _autoLobing() async {
//     print('get users info');
//     var url = Uri(
//         scheme: 'https',
//         host: 'reqres.in',
//         path: '/api/users',
//         queryParameters: {'page': '2'});
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var res = jsonDecode(response.body) as Map<String, dynamic>;
//       var itemCount = res['totalItems'];
//       var data = res['data'];
//       print('Number of books about http: $itemCount.');
//       setState(() {
//         for (var user in data) {
//           print(user);
//           // _user.add(
//           //   User(
//           //       userId: user['id'],
//           //       name: user['first_name'],
//           //       imagePath: user['avatar'],
//           //       introduction: '',
//           //       rate: 1500),
//           // );
//         }
//       });
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey();
//   String _email = '';
//   void _handleEmail(String m) {
//     setState(() {
//       _email = m;
//     });
//   }

//   String _pass = '';
//   void _handlePass(String p) {
//     setState(() {
//       _pass = p;
//     });
//   }

//   String _confPass = '';
//   void _handleConfPass(String p) {
//     setState(() {
//       _confPass = p;
//     });
//   }

//   void _showCreateAccount() {
//     setState(() {
//       _loginMenu = 1;
//     });
//   }

//   void _showForgetPassword() {
//     setState(() {
//       _loginMenu = 2;
//     });
//   }

//   void _showLogIn() {
//     setState(() {
//       _loginMenu = 0;
//     });
//   }

//   void _groupList() {
//     _sendLogin();
//   }

//   int _loginMenu = 0;
//   Widget _logInMain() {
//     return Stack(
//       alignment: AlignmentDirectional.center,
//       fit: StackFit.passthrough,
//       children: [
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             color: const Color.fromARGB(220, 255, 255, 255),
//             height: 400,
//             width: 350,
//           ),
//         ),
//         Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               'ログイン',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24.0,
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 50.0, right: 50),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       width: 330.0,
//                       child: TextFormField(
//                         enabled: true,
//                         style: const TextStyle(color: Colors.black),
//                         obscureText: false,
//                         maxLines: 1,
//                         onChanged: _handleEmail,
//                         decoration: const InputDecoration(
//                           hintText: 'email',
//                           labelText: 'メールアドレス',
//                         ),
//                         validator: (String? val) {
//                           if (RegExp(
//                                   r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                               .hasMatch(val!)) {
//                             _handleEmail(val);
//                             return null;
//                           } else {
//                             _handleEmail('');
//                             return 'メールアドレスの形式が不正です';
//                           }
//                         },
//                       ),
//                     ),
//                     // パスワード
//                     SizedBox(
//                       width: 330.0,
//                       child: TextFormField(
//                         enabled: true,
//                         style: const TextStyle(color: Colors.black),
//                         obscureText: true,
//                         maxLines: 1,
//                         onChanged: _handlePass,
//                         decoration: const InputDecoration(
//                           hintText: 'password',
//                           labelText: 'パスワード',
//                         ),
//                         validator: (String? val) {
//                           if (val!.isNotEmpty) {
//                             _handlePass(val);
//                             return null;
//                           } else {
//                             _handlePass('');
//                             return 'パスワードを入力してください。';
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: ElevatedButton(
//                 child: const Text('ログイン'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.orange,
//                   onPrimary: Colors.white,
//                 ),
//                 onPressed: _email.isEmpty || _pass.isEmpty
//                     ? null
//                     : () {
//                         _formKey.currentState!.validate();
//                         if (_email.isNotEmpty && _pass.isNotEmpty) {
//                           // ログイン
//                           _groupList();
//                         }
//                       },
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: const TextStyle(fontSize: 15),
//               ),
//               onPressed: () {
//                 _showCreateAccount();
//               },
//               child: const Text('アカウントをお持ちでないですか？'),
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: const TextStyle(fontSize: 15),
//               ),
//               onPressed: () {
//                 _showForgetPassword();
//               },
//               child: const Text('パスワードをお忘れですか？'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _createAccountMain() {
//     return Stack(
//       alignment: AlignmentDirectional.center,
//       fit: StackFit.passthrough,
//       children: [
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             color: const Color.fromARGB(220, 255, 255, 255),
//             height: 400,
//             width: 350,
//           ),
//         ),
//         Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               'アカウント作成',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24.0,
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 50.0, right: 50),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       width: 330.0,
//                       child: TextFormField(
//                         enabled: true,
//                         style: const TextStyle(color: Colors.black),
//                         obscureText: false,
//                         maxLines: 1,
//                         onChanged: _handleEmail,
//                         decoration: const InputDecoration(
//                           hintText: 'email',
//                           labelText: 'メールアドレス',
//                         ),
//                         validator: (String? val) {
//                           if (RegExp(
//                                   r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                               .hasMatch(val!)) {
//                             _handleEmail(val);
//                             return null;
//                           } else {
//                             _handleEmail('');
//                             return 'メールアドレスの形式が不正です';
//                           }
//                         },
//                       ),
//                     ),
//                     // パスワード
//                     SizedBox(
//                       width: 330.0,
//                       child: TextFormField(
//                         enabled: true,
//                         style: const TextStyle(color: Colors.black),
//                         obscureText: true,
//                         maxLines: 1,
//                         onChanged: _handlePass,
//                         decoration: const InputDecoration(
//                           hintText: 'password',
//                           labelText: 'パスワード',
//                         ),
//                         validator: (String? val) {
//                           if (val!.isNotEmpty) {
//                             _handlePass(val);
//                             return null;
//                           } else {
//                             _handlePass('');
//                             return 'パスワードを入力してください。';
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 330.0,
//                       child: TextFormField(
//                         enabled: true,
//                         style: const TextStyle(color: Colors.black),
//                         obscureText: true,
//                         maxLines: 1,
//                         onChanged: _handleConfPass,
//                         decoration: const InputDecoration(
//                           hintText: 'password',
//                           labelText: '確認のためもう一度パスワード入力',
//                         ),
//                         validator: (String? val) {
//                           if (val!.isNotEmpty) {
//                             _handleConfPass(val);
//                             if (_confPass.contains(_pass) &&
//                                 _confPass.length == _pass.length) {
//                               return null;
//                             } else {
//                               _handleConfPass('');
//                               return '入力されたパスワードが一致しません。';
//                             }
//                           } else {
//                             _handleConfPass('');
//                             return 'パスワードを入力してください。';
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: ElevatedButton(
//                 child: const Text('アカウント作成'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.orange,
//                   onPrimary: Colors.white,
//                 ),
//                 onPressed: _email.isEmpty || _pass.isEmpty || _confPass.isEmpty
//                     ? null
//                     : () {
//                         _formKey.currentState!.validate();
//                         if (_email.isNotEmpty &&
//                             _pass.isNotEmpty &&
//                             _confPass.isNotEmpty) {
//                           // アカウント作成
//                           _createUid();
//                         }
//                       },
//               ),
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: const TextStyle(fontSize: 15),
//               ),
//               onPressed: () {
//                 _showLogIn();
//               },
//               child: const Text('アカウントをお持ちの方はこちら'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _forgetPasswordMain() {
//     return Stack(
//       alignment: AlignmentDirectional.center,
//       fit: StackFit.passthrough,
//       children: [
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             color: const Color.fromARGB(220, 255, 255, 255),
//             height: 400,
//             width: 350,
//           ),
//         ),
//         Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               'パスワード再設定',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24.0,
//               ),
//             ),
//             const SizedBox(height: 15),
//             const Text(
//               '登録したメールアドレスを入力してください。\nパスワード再設定用のURLをメールに送信します。',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 12.0,
//               ),
//             ),
//             const SizedBox(height: 25),
//             Container(
//               padding: const EdgeInsets.only(left: 50.0, right: 50),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       width: 330.0,
//                       child: TextFormField(
//                         enabled: true,
//                         style: const TextStyle(color: Colors.black),
//                         obscureText: false,
//                         maxLines: 1,
//                         onChanged: _handleEmail,
//                         decoration: const InputDecoration(
//                           hintText: 'email',
//                           labelText: 'メールアドレス',
//                         ),
//                         validator: (String? val) {
//                           if (RegExp(
//                                   r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                               .hasMatch(val!)) {
//                             _handleEmail(val);
//                             return null;
//                           } else {
//                             _handleEmail('');
//                             return 'メールアドレスの形式が不正です';
//                           }
//                         },
//                       ),
//                     ),
//                     // パスワード
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Container(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: ElevatedButton(
//                 child: const Text('送信'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.orange,
//                   onPrimary: Colors.white,
//                 ),
//                 onPressed: _email.isEmpty || _pass.isEmpty
//                     ? null
//                     : () {
//                         _formKey.currentState!.validate();
//                         if (_email.isNotEmpty && _pass.isNotEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('パスワード再発行')));
//                         }
//                       },
//               ),
//             ),
//             const SizedBox(height: 15),
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: const TextStyle(fontSize: 15),
//               ),
//               onPressed: () {
//                 _showLogIn();
//               },
//               child: const Text('パスワードを思い出した方はこちら'),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _logIn() {
//     return Stack(
//       alignment: AlignmentDirectional.center,
//       children: <Widget>[
//         SizedBox(
//           //decoration:
//           //BoxDecoration(border: Border.all(color: Colors.blue, width: 5)),
//           child: Image.asset(
//             'assets/testimage-300x225.png',
//             fit: BoxFit.none,
//             height: 530,
//           ),
//         ),
//         Column(
//           children: <Widget>[
//             const Text(
//               'グループ麻雀レコード',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 35.0,
//                 shadows: <Shadow>[
//                   Shadow(
//                     offset: Offset(1.0, 1.0),
//                     blurRadius: 3.0,
//                     color: Color.fromARGB(255, 127, 127, 127),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Text(
//               'グループごとに麻雀の成績を管理',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18.0,
//                 shadows: <Shadow>[
//                   Shadow(
//                     offset: Offset(1.0, 1.0),
//                     blurRadius: 3.0,
//                     color: Color.fromARGB(255, 127, 127, 127),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Builder(builder: (_) {
//               switch (_loginMenu) {
//                 case 0:
//                   return _logInMain();
//                 case 1:
//                   return _createAccountMain();
//                 case 2:
//                   return _forgetPasswordMain();
//                 default:
//                   return _logIn();
//               }
//             }),
//           ],
//         ),
//       ],
//     );
//   }

//   int _selectedTabbar = 0;

//   // ログイン
//   Future<void> _sendLogin() async {
// // メール/パスワードでログイン
//     try {
//       final FirebaseAuth auth = FirebaseAuth.instance;
//       final UserCredential result = await auth.signInWithEmailAndPassword(
//         email: _email,
//         password: _pass,
//       );
//       // ログインに成功した場合
//       final User user = result.user!;
//       user.getIdToken().then((String result) {
//         print('JWT：' + result);
//       });
//       setState(() {
//         Navigator.pushNamed(context, '/groupList');
//       });
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'invalid-email') {
//         setState(() {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('無効なメールアドレスです。')));
//         });
//       } else if (e.code == 'wrong-password') {
//         setState(() {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('パスワードが違います。')));
//         });
//       } else if (e.code == 'user-not-found') {
//         setState(() {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('アカウントが見つかりませんでした。')));
//         });
//       } else if (e.code == 'user-disabled') {
//         setState(() {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('このユーザーは削除されています。')));
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   // uidを作成
//   Future<void> _createUid() async {
//     try {
//       // メール/パスワードでユーザー登録
//       final FirebaseAuth auth = FirebaseAuth.instance;
//       final UserCredential result = await auth.createUserWithEmailAndPassword(
//         email: _email,
//         password: _pass,
//       );
//       // ログインに成功した場合
//       final User user = result.user!;

//       setState(() {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('アカウント作成')));
//         // サーバーにuidを登録する
//         _registerUid(user.uid);
//         print('Request failed with status: ${result.toString()}.');
//       });
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//         setState(() {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('パスワードを複雑にしてください。')));
//         });
//       } else if (e.code == 'email-already-in-use') {
//         _getUid();
//         setState(() {
//           ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('メールアドレスは既に登録されています。')));
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   // uidを取得
//   Future<void> _getUid() async {
//     try {
//       // メール/パスワードでサインイン
//       final FirebaseAuth auth = FirebaseAuth.instance;
//       final UserCredential result = await auth.signInWithEmailAndPassword(
//         email: _email,
//         password: _pass,
//       );
//       // ログインに成功した場合
//       final User user = result.user!;
//       user.getIdToken().then((String result) {
//         print('JWT：' + result);
//       });

//       setState(() {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('サインイン完了')));
//         // サーバーにuidを登録する
//         _registerUid(user.uid);
//       });
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }

//   // uidを登録
//   Future<void> _registerUid(String uid) async {
//     try {
//       print('サーバーにUidを登録する : ${uid}');
//       var url = Uri(
//         scheme: ServerInfo.protocol,
//         host: ServerInfo.host,
//         port: 8000,
//         path: '/api/register',
//       );
//       String body = json.encode({'firebase_uid': uid, 'is_active': true});
//       print('RequestBody : ${body}');
//       var response = await http
//           .post(url, body: body, headers: {"Content-Type": "application/json"});
//       if (response.statusCode == 200) {
//         print('uid の登録完了');
//         setState(() {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('ユーザーの登録が完了しました。')));
//         });
//       } else {
//         print('uidの登録失敗: ${response.body}');
//       }
//     } catch (e) {
//       print('error: ${e}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               // ログイン部分
//               _logIn(),
//               // 説明、使い方
//               const SizedBox(height: 20),
//               _abstruct(),
//               const SizedBox(height: 20),
//               // フッター
//               const Footer(),
//               const SizedBox(height: 5),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

}

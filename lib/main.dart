import 'package:flutter/material.dart';
import 'view/Login.dart';
import 'view/Legalnotice.dart';
import 'view/Contact.dart';
import 'view/GroupList.dart';
import 'view/groupview/GroupTop.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// エントリーポイント
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        // 初期画面のclassを指定
        '/': (context) => LoginPage(),
        // 次ページのclassを指定
        '/legalnotice': (context) => const Legalnotice(),
        '/contact': (context) => Contact(),
        '/groupList': (context) => GroupList(),
      },
    );
  }
}

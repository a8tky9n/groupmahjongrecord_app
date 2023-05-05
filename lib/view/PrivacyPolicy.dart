import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://firebase.google.com/support/privacy');

class PrivacyPolicy extends ConsumerWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);
  Widget _PrivacyPolicy() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      fit: StackFit.passthrough,
      children: [
        Column(
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              'プライバシーポリシー',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    'このアプリはFirebase Authenticationを使用して、ユーザーがログインするために必要な情報を収集します。収集される情報には、以下のものが含まれます。',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '・ ユーザーの電子メールアドレス',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '・ ユーザーのパスワード',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'これらの情報は、アプリのログイン機能を提供するために使用されます。ユーザーは、自分のアカウント情報を入力することでログインすることができます。',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'このアプリは、ログインに必要な情報以外の個人情報を収集しません。また、収集された情報は第三者に提供されることはありません。',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Firebase Authenticationには、ユーザーの認証情報を保護するためのセキュリティ機能があります。これには、暗号化されたパスワードの保存や、多要素認証の有効化などが含まれます。',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'このアプリは、Firebaseのプライバシーポリシーに従います。Firebaseのプライバシーポリシーについては、以下のリンクから確認することができます。',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _launchUrl,
                      child: const Text(
                        'Firebaseのプライバシーポリシー',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: IconButton(
          onPressed: () {
            ref
                .read(sceneTitleProvider.notifier)
                .update((state) => ref.watch(lastSceneProvider).name);
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
            child: _PrivacyPolicy(),
          ),
        ),
      ),
    );
  }
}

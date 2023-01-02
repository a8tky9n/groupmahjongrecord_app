import 'package:flutter/material.dart';

class Abstruct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AbstructPage();
}

class AbstructPage extends State<Abstruct> with TickerProviderStateMixin {
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

  int _selectedTabbar = 0;

  @override
  Widget build(BuildContext context) {
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

  // 説明
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
                  'ウマは無し、5-10、10-20から選択します。',
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
}

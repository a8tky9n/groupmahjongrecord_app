import 'dart:ffi';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/view/footer/Footer.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:groupmahjongrecord/Group.dart';
import 'package:groupmahjongrecord/User.dart';
import 'package:groupmahjongrecord/Score.dart';

class GroupTop extends StatefulWidget {
  final Group group;
  final User user;
  const GroupTop({
    Key? key,
    required this.group,
    required this.user,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => groupTopPage();
}

class groupTopPage extends State<GroupTop> {
  @override
  void initState() {
    super.initState();
    _getScoreList();
  }

  final ImagePicker _picker = ImagePicker();
  File? _grupeFile;
  File? _profileFile;

  var _scores = <Score>{};
  bool _isLoading = true;
  int _selectedIndex = 0;

  Future<void> _getScoreList() async {
    User user = widget.user;
    print('get user info');
    var url = Uri(scheme: 'https', host: 'reqres.in', path: '/api/users/2');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = res['totalItems'];
      print('Number of books about http: $itemCount.');
      setState(() {
        _isLoading = false;
        for (var i = 0; i < 7; i++) {
          _scores.add(Score(
              scoreId: 1,
              createDate: DateTime.now(),
              points: [31, 3, -13, -21],
              users: [user, user, user, user, user]));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // プロフィール変更ダイアログ
  void _profileEditDialog(User user) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('プロフィールを編集'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Column(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      var image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        // what you get if you cancel
                        setState(() {
                          _profileFile = image as File?;
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        user.imagePath,
                      ),
                      radius: 40,
                    ),
                  ),
                  TextFormField(
                    initialValue: user.name,
                    decoration: const InputDecoration(
                      labelText: '名前',
                    ),
                  ),
                  TextFormField(
                    initialValue: user.introduction,
                    decoration: const InputDecoration(
                      labelText: '自己紹介',
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('プロフィール更新'),
          ),
        ],
      ),
    );
  }

  Widget _sideMenu() {
    var _user = widget.user;
    return SizedBox(
      width: 200,
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                _user.name,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: GestureDetector(
                onTap: () => {_profileEditDialog(_user)},
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    _user.imagePath,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.grid_view),
              title: const Text(
                'グループリスト',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushReplacementNamed("/groupList");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text(
                'ログアウト',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('ログアウトしますか？'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('いいえ'),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushReplacementNamed("/"),
                      child: const Text('はい'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topImage() {
    var group = widget.group;
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          group.name,
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Ink.image(
          image: NetworkImage(
            group.imagePath,
          ),
          height: 240,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          group.introduction,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 300,
          // 内側の余白（パディング）
          // padding: EdgeInsets.all(8),
          // 外側の余白（マージン）
          // margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/icon/f_logo_RGB-Blue_1024.png',
                  width: 45,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/icon/Twitter social icons - rounded square - blue.png',
                  width: 45,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/icon/LINE_APP_iOS.png',
                  width: 45,
                ),
              ),
              Ink(
                child: IconButton(
                  icon: Icon(Icons.mail_rounded),
                  iconSize: 45,
                  splashRadius: 30,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _recentScore() {
    var user = widget.user;
    return Column(
      children: <Widget>[
        const Text(
          "直近の対戦記録",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  '日付',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '1位',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '2位',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '3位',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '4位',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
              )
            ],
          ),
        ),
        const Divider(),
        for (var score in _scores) _scoreListItem(score),
      ],
    );
  }

  Widget _scoreListItem(Score score) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                DateFormat('yyyy-M-d').format(score.createDate),
                textAlign: TextAlign.center,
              )),
          Expanded(flex: 1, child: _scoreItem(score.points[0], "あいうえおか")),
          Expanded(
              flex: 1, child: _scoreItem(score.points[1], score.users[0].name)),
          Expanded(
              flex: 1, child: _scoreItem(score.points[2], score.users[0].name)),
          Expanded(
              flex: 1, child: _scoreItem(score.points[3], score.users[0].name)),
          const Divider(),
        ],
      ),
    );
  }

  Widget _scoreItem(int score, String name) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            score.toStringAsFixed(1),
            style: TextStyle(color: score < 0 ? Colors.red : Colors.blue),
          ),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12.0),
            strutStyle: StrutStyle(
              fontSize: 12.0,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'グループTop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: '対局開始',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'メンバー',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          label: '対局記録',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _main() {
    switch (_selectedIndex) {
      case 0: //グループトップ
        return Column(
          children: <Widget>[
            _topImage(),
            _isLoading
                ? Column(children: const <Widget>[
                    SizedBox(
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    )
                  ])
                : _recentScore(),
          ],
        );
      case 1: // 対局開始
        return Text(
          "対局者を選択",
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        );
      case 2: // メンバー
        return Text(
          "グループメンバー",
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        );
      case 3: // 対局記録
        return Text(
          "対局記録",
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        );
      default:
        return Column(
          children: <Widget>[
            _topImage(),
            _isLoading
                ? Column(children: const <Widget>[
                    SizedBox(
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    )
                  ])
                : _recentScore(),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var group = widget.group;
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      drawer: _sideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              // crossAxisAlignment: CrossAxisAlignment.start,
              _main(),
              Footer(),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }
}

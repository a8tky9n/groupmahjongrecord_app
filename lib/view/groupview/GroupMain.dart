import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:groupmahjongrecord/view/footer/Footer.dart';
import 'package:groupmahjongrecord/models/Group.dart';
import 'package:groupmahjongrecord/models/User.dart';
import 'package:groupmahjongrecord/view/groupview/GroupTop.dart';
import 'package:groupmahjongrecord/view/groupview/GroupScore.dart';
import 'package:groupmahjongrecord/view/groupview/GroupMember.dart';
import 'package:groupmahjongrecord/view/groupview/RecordScore.dart';

class GroupMain extends StatefulWidget {
  final Group group;
  final User user;
  const GroupMain({
    Key? key,
    required this.group,
    required this.user,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => groupMainPage();
}

class groupMainPage extends State<GroupMain> {
  final ImagePicker _picker = ImagePicker();
  File? _grupeFile;
  File? _profileFile;
  int _selectedIndex = 0;

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

  Widget _mainContent() {
    var group = widget.group;
    var user = widget.user;
    switch (_selectedIndex) {
      case 0:
        return GroupTop(
          group: group,
          user: user,
        );
      case 1:
        return RecordScore(
          group: group,
          user: user,
        );
      case 2:
        return GroupMember(
          group: group,
          user: user,
        );
      case 3:
        return GroupScore(
          group: group,
          user: user,
        );
      default:
        return GroupTop(
          group: group,
          user: user,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _mainContent(),
              const Footer(),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }
}

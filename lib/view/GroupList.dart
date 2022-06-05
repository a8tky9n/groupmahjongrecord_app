import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:groupmahjongrecord/Group.dart';
import 'package:groupmahjongrecord/view/footer/Footer.dart';
import 'package:groupmahjongrecord/view/groupview/GroupMain.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:groupmahjongrecord/User.dart';

class GroupList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => contactMainPage();
}

class contactMainPage extends State<GroupList> with TickerProviderStateMixin {
  // ユーザー情報
  var _user;
  // グループ情報
  var _groups = <Group>{};
  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _getGroupList();
  }

  final ImagePicker _picker = ImagePicker();
  File? _grupeFile;
  File? _profileFile;
  Widget _groupList() {
    return GridView.count(
      // primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      // return Column(
      children: <Widget>[
        if (_groups.isNotEmpty)
          for (var group in _groups)
            buildImageCard(group.imagePath, group.name, group.groupId),
      ],
    );
  }

  Future<void> _getUserInfo() async {
    print('get user info');
    var url = Uri(scheme: 'https', host: 'reqres.in', path: '/api/users/2');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = res['totalItems'];
      print('Number of books about http: $itemCount.');
      setState(() {
        _user = User(
            userId: res['data']['id'],
            name: res['data']['first_name'],
            imagePath: res['data']['avatar'],
            introduction: '',
            passWord: '');
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _getGroupList() async {
    print('get group list');
    var url = Uri(
        scheme: 'https',
        host: 'reqres.in',
        path: '/api/users',
        queryParameters: {'page': '2'});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = res['total'];
      var data = res['data'];
      print('Number of books about http: $itemCount.');
      setState(() {
        for (var group in data) {
          print(group);
          _groups.add(Group(
              groupId: group['id'],
              name: group['first_name'],
              imagePath: group['avatar'],
              introduction: "",
              passWord: ""));
        }
        // data.forEach(group){
        //   _groups.add(new Group(
        //       id: group.id,
        //       name: group.first_name,
        //       imagePath: group.avatar,
        //       introduction: "",
        //       passWord: ""));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // プロフィール変更ダイアログ
  void _profileEditDialog() {
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
                        _user.imagePath,
                      ),
                      radius: 40,
                    ),
                  ),
                  TextFormField(
                    initialValue: _user.name,
                    decoration: const InputDecoration(
                      labelText: '名前',
                    ),
                  ),
                  TextFormField(
                    initialValue: _user.introduction,
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
    return SizedBox(
      width: 200,
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                _user?.name ?? '',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: GestureDetector(
                onTap: () => {_profileEditDialog()},
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    _user?.imagePath ??
                        "https://1.bp.blogspot.com/-TpkVjESR3SM/X6tmgytYOTI/AAAAAAABcMM/twe_dbteoPM0Gfr6dCRVNKmRLZ-TWWLhgCNcBGAsYHQ/s795/souji_table_fuku_schoolboy.png",
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
                Navigator.pop(context);
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

  // グループカード
  Widget buildImageCard(String imageUrl, String title, int id) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            var group = Group(
                groupId: id,
                name: title,
                imagePath: imageUrl,
                introduction: "ケチな点棒拾う気なし・・・！",
                passWord: "");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GroupMain(
                  group: group,
                  user: _user,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      drawer: _sideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            // crossAxisAlignment: CrossAxisAlignment.start,
            _groupList(),
            const Footer(),
            const SizedBox(
              height: 60,
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('グループ作成'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'グループ名',
                                ),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: '説明',
                                ),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'パスワード',
                                ),
                              ),
                              SizedBox(height: 20),
                              OutlinedButton(
                                  onPressed: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    var image = await _picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      // what you get if you cancel
                                      setState(() {
                                        _grupeFile = image as File?;
                                      });
                                    }
                                  },
                                  child: const Text('画像を選択'))
                            ],
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('作成'),
                      ),
                    ],
                  ))
        },
        icon: Icon(Icons.group_add),
        label: const Text("新規グループを作成"),
      ),
    );
  }
}

import 'package:groupmahjongrecord/components/ScoreHeader.dart';
import 'package:groupmahjongrecord/components/ScoreRow.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

// グループトップ画面
class GroupTopMain extends ConsumerStatefulWidget {
  const GroupTopMain({Key? key}) : super(key: key);

  @override
  GroupTopMainState createState() => GroupTopMainState();
}

class GroupTopMainState extends ConsumerState<GroupTopMain> {
  @override
  void initState() {
    super.initState();
  }

  // サーバーから成績を取ってくる

  // グループのトップ画
  Widget _topImage() {
    final provider = ref.watch(groupViewModelProvider);
    var group = provider.groupDetail;
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          group == null ? "グループ名" : group.title!,
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 240,
          child: group == null || group.image == null || group.image!.isEmpty
              ? Image.asset(
                  'assets/no_image_square.jpeg',
                  fit: BoxFit.fitWidth,
                )
              : Image.network(
                  group.image!,
                  fit: BoxFit.contain,
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          group == null || group.text == null ? "" : group.text!,
          style: const TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
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
                  icon: const Icon(Icons.mail_rounded),
                  iconSize: 45,
                  splashRadius: 30,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // 直近の成績
  Widget _recentScore() {
    var games = ref.watch(groupViewModelProvider).games;
    return Column(
      children: <Widget>[
        const Text(
          "直近の対戦記録",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        games == null || games.isEmpty ? _scoreIsEmpty() : scoreIsNotEmpty(),
      ],
    );
  }

  // 結果がない時
  Widget _scoreIsEmpty() {
    return Column(
      children: const <Widget>[
        SizedBox(height: 15),
        Text(
          "対局記録はありません",
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // 結果がある時
  Widget scoreIsNotEmpty() {
    var games = ref.watch(groupViewModelProvider).games;
    return Column(
      children: <Widget>[
        const ScoreHeader(),
        const Divider(),
        for (int i = 0; i < (games!.length < 7 ? games.length : 7); i++)
          // for (var score in game.gameResults!)
          ScoreRow(
            scores: games[i].gameResults!,
            OnTapCallback: () => {},
          ),
      ],
    );
  }

  Widget _main() {
    //グループトップ
    return Column(
      children: <Widget>[
        _topImage(),
        _recentScore(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(groupViewModelProvider).groupDetail == null
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
        : _main();
  }
}
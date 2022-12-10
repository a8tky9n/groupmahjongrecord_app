import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/create_game_dialog.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/member_list.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecordScore extends ConsumerStatefulWidget {
  @override
  RecordScoreState createState() => RecordScoreState();
}

class RecordScoreState extends ConsumerState<RecordScore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var groupViewModel = ref.watch(groupViewModelProvider);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("対局者を選択",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "東→南→西→北の席順で選択してください。",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        const SizedBox(
          height: 10,
        ),
        MemberList(),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          child: const Text('対局開始'),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
          ),
          onPressed: groupViewModel.positions.isNotEmpty
              ? null
              : () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => CreateGameDialog());
                },
        ),
      ],
    );
  }
}

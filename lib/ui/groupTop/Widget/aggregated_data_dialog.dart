import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class AggregatedDataDialog extends StatefulHookConsumerWidget {
  @override
  AggregatedDataDialogState createState() => AggregatedDataDialogState();
}

class AggregatedDataDialogState extends ConsumerState<AggregatedDataDialog> {
  void initState() {
    super.initState();
  }

  int _groupValue = -1;
  Widget _userRow(String userName, double score) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            // child: Center(
            child: Text(userName),
            // ),
          ),
          SizedBox(
            width: 100,
            // child: Center(
            child: Text(
              (score * ref.watch(groupViewModelProvider).aggregatedRate)
                  .toStringAsFixed(0),
              textAlign: TextAlign.right,
              style: TextStyle(color: score < 0 ? Colors.red : Colors.blue),
            ),
            // ),
          ),
        ],
      ),
      const Divider(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(groupViewModelProvider);
    return AlertDialog(
      title: const Text('集計結果'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "1/2黒川",
                    ),
                    Radio(
                      activeColor: Colors.blue,
                      value: 50,
                      groupValue: provider.aggregatedRate,
                      onChanged: (value) =>
                          provider.setAggregatedRate(value as int),
                      autofocus: true,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "黒川",
                    ),
                    Radio(
                      activeColor: Colors.blue,
                      value: 100,
                      groupValue: provider.aggregatedRate,
                      onChanged: (value) =>
                          provider.setAggregatedRate(value as int),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < provider.playerDetailScores.length; i++)
                  _userRow(
                      provider.players!
                              .firstWhere((element) =>
                                  element.user.id! ==
                                  provider.playerDetailScores[i].id!)
                              .user
                              .nickName ??
                          'プレイヤー',
                      provider.playerDetailScores[i].totalScore!),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}

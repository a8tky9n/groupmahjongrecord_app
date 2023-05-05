import 'package:flutter/services.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class EditGameDialog extends StatefulHookConsumerWidget {
  @override
  EditGameDialogState createState() => EditGameDialogState();
}

class EditGameDialogState extends ConsumerState<EditGameDialog> {
  void initState() {
    super.initState();
  }

  List<String> posText = ["1着", "2着", "3着", "4着"];
  Widget _player(int pos) {
    var provider = ref.watch(groupViewModelProvider);
    var game = provider.updateGame!;
    var results = game.gameResults;
    var player = provider.players!
        .firstWhere((p) => p.user.id == results![pos - 1].profile);
    // var player = players.firstWhere((p) => p.position == pos);
    return Row(
      children: [
        SizedBox(
          height: 50,
          child: Center(
            child: Text(posText[pos - 1]),
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: player.user.image == null || player.user.image!.isEmpty
                ? Image.asset('assets/no_image_square.jpeg',
                    fit: BoxFit.contain)
                : Image.network(
                    player.user.image!,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 70,
          child: Center(
            child: Text(
              player.user.nickName ?? "プレイヤー",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 80,
          child: TextFormField(
            initialValue: results![pos - 1].score.toString(),
            decoration: const InputDecoration(
              hintText: '0.0',
              hintStyle: const TextStyle(fontSize: 12),
            ),
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('-?[0-9]*[\.]?[0-9]?'))
            ],
            onChanged: ((value) => {
                  if (value != "-")
                    provider.setScore(pos - 1, double.parse(value))
                }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(groupViewModelProvider);
    final game = provider.updateGame!;
    return AlertDialog(
      title: const Text('対局記録'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'yyyy/MM/d',
                    initialValue: game.createdAt.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    locale: const Locale('ja', 'JP'),
                    dateLabelText: 'Date',
                    timeLabelText: 'Time',
                    selectableDayPredicate: (date) {
                      return true;
                    },
                    onChanged: (val) => ref
                        .watch(groupViewModelProvider)
                        .setRecordDateTime(DateTime.parse(val)),
                    validator: (val) {
                      // print(val);
                      return null;
                    },
                    onSaved: (val) => {
                      ref
                          .watch(groupViewModelProvider)
                          .setRecordDateTime(DateTime.parse(val!))
                    },
                  ),
                ),
                for (int i = 0; i < 4; i++) _player(i + 1),
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
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: provider.scoreIsValid
              ? null
              : () {
                  // グループ作成
                  provider.editGame();
                  Navigator.pop(context);
                },
          child: const Text('保存'),
        ),
      ],
    );
  }
}

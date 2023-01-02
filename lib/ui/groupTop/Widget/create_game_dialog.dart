import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class CreateGameDialog extends StatefulHookConsumerWidget {
  @override
  CreateGameDialogState createState() => CreateGameDialogState();
}

class CreateGameDialogState extends ConsumerState<CreateGameDialog> {
  void initState() {
    super.initState();
  }

  List<String> posText = ["東", "南", "西", "北"];
  Widget _player(int pos) {
    var provider = ref.watch(groupViewModelProvider);
    var players = provider.players!;
    var player = players.firstWhere((p) => p.position == pos);
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
          width: 90,
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: '0.0',
              hintStyle: const TextStyle(fontSize: 12),
            ),

            keyboardType: TextInputType.number,
            // keyboardType: TextInputType.numberWithOptions(decimal: true),
            // inputFormatters: [
            //   FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)')),
            // ],

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
                    initialValue: DateTime.now().toString(),
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
                // ウマ
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "0",
                      style: TextStyle(fontSize: 14),
                    ),
                    Radio(
                      activeColor: Colors.blue,
                      value: 0,
                      groupValue: provider.horseRate,
                      onChanged: (value) =>
                          provider.setAggregatedRate(value as int),
                      autofocus: true,
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    const Text(
                      "5-10",
                      style: TextStyle(fontSize: 14),
                    ),
                    Radio(
                      activeColor: Colors.blue,
                      value: 5,
                      groupValue: provider.horseRate,
                      onChanged: (value) =>
                          provider.setAggregatedRate(value as int),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    const Text(
                      "10-20",
                      style: TextStyle(fontSize: 14),
                    ),
                    Radio(
                      activeColor: Colors.blue,
                      value: 10,
                      groupValue: provider.horseRate,
                      onChanged: (value) =>
                          provider.setAggregatedRate(value as int),
                    ),
                  ],
                ),
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
                  provider.registerGame();
                  Navigator.pop(context);
                },
          child: const Text('作成'),
        ),
      ],
    );
  }
}

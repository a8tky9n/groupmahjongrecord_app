import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupSchedule extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(groupViewModelProvider);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "予定表",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        provider.schedules == null || provider.schedules!.length == 0
            ? const Text("予定はありません")
            : const SizedBox(
                height: 20,
              ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            child: const Text('予定作成'),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
            onPressed: null),
        // カレンダーを表示

        // 日付が入っていたら予定作成ダイアログ表示
      ],
    );
  }
}

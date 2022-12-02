import 'package:groupmahjongrecord/data/models/Game.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/ScoreCell.dart';

class ScoreRow extends ConsumerWidget {
  final List<GameResults> scores;
  final Function OnTapCallback;
  const ScoreRow({
    Key? key,
    required this.scores,
    required this.OnTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupViewModelProvider).groupDetail;
    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                DateFormat('yyyy-M-d').format(scores[0].createdAt!),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              )),
          for (var i = 0; i <= 3; i++)
            Expanded(
              flex: 1,
              child: ScoreCell(
                  userName: group!.profiles!
                                  .firstWhere((profile) =>
                                      profile.id == scores[i].profile!)
                                  .nickName ==
                              null ||
                          group.profiles!
                              .firstWhere(
                                  (profile) => profile.id == scores[i].profile!)
                              .nickName!
                              .isEmpty
                      ? "プレイヤー"
                      : group.profiles!
                          .firstWhere(
                              (profile) => profile.id == scores[i].profile!)
                          .nickName!,
                  score: scores[i].score!.toInt()),
            ),
          const Divider(),
        ],
      ),
    );
  }
}

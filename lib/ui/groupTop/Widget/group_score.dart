import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/ScoreHeader.dart';
import 'package:groupmahjongrecord/components/ScoreRow.dart';
import 'package:groupmahjongrecord/data/models/UserScore.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/aggregated_data_dialog.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:date_time_picker/date_time_picker.dart';

class GroupScore extends ConsumerWidget {
  Widget _playerScore(WidgetRef ref) {
    var userScores = ref.watch(groupViewModelProvider).playerDetailScores;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                _scoreHeader(),
                for (UserScore score in userScores) _userScore(score),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scoreHeader() {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(
              width: 150,
              child: Center(
                child: Text("プレイヤー名"),
              ),
            ),
            SizedBox(
              width: 90,
              child: Center(
                child: Text("合計スコア"),
              ),
            ),
            SizedBox(
              width: 90,
              child: Center(
                child: Text("平均スコア"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("平均順位"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("1位回数"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("2位回数"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("3位回数"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("4位回数"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("対局数"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("トップ率"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("連対率"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("ラス回避率"),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 1.0,
          width: 1050,
          child: Center(
            child: Container(
              margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
              height: 5.0,
              color: Color.fromARGB(255, 216, 216, 216),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _userScore(UserScore score) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 150,
              child: Center(
                child: Text("プレイヤー"),
              ),
            ),
            SizedBox(
              width: 90,
              child: Center(
                child: Text(score.totalScore.toString()),
              ),
            ),
            SizedBox(
              width: 90,
              child: Center(
                child: Text(score.averageScore!.toStringAsFixed(2)),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.averageRank!.toStringAsFixed(2)),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.first.toString()),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.second.toString()),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.third.toString()),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.forth.toString()),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.totalGameCount.toString()),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.topAverage!.toStringAsFixed(2)),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.plusAverage!.toStringAsFixed(2)),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(score.avoidButtomAverage!.toStringAsFixed(2)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 1.0,
          width: 1050,
          child: Center(
            child: Container(
              margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
              height: 5.0,
              color: Color.fromARGB(255, 216, 216, 216),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _calender(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'yyyy/MM/d',
            //initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            locale: const Locale('ja', 'JP'),
            dateLabelText: 'Date',
            selectableDayPredicate: (date) {
              return true;
            },
            onChanged: (val) => ref
                .watch(groupViewModelProvider)
                .setStartDate(DateTime.parse(val)),
            validator: (val) {
              // print(val);
              return null;
            },
            onSaved: (val) => {
              ref
                  .watch(groupViewModelProvider)
                  .setStartDate(DateTime.parse(val!))
            },
          ),
        ),
        const Text(
          "  ~  ",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 100,
          child: DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'yyyy/MM/d',
            // initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            locale: const Locale('ja', 'JP'),
            dateLabelText: 'Date',
            selectableDayPredicate: (date) {
              return true;
            },
            onChanged: (val) => ref
                .watch(groupViewModelProvider)
                .setEndDate(DateTime.parse(val)),
            validator: (val) {
              // print(val);
              return null;
            },
            onSaved: (val) => {
              ref.watch(groupViewModelProvider).setEndDate(DateTime.parse(val!))
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        OutlinedButton(
            onPressed: () => {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AggregatedDataDialog())
                },
            child: Text("集計"))
      ],
    );
  }

  Widget _playRecords(WidgetRef ref) {
    var games = ref.watch(groupViewModelProvider).games!;
    var sDate = ref.watch(groupViewModelProvider).startDate;
    var eDate = ref.watch(groupViewModelProvider).endDate;
    var fillterdGames;
    if (sDate != null && eDate != null) {
      fillterdGames = games
          .where((e) =>
              e.createdAt!.compareTo(eDate) < 0 &&
              e.createdAt!.compareTo(sDate) > 0)
          .toList();
    } else {
      fillterdGames = games;
    }
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 30),
      // height: 600,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // child: Expanded(
          child: Column(
            children: <Widget>[
              const ScoreHeader(),
              const Divider(),
              for (int i = 0; i < fillterdGames!.length; i++)
                // for (var score in game.gameResults!)
                ScoreRow(
                  scores: fillterdGames[i].gameResults!,
                  OnTapCallback: () => {},
                ),
            ],
          ),
          // ),
        ),
      ),
    );
  }

  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "対局記録",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _calender(context, ref),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "スコア一覧",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _playerScore(ref),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "対局記録一覧",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _playRecords(ref),
      ],
    );
  }
}

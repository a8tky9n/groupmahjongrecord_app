import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/data/models/Score.dart';
import 'package:groupmahjongrecord/components/ScoreCell.dart';

class ScoreRow extends StatelessWidget {
  final Score score;
  final Function OnTapCallback;
  const ScoreRow({
    Key? key,
    required this.score,
    required this.OnTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                DateFormat('yyyy-M-d')
                    .format((score.createDate as Timestamp).toDate()),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              )),
          for (var i = 0; i <= 3; i++)
            Expanded(
              flex: 1,
              child: ScoreCell(
                  userName: score.users![i].name.toString(),
                  score: score.points![i].toInt()),
            ),
          const Divider(),
        ],
      ),
    );
  }
}

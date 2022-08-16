import 'package:flutter/material.dart';

class ScoreCell extends StatelessWidget {
  final String userName;
  final int score;
  const ScoreCell({
    Key? key,
    required this.userName,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            score.toStringAsFixed(1),
            style: TextStyle(color: score < 0 ? Colors.red : Colors.blue),
          ),
          Text(
            userName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12.0),
            strutStyle: StrutStyle(
              fontSize: 12.0,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

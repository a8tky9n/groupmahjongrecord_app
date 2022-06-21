import 'package:flutter/material.dart';

class ScoreHeader extends StatelessWidget {
  const ScoreHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '日付',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '1位',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '2位',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '3位',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '4位',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }
}

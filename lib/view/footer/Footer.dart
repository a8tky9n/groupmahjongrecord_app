import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 20, // to apply margin in the main axis of the wrap
        runSpacing: 20,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/contact');
            },
            child: const Text('お問い合わせ'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/legalnotice');
            },
            child: const Text('免責事項'),
          ),
        ],
      );
}

import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String imgPath;
  final String userName;
  final int userRate;
  final Function OnTapCallback;
  const UserCard({
    Key? key,
    required this.imgPath,
    required this.userName,
    required this.userRate,
    required this.OnTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => {
          OnTapCallback(),
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                imgPath,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 3),
                  Text(
                    userName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    userRate.toString(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
            ),
          ],
        ),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}

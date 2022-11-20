import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupCardList extends StatefulHookConsumerWidget {
  @override
  GroupCardListState createState() => GroupCardListState();
}

class GroupCardListState extends ConsumerState<GroupCardList> {
  void initState() {
    super.initState();
    Future(() {
      final provider = ref.watch(groupListViewModelProvider);
      provider.getLoginUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuStatus = ref.watch(groupListViewModelProvider);
    log(sideMenuStatus.loginUser.toString());
    return GridView.count(
      // primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      // return Column(
      children: <Widget>[
        if (sideMenuStatus.loginUser != null &&
            sideMenuStatus.loginUser!.group!.isNotEmpty)
          for (var group in sideMenuStatus.loginUser!.group!)
            buildImageCard(group.image!, group.title!, group.id!),
      ],
    );
  }

  Widget buildImageCard(String imageUrl, String title, String id) {
    log("タイトル名" + title);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // var group = Group(
          //     groupId: id,
          //     title: title,
          //     img: imageUrl,
          //     text: "ケチな点棒拾う気なし・・・！",
          //     password: "");
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => GroupMain(
          //       group: group,
          //       user: _user,
          //     ),
          //   ),
          // );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: imageUrl.isEmpty
                  ? Image.asset(
                      'assets/no_image_square.jpeg',
                      fit: BoxFit.fitWidth,
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}

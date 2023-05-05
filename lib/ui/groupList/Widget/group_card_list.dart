import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:groupmahjongrecord/ui/groupList/Widget/join_group_dialog.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupCardList extends StatefulHookConsumerWidget {
  @override
  GroupCardListState createState() => GroupCardListState();
}

class GroupCardListState extends ConsumerState<GroupCardList> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = ref.watch(groupListViewModelProvider);
      provider.getLoginUser(() => ref
          .read(sceneTitleProvider.notifier)
          .update((state) => AppScene.top.name));
      log("ビルト後ログイン情報 : " + provider.loginUser.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuStatus = ref.watch(groupListViewModelProvider);
    // log("ログイン情報 : " + sideMenuStatus.loginUser.toString());

    return RefreshIndicator(
      onRefresh: () async {
        print('Loading New Data');
        sideMenuStatus.getLoginUser(() {});
        // await _loadData();
      },
      child: sideMenuStatus.loginUser == null
          ? Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Container(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  )
                ])
          : GridView.count(
              // primary: false,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              crossAxisCount: 2,
              // return Column(

              children: <Widget>[
                for (var group in sideMenuStatus.loginUser!.group!)
                  buildImageCard(
                      group.image ?? "", group.title!, group.id!, ref),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => JoinGroupDialog());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.add,
                            color: Colors.black54,
                            size: 48.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                        // const SizedBox(height: 10),
                        Text(
                          'グループに参加',
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
                ),
              ],
            ),
    );
  }

  Widget buildImageCard(
      String imageUrl, String title, String id, WidgetRef ref) {
    // log("タイトル名" + title);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // MainViewmodl.setGroupId(id);
          ref.read(groupIdProvider.notifier).state = id;
          ref.read(lastSceneProvider.notifier).state = AppScene.groupList;
          ref
              .read(sceneTitleProvider.notifier)
              .update((state) => AppScene.groupTop.name);
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

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/ui/groupList/Widget/group_card_list.dart';
import 'package:groupmahjongrecord/ui/groupList/Widget/side_menu_list.dart';
import 'package:groupmahjongrecord/ui/groupList/Widget/create_group_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/view/footer/Footer.dart';

class GroupList extends ConsumerWidget {
//   @override
//   GroupListState createState() => GroupListState();
// }

// class GroupListState extends ConsumerState<GroupList> {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      drawer: LoginSideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            // crossAxisAlignment: CrossAxisAlignment.start,
            GroupCardList(),
            const Footer(),
            const SizedBox(
              height: 60,
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => CreateGroupDialog()),
        },
        icon: Icon(Icons.group_add),
        label: const Text("新規グループを作成"),
      ),
    );
  }
}

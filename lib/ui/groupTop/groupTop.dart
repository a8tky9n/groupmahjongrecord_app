import 'dart:developer';

import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/group_score.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/side_menu.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/group_top_main.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/group_menber.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/record_score.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:groupmahjongrecord/view/footer/Footer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class GroupTop extends ConsumerStatefulWidget {
  @override
  GroupTopState createState() => GroupTopState();
}

class GroupTopState extends ConsumerState<GroupTop> {
  @override
  void initState() {
    super.initState();
    Future(() {
      final provider = ref.watch(groupViewModelProvider);
      final groupId = ref.watch(groupIdProvider);
      log(groupId);
      provider.getGroup(groupId);
      provider.detailId = "";
    });
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'グループTop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: '対局開始',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'メンバー',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          label: '対局記録',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: ref.read(groupViewModelProvider.notifier).selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    ref.read(groupViewModelProvider.notifier).changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: ref.watch(groupViewModelProvider).detailId.isNotEmpty
            ? IconButton(
                onPressed: () {
                  ref.read(groupViewModelProvider.notifier).setDetailUserId("");
                },
                icon: const Icon(Icons.arrow_back_ios_new))
            : null,
      ),
      drawer: ref.watch(groupViewModelProvider).detailId.isEmpty
          ? GroupSideMenu()
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              // crossAxisAlignment: CrossAxisAlignment.start,
              _mainContent(),
              const Footer(),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _mainContent() {
    switch (ref.read(groupViewModelProvider.notifier).selectedIndex) {
      case 0:
        return GroupTopMain();
      case 1:
        return RecordScore();
      case 2:
        return GroupMember();
      case 3:
        return GroupScore();
      default:
        return GroupTopMain();
    }
  }
}

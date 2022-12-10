import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList.dart';
import 'package:groupmahjongrecord/ui/groupTop/groupTop.dart';
import 'package:groupmahjongrecord/ui/login/Login.dart';
import 'package:groupmahjongrecord/view/Contact.dart';
import 'package:groupmahjongrecord/view/Legalnotice.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AppScene {
  top,
  notice,
  contact,
  groupList,
  groupTop,
}

// これをローカルに宣言してしまうと画面遷移アニメーションが表示されないようになってしまいます。
final GlobalKey<NavigatorState> _nestedNavigatorKey =
    GlobalKey<NavigatorState>();

class SceneRouterDelegate extends RouterDelegate<void>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  SceneRouterDelegate(this.ref);

  final WidgetRef ref;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _nestedNavigatorKey;

  @override
  Widget build(BuildContext context) {
    final sceneTitle = ref.watch(sceneTitleProvider);
    return Navigator(
      key: _nestedNavigatorKey,
      pages: [
        MaterialPage(
          arguments: AppScene.top,
          child: LoginPage(),
        ),
        if (sceneTitle == AppScene.top.name)
          MaterialPage(
            arguments: AppScene.top,
            child: LoginPage(),
          ),
        if (sceneTitle == AppScene.contact.name)
          MaterialPage(
            arguments: AppScene.contact,
            child: Contact(),
          ),
        if (sceneTitle == AppScene.notice.name)
          const MaterialPage(
            arguments: AppScene.notice,
            child: Legalnotice(),
          ),
        if (sceneTitle == AppScene.groupList.name)
          MaterialPage(
            arguments: AppScene.groupList,
            child: GroupList(),
          ),
        if (sceneTitle == AppScene.groupTop.name)
          MaterialPage(
            arguments: AppScene.groupTop,
            child: GroupTop(),
          ),
      ],
      onPopPage: (route, result) {
        final pageName = route.settings.arguments as AppScene;
        log(pageName.name);
        ref.read(sceneTitleProvider.notifier).state = "";
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(void configuration) async {}
}

final sceneTitleProvider = StateProvider<String>((ref) => "");

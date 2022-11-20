import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groupmahjongrecord/ui/groupList/groupList.dart';
import 'package:groupmahjongrecord/ui/login/Login.dart';
import 'package:groupmahjongrecord/view/Contact.dart';
import 'package:groupmahjongrecord/view/Legalnotice.dart';
import 'package:groupmahjongrecord/view/groupview/GroupTop.dart';

enum Scene {
  top,
  notice,
  contact,
  groupList,
  groupTop,
  recordScore,
  member,
  groupScore,
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
          arguments: Scene.top,
          child: LoginPage(),
        ),
        // if (ref.watch(showFugaPageProvider))
        //   MaterialPage(
        //     // nameというプロパティも存在しますが、こちらはルートのnameなのでどの画面かという情報を渡すには適していないと思われます。
        //     arguments: Scene.groupList,
        //     child: GroupList(),
        //   ),
        if (sceneTitle == Scene.top.name)
          MaterialPage(
            arguments: Scene.top,
            child: LoginPage(),
          ),
        if (sceneTitle == Scene.contact.name)
          MaterialPage(
            arguments: Scene.contact,
            child: Contact(),
          ),
        if (sceneTitle == Scene.notice.name)
          const MaterialPage(
            arguments: Scene.notice,
            child: Legalnotice(),
          ),
        if (sceneTitle == Scene.groupList.name)
          MaterialPage(
            arguments: Scene.groupList,
            child: GroupList(),
          ),
        // if (sceneTitle == Scene.groupTop.name)
        //   MaterialPage(
        //     arguments: Scene.groupTop,
        //     child: GroupTop(),
        //   ),
        // if (sceneTitle == Scene.recordScore.name)
        //   MaterialPage(
        //     arguments: Scene.recordScore,
        //     child: Contact(),
        //   ),
        // if (sceneTitle == Scene.member.name)
        //   MaterialPage(
        //     arguments: Scene.member,
        //     child: Contact(),
        //   ),
        // if (sceneTitle == Scene.groupScore.name)
        //   MaterialPage(
        //     arguments: Scene.groupScore,
        //     child: Contact(),
        //   ),
      ],
      onPopPage: (route, result) {
        final pageName = route.settings.arguments as Scene;
        log(pageName.name);
        ref.read(sceneTitleProvider.notifier).state = "";
        if (!route.didPop(result)) {
          return false;
        }
        // switch (pageName) {
        //   case Scene.fugaPage:
        //     ref.read(showFugaPageProvider.notifier).state = false;
        //     break;
        //   case Scene.fooPage:
        //     ref.read(sceneTitleProvider.notifier).state = "";
        //     break;
        //   default:
        //     break;
        // }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(void configuration) async {}
}

// final lastSceneProvider = StateProvider<String>((ref) => "");

final sceneTitleProvider = StateProvider<String>((ref) => "");

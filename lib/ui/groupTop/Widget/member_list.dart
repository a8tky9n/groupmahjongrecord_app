import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/UserCard.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:badges/badges.dart';

class MemberList extends ConsumerWidget {
  // ユーザーカード
  Widget buildRateCard(
      WidgetRef ref, String? imageUrl, String? title, String id, int rate) {
    return SizedBox(
      height: 500,
      child: UserCard(
        imgPath: imageUrl,
        userName: title,
        userRate: rate,
        OnTapCallback: () =>
            {ref.read(groupViewModelProvider.notifier).selectPlayer(id)},
      ),
    );
  }

  Widget buildRageCardWidhBadge(WidgetRef ref, String? imageUrl, String? title,
      String id, int rate, int position) {
    return Badge(
      badgeContent: (position == 1)
          ? const Text(
              '東',
              style: TextStyle(color: Colors.white, fontFamily: 'PottaOne'),
            )
          : (position == 2)
              ? const Text('南',
                  style: TextStyle(color: Colors.black, fontFamily: 'PottaOne'))
              : (position == 3)
                  ? const Text('西',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'PottaOne'))
                  : const Text('北',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'PottaOne')),
      badgeColor:
          position == 1 ? Colors.red[600] as Color : Colors.teal[50] as Color,
      position: BadgePosition.topEnd(top: 1, end: 1),
      child: buildRateCard(ref, imageUrl, title, id, rate),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(groupViewModelProvider);
    return GridView.count(
      // primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 0.85,
      // return Column(
      children: <Widget>[
        if (provider.players!.isNotEmpty)
          for (var player in provider.players!)
            (player.position == 0)
                ? buildRateCard(
                    ref,
                    player.user.image,
                    player.user.nickName,
                    player.user.id!,
                    player.user.rate4!,
                  )
                : buildRageCardWidhBadge(
                    ref,
                    player.user.image,
                    player.user.nickName,
                    player.user.id!,
                    player.user.rate4!,
                    player.position),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/components/UserCard.dart';
import 'package:groupmahjongrecord/ui/groupTop/Widget/member_detail.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupMember extends ConsumerWidget {
  Widget _memberList(WidgetRef ref) {
    var provider = ref.watch(groupViewModelProvider);
    return GridView.count(
      // primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 0.85,
      // return Column(
      children: <Widget>[
        if (provider.players != null && provider.players!.isNotEmpty)
          for (var player in provider.players!)
            buildRateCard(
              ref,
              player.user.image,
              player.user.nickName,
              player.user.id!,
              player.user.rate4!,
            ),
      ],
    );
  }

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
            {ref.read(groupViewModelProvider.notifier).setDetailUserId(id)},
      ),
    );
  }

  Widget memberList(WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "グループメンバー",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _memberList(ref),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.read(groupViewModelProvider).detailId.isNotEmpty
        ? MemberDetail()
        : memberList(ref);
  }
}

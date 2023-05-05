import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Footer extends ConsumerWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(sceneTitleProvider);
    return Wrap(
      spacing: 20, // to apply margin in the main axis of the wrap
      runSpacing: 20,
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 12),
          ),
          onPressed: () {
            ref.read(lastSceneProvider.notifier).state = provider.isEmpty
                ? AppScene.top
                : AppScene.values.byName(provider);
            ref
                .read(sceneTitleProvider.notifier)
                .update((state) => AppScene.privacy.name);
            // Navigator.pushNamed(context, '/contact');
          },
          child: const Text('プライバシーポリシー'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 12),
          ),
          onPressed: () {
            ref.read(lastSceneProvider.notifier).state = provider.isEmpty
                ? AppScene.top
                : AppScene.values.byName(provider);
            ref
                .read(sceneTitleProvider.notifier)
                .update((state) => AppScene.notice.name);
            // Navigator.pushNamed(context, '/legalnotice');
          },
          child: const Text('免責事項'),
        ),
      ],
    );
  }
}

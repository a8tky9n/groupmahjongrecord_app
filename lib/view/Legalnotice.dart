import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/main_viewmodel.dart';
import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Legalnotice extends ConsumerWidget {
  const Legalnotice({Key? key}) : super(key: key);

  Widget _legalNotice() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      fit: StackFit.passthrough,
      children: [
        Column(
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              '免責事項',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: const <Widget>[
                  Text(
                    '・本サイトにおける内容の変更、中断、終了によって生じたいかなる損害についても一切責任を負いません。',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '・本サービスを利用したことにより直接的または間接的に利用者に発生した損害について、一切賠償責任は負いません',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: IconButton(
          onPressed: () {
            ref
                .read(sceneTitleProvider.notifier)
                .update((state) => ref.watch(lastSceneProvider).name);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        // タイトルテキスト
        // title: Text('Hello'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            // crossAxisAlignment: CrossAxisAlignment.start,
            child: _legalNotice(),
          ),
        ),
      ),
    );
  }
}

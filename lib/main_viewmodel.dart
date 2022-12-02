import 'package:groupmahjongrecord/roter_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupIdProvider = StateProvider<String>((ref) => "");
final lastSceneProvider = StateProvider<AppScene>((ref) => AppScene.top);

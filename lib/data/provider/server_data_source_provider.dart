import 'package:groupmahjongrecord/data/remote/server_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/data/provider/firebase_auth_provider.dart';
import 'package:groupmahjongrecord/data/remote/server_data_source_impl.dart';

final serverDataSourceProvider =
    Provider<Server>((ref) => ServerImpl(auth: ref.read(firebaseAuthProvider)));

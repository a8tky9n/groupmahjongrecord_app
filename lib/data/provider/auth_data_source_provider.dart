import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/data/provider/firebase_auth_provider.dart';
import 'package:groupmahjongrecord/data/remote/auth_data_source_impl.dart';

import '../remote/auth_data_source.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
    (ref) => AuthDataSourceImpl(auth: ref.read(firebaseAuthProvider)));

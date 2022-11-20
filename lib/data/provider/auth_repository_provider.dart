import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/data/repository/auth_repository.dart';
import 'package:groupmahjongrecord/data/repository/auth_repository_impl.dart';
import 'package:groupmahjongrecord/data/provider/auth_data_source_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) =>
    AuthRepositoryImpl(authDataSource: ref.read(authDataSourceProvider)));

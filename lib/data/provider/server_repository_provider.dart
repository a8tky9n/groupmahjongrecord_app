import 'package:groupmahjongrecord/data/provider/server_data_source_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/data/repository/server_repository.dart';
import 'package:groupmahjongrecord/data/repository/server_repository_impl.dart';

final serverRepositoryProvider = Provider<ServerRepository>(
    (ref) => ServerRepositoryImpl(ref.read(serverDataSourceProvider)));

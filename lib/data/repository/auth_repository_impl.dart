import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:groupmahjongrecord/data/remote/auth_data_source.dart';
import 'package:groupmahjongrecord/data/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _dataSource = authDataSource;

  final AuthDataSource _dataSource;

  @override
  User? fetchUser() {
    return _dataSource.getUser();
  }

  @override
  Future<void> signIn(
      String eMail, String pass, BuildContext ctx, Function(String) eCallback) {
    return _dataSource.signIn(eMail, pass, ctx, eCallback);
  }

  @override
  Future<void> signOn(
      String eMail, String pass, BuildContext ctx, Function(String) eCallback) {
    return _dataSource.signOn(eMail, pass, ctx, eCallback);
  }

  @override
  Future<void> forgetPass(
      String pass, BuildContext ctx, Function(String) eCallback) {
    return _dataSource.forgetPass(pass, ctx, eCallback);
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }
}

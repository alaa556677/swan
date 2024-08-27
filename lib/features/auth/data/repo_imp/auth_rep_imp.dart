import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:swan/core/app_constatnts/failure.dart';
import 'package:swan/features/auth/domain/entity/login_entity.dart';
import 'package:swan/features/auth/domain/repo/auth_repo.dart';
import '../data_source/login_dataSource.dart';

class AuthRepoImp implements AuthRepository {
  final LoginDataSource loginDataSource;
  AuthRepoImp(
    this.loginDataSource
  );
////////////////////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, LoginEntity>> loginMethod(String email, String password) async {
    try {
      return Right(await loginDataSource.loginMethod(email, password));
    } catch (e) {
    debugPrint('getShortClientFiles = $e');
    return Left(Failure(e.toString()));
    }
  }
////////////////////////////////////////////////////////////////////////////////
}
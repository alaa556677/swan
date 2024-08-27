import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:swan/core/app_constatnts/failure.dart';
import 'package:swan/features/auth/domain/entity/login_entity.dart';
import 'package:swan/features/auth/domain/repo/auth_repo.dart';
import 'package:swan/features/user_data/domain/entity/user_data_entity.dart';
import 'package:swan/features/user_data/domain/repo/user_repo.dart';
import '../data_source/user_data_source.dart';

class UserRepoImp implements UserRepo {
  final UserDataSource userDataSource;
  UserRepoImp(
    this.userDataSource
  );
////////////////////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, UserDataEntityEntity>> getUserData() async {
    try {
      return Right(await userDataSource.getUserData());
    } catch (e) {
    debugPrint('getUserData = $e');
    return Left(Failure(e.toString()));
    }
  }
////////////////////////////////////////////////////////////////////////////////
}
import 'package:dartz/dartz.dart';
import '../../../../core/app_constatnts/failure.dart';
import '../entity/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> loginMethod (String email, String password);
}


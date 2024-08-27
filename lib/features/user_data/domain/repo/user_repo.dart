import 'package:dartz/dartz.dart';
import '../../../../core/app_constatnts/failure.dart';
import '../../../auth/domain/entity/login_entity.dart';
import '../entity/user_data_entity.dart';

abstract class UserRepo {
  Future<Either<Failure, UserDataEntityEntity>> getUserData();
}
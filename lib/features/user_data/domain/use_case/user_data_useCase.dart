import 'package:dartz/dartz.dart';
import 'package:swan/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/app_constatnts/failure.dart';
import '../entity/user_data_entity.dart';
import '../repo/user_repo.dart';

class UserDataUseCase{
  final UserRepo userRepo;
  UserDataUseCase(this.userRepo);
  Future<Either<Failure, UserDataEntity>> call(String id) async {
    return await userRepo.getUserData(id);
  }
}


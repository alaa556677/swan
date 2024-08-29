import 'package:dartz/dartz.dart';
import 'package:swan/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/app_constatnts/failure.dart';
import '../entity/settings_entity.dart';
import '../entity/user_data_entity.dart';
import '../repo/user_repo.dart';

class GetSettingsUseCase{
  final UserRepo userRepo;
  GetSettingsUseCase(this.userRepo);
  Future<Either<Failure, SettingsEntity>> call() async {
    return await userRepo.getSettings();
  }
}


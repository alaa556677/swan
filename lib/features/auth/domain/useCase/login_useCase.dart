import 'package:dartz/dartz.dart';
import 'package:swan/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/app_constatnts/failure.dart';
import '../entity/login_entity.dart';


  class LoginUseCase{
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  Future<Either<Failure, LoginEntity>> call(String email, String password) async {
    return await authRepository.loginMethod(email, password);
  }
}


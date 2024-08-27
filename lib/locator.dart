import 'package:get_it/get_it.dart';

import 'features/auth/data/data_source/login_dataSource.dart';
import 'features/auth/data/repo_imp/auth_rep_imp.dart';
import 'features/auth/domain/repo/auth_repo.dart';
import 'features/auth/domain/useCase/login_useCase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

final locator = GetIt.instance;

void setup() {
//////////////////////////////////////////////////////////////////////////////// cubit
  locator.registerFactory(() => AuthCubit(locator()));

//////////////////////////////////////////////////////////////////////////////// data source
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSource());

//////////////////////////////////////////////////////////////////////////////// use case
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator(),));

//////////////////////////////////////////////////////////////////////////////// repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepoImp(locator()));
}
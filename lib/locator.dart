import 'package:get_it/get_it.dart';

import 'features/auth/data/data_source/login_dataSource.dart';
import 'features/auth/data/repo_imp/auth_rep_imp.dart';
import 'features/auth/domain/repo/auth_repo.dart';
import 'features/auth/domain/useCase/login_useCase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/user_data/data/data_source/settings_dataSource.dart';
import 'features/user_data/data/data_source/user_data_source.dart';
import 'features/user_data/data/repo_imp/user_repo_imp.dart';
import 'features/user_data/domain/repo/user_repo.dart';
import 'features/user_data/domain/use_case/settings_useCase.dart';
import 'features/user_data/domain/use_case/user_data_useCase.dart';
import 'features/user_data/presentation/cubit/user_cubit.dart';

final locator = GetIt.instance;

void setup() {
//////////////////////////////////////////////////////////////////////////////// cubit
  locator.registerFactory(() => AuthCubit(locator()));
  locator.registerFactory(() => UserDataCubit(locator(), locator()));

//////////////////////////////////////////////////////////////////////////////// data source
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSource());
  locator.registerLazySingleton<UserDataSource>(() => UserDataSource());
  locator.registerLazySingleton<GetSettingsSource>(() => GetSettingsSource());

//////////////////////////////////////////////////////////////////////////////// use case
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator(),));
  locator.registerLazySingleton<UserDataUseCase>(() => UserDataUseCase(locator(),));
  locator.registerLazySingleton<GetSettingsUseCase>(() => GetSettingsUseCase(locator(),));

//////////////////////////////////////////////////////////////////////////////// repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepoImp(locator()));
  locator.registerLazySingleton<UserRepo>(() => UserRepoImp(locator(), locator()));
}
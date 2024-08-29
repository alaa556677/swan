import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan/features/auth/presentation/cubit/auth_states.dart';
import 'package:swan/features/user_data/presentation/cubit/user_states.dart';
import '../../../../main.dart';
import '../../data/model/user_data_model.dart';
import '../../domain/entity/settings_entity.dart';
import '../../domain/entity/user_data_entity.dart';
import '../../domain/use_case/settings_useCase.dart';
import '../../domain/use_case/user_data_useCase.dart';

class UserDataCubit extends Cubit<UserDataStates>{
  final UserDataUseCase userDataUseCase;
  final GetSettingsUseCase getSettingsUseCase;
  UserDataCubit(
    this.userDataUseCase,
    this.getSettingsUseCase
  ) : super(InitialUserDataState());

  static final UserDataCubit _userDataCubit = BlocProvider.of<UserDataCubit>(navigatorKey.currentState!.context);
  static UserDataCubit get instance => _userDataCubit;

////////////////////////////////////////////////////////////////////////////////
  UserDataEntityEntity? userDataEntityEntity;
  List <Tax> tax = [];
  List<Charging> charging = [];
  getUserData () async {
    emit(GetUserDataLoading());
    final result = await userDataUseCase.call();
    result.fold((failure) => emit(GetUserDataFailure(failure.errorMessage)), (userData) {
      if (userData != null) {
        userDataEntityEntity = userData;
        tax = userData.tax!;
        charging = userData.charging!;
        emit(GetUserDataSuccess(userData));
      } else {
        emit(GetUserDataError());
      }
    });
  }
////////////////////////////////////////////////////////////////////////////////
  SettingsEntity? settingsEntity;
  getSettings () async {
    emit(GetSettingsLoading());
    final result = await getSettingsUseCase.call();
    result.fold((failure) => emit(GetSettingsFailure(failure.errorMessage)), (userData) {
      if (userData != null) {
        settingsEntity = userData;
        emit(GetSettingsSuccess(userData));
      } else {
        emit(GetSettingsError());
      }
    });
  }
////////////////////////////////////////////////////////////////////////////////
}
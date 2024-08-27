import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan/features/auth/presentation/cubit/auth_states.dart';
import 'package:swan/features/user_data/presentation/cubit/user_states.dart';
import '../../../../main.dart';
import '../../domain/entity/user_data_entity.dart';
import '../../domain/use_case/user_data_useCase.dart';

class UserDataCubit extends Cubit<UserDataStates>{
  final UserDataUseCase userDataUseCase;
  UserDataCubit(
    this.userDataUseCase
  ) : super(InitialUserDataState());

  static final UserDataCubit _userDataCubit = BlocProvider.of<UserDataCubit>(navigatorKey.currentState!.context);
  static UserDataCubit get instance => _userDataCubit;

////////////////////////////////////////////////////////////////////////////////
  UserDataEntityEntity? userDataEntityEntity;
  getUserData () async {
    emit(GetUserDataLoading());
    final result = await userDataUseCase.call();
    result.fold((failure) => emit(GetUserDataFailure(failure.errorMessage)), (userData) {
      if (userData != null) {
        userDataEntityEntity = userData;
        emit(GetUserDataSuccess(userData));
      } else {

        emit(GetUserDataError());
      }
    });
  }
////////////////////////////////////////////////////////////////////////////////
}
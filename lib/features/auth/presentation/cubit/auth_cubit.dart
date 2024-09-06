import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan/core/app_constatnts/enum_constants.dart';
import 'package:swan/core/network/cache_helper.dart';
import 'package:swan/features/auth/presentation/cubit/auth_states.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../main.dart';
import '../../data/model/login_model.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/useCase/login_useCase.dart';

class AuthCubit extends Cubit<AuthStates>{
  final LoginUseCase loginUseCase;
  AuthCubit(
    this.loginUseCase
  ) : super(InitialAuthState());

  static final AuthCubit _authCubit = BlocProvider.of<AuthCubit>(navigatorKey.currentState!.context);
  static AuthCubit get instance => _authCubit;
////////////////////////////////////////////////////////////////////////////////
  User? userModel;
  loginMethod (String email, String password) async {
    emit(LoginLoading());
    final result = await loginUseCase.call(email, password);
    result.fold((failure) => emit(LoginFailure(failure.errorMessage)), (login) {
      if (login.role == 'authenticated') {
        userModel = login.data;
        CacheHelper.saveData(key: Constants.token.toString(), value: login.data?.token);
        CacheHelper.saveData(key: Constants.userID.toString(), value: login.data?.sId);
        DioHelper.init();
        emit(LoginSuccess(login));
      } else {
        emit(LoginError());
      }
    });
  }
////////////////////////////////////////////////////////////////////////////////
  bool obscureText = true;
  changeObscureText(){
    obscureText = !obscureText;
    emit(ChangeObscureText());
  }
}
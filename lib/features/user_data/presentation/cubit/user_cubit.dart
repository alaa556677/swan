import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  UserDataEntity? userDataEntity;
  List <Tax> tax = [];
  List<Charging> charging = [];
  getUserData () async {
    emit(GetUserDataLoading());
    final result = await userDataUseCase.call();
    result.fold((failure) => emit(GetUserDataFailure(failure.errorMessage)), (userData) {
      if (userData != null) {
        userDataEntity = userData;
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
  List<double> list = [];
  maxNumber(){
    double maxValue = 0;
    for (int i = 0; i < charging.length; i++) {
      list.add(charging[i].money!.toDouble());
    }
    list.reduce((value, element) {
      if (element > value) {
        maxValue = element;
        return maxValue;
      }
      return maxValue;
    });
    return maxValue;
  }
////////////////////////////////////////////////////////////////////////////////
  getString(){
    List <String> date = [];
    String text = '';
    for (int i = 0; i < charging.length; i++) {
      list.add(charging[i].createdAt);
    }
    date.reduce((value, element){
      if(element == value) {
        return "${DateFormat('yyyy-MM-dd').format(DateTime.parse(element.toString()))} ";
      } else {
        return DateFormat('yyyy-MM-dd').format(DateTime.parse(element.toString()));
      }
    });
  }
////////////////////////////////////////////////////////////////////////////////
//   bool isDark = false;
//   void changeAppMode (){
//     isDark = !isDark;
//     emit(ChangeAppMode());
//   }
}

class SalesData {
  SalesData(this.day, this.money, {this.color});
  final String day;
  final double money;
  final Color? color;
}
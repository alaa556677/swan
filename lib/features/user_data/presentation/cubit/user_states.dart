import '../../domain/entity/user_data_entity.dart';

abstract class UserDataStates{}

class InitialUserDataState extends UserDataStates{}
////////////////////////////////////////////////////////////////////////////////
class GetUserDataLoading extends UserDataStates{}
class GetUserDataFailure extends UserDataStates{
  String message;
  GetUserDataFailure(this.message);
}
class GetUserDataSuccess extends UserDataStates{
  UserDataEntityEntity  userDataEntityEntity;
  GetUserDataSuccess(this.userDataEntityEntity);
}
class GetUserDataError extends UserDataStates{}
////////////////////////////////////////////////////////////////////////////////
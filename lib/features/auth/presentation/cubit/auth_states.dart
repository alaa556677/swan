import '../../domain/entity/login_entity.dart';

abstract class AuthStates{}

class InitialAuthState extends AuthStates{}
////////////////////////////////////////////////////////////////////////////////
class LoginLoading extends AuthStates{}
class LoginFailure extends AuthStates{
  String message;
  LoginFailure(this.message);
}
class LoginSuccess extends AuthStates{
  LoginEntity loginEntity;
  LoginSuccess(this.loginEntity);
}
class LoginError extends AuthStates{}
////////////////////////////////////////////////////////////////////////////////
class ChangeObscureText extends AuthStates{}
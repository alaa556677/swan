import 'package:equatable/equatable.dart';

import '../../data/model/login_model.dart';

class LoginEntity extends Equatable{
  LoginEntity({
    this.role,
    this.data,
  });

  String? role;
  User? data;

  @override
  List<Object?> get props => [role , data];
}

import 'package:equatable/equatable.dart';

import '../../data/model/user_data_model.dart';


class UserDataEntityEntity extends Equatable{
  UserDataEntityEntity({
    this.userName,
    this.email,
    this.consumption,
    this.flowRate,
    this.limit,
    this.mobile,
    this.roomNumber,
    this.status,
    this.tax,
    this.charging,
    this.createdAt,
  });

  dynamic userName;
  dynamic email;
  int? consumption;
  int? flowRate;
  int? limit;
  int? mobile;
  int? roomNumber;
  bool? status;
  List<Tax>? tax;
  List<Charging>? charging;
  dynamic createdAt;

  @override
  List<Object?> get props => [userName , email, consumption, flowRate, limit, mobile, roomNumber, status, tax, charging, createdAt];
}

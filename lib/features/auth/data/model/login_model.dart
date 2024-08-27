import '../../domain/entity/login_entity.dart';

class LoginModel extends LoginEntity{

  LoginModel({super.role, super.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    data = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    if (this.data != null) {
      data['user'] = this.data!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? userName;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? token;

  User(
      {this.sId,
        this.userName,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.token});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
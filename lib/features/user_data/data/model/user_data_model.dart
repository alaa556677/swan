import 'package:flutter/material.dart';
import '../../domain/entity/user_data_entity.dart';

class UserData extends UserDataEntity{

  UserData({
    super.userName,
    super.email,
    super.consumption,
    super.flowRate,
    super.limit,
    super.mobile,
    super.roomNumber,
    super.status,
    super.tax,
    super.charging,
    super.createdAt
  });

  UserData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    consumption = json['consumption'];
    flowRate = json['flowRate'];
    limit = json['limit'];
    mobile = json['mobile'];
    roomNumber = json['roomNumber'];
    status = json['status'];
    if (json['tax'] != null) {
      tax = <Tax>[];
      json['tax'].forEach((v) {
        tax!.add(new Tax.fromJson(v));
      });
    }
    if (json['charging'] != null) {
      charging = <Charging>[];
      json['charging'].forEach((v) {
        charging!.add(new Charging.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['consumption'] = this.consumption;
    data['flowRate'] = this.flowRate;
    data['limit'] = this.limit;
    data['mobile'] = this.mobile;
    data['roomNumber'] = this.roomNumber;
    data['status'] = this.status;
    if (this.tax != null) {
      data['tax'] = this.tax!.map((v) => v.toJson()).toList();
    }
    if (this.charging != null) {
      data['charging'] = this.charging!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Tax {
  dynamic value;
  dynamic reason;
  dynamic sId;
  dynamic createdAt;
  dynamic updatedAt;

  Tax({this.value, this.reason, this.sId, this.createdAt, this.updatedAt});

  Tax.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    reason = json['reason'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['reason'] = this.reason;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Charging {
  dynamic money;
  dynamic sId;
  dynamic createdAt;
  dynamic updatedAt;

  Charging({this.money, this.sId, this.createdAt, this.updatedAt});

  Charging.fromJson(Map<String, dynamic> json) {
    money = json['money'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['money'] = this.money;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
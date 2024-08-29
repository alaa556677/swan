import '../../domain/entity/settings_entity.dart';

class SettingsModel extends SettingsEntity{

  SettingsModel({
    super.sId,
    super.whatsAppNumber,
    super.pageLink,
    super.meterPrice,
    super.instagram,
    super.facebook,
    super.whatsAppLink
  });

  SettingsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    whatsAppNumber = json['whatsAppNumber'];
    pageLink = json['pageLink'];
    meterPrice = json['meterPrice'];
    instagram = json['Instagram'];
    facebook = json['facebook'];
    whatsAppLink = json['whatsAppLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['whatsAppNumber'] = this.whatsAppNumber;
    data['pageLink'] = this.pageLink;
    data['meterPrice'] = this.meterPrice;
    data['Instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['whatsAppLink'] = this.whatsAppLink;
    return data;
  }
}
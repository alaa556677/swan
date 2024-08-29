import 'package:equatable/equatable.dart';
import '../../data/model/user_data_model.dart';

class SettingsEntity extends Equatable{
  SettingsEntity({
    this.sId,
    this.whatsAppNumber,
    this.pageLink,
    this.meterPrice,
    this.instagram,
    this.facebook,
    this.whatsAppLink,
  });

  String? sId;
  String? whatsAppNumber;
  String? pageLink;
  int? meterPrice;
  String? instagram;
  String? facebook;
  String? whatsAppLink;

  @override
  List<Object?> get props => [sId , whatsAppNumber, pageLink, meterPrice, instagram, facebook, whatsAppLink];
}

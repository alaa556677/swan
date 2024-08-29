import '../../../../core/network/dio_helper.dart';
import '../../../../core/url_constants.dart';
import '../model/settings_model.dart';
import '../model/user_data_model.dart';

class GetSettingsSource{
  Future <SettingsModel> getSettings() async {
    final result = await DioHelper.getData(
      url: UrlConstants.getSettings, query: {},
    );
    return SettingsModel.fromJson(result.data);
  }
}
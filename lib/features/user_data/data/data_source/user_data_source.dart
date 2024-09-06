import '../../../../core/network/dio_helper.dart';
import '../../../../core/url_constants.dart';
import '../model/user_data_model.dart';

class UserDataSource{
  Future <UserData> getUserData(String id) async {
    final result = await DioHelper.getData(
      url: "${UrlConstants.userData}$id", query: {},
    );
    return UserData.fromJson(result.data);
  }
}
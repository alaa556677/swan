import 'package:swan/core/url_constants.dart';

import '../../../../core/network/dio_helper.dart';
import '../model/login_model.dart';

class LoginDataSource{
  Future <LoginModel> loginMethod(String email, String password) async {
    final result = await DioHelper.postData(
      url: UrlConstants.loginUrl,
      data: {
        "email" : email,
        "password" : password
      },
    );
    return LoginModel.fromJson(result.data);
  }
}

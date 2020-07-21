import 'package:qr_code_app/ApiProvider.dart';
import 'package:qr_code_app/page/login/login.model.dart';
import 'package:qr_code_app/page/user/model/user_me.dart';

class UserRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<UserMeResponse> getMeRepository() {
    return _apiProvider.getMe();
  }

   Future<UserMeResponse> changePass(pass, newPass, rePass) {
    return _apiProvider.changePass(pass, newPass, rePass);

  }
}

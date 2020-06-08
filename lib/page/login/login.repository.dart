import 'package:qr_code_app/ApiProvider.dart';
import 'package:qr_code_app/page/login/login.model.dart';

class LoginRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<LoginResponse> loginRepository(identity, email) {
    return _apiProvider.login(identity, email);
  }
}

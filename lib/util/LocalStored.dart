import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static LocalStore _instance;
  static SharedPreferences _sharedPreferences;
  static const TOKEN_KEY = "TOKEN_KEY";
  static const USER_INFO = "USER_INFO";

  static Future<LocalStore> getInstance() async {
    if (_instance == null) {
      _instance = LocalStore();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

//TODO Save token
  static void saveToken(String token) {
    print(token is String);
    print(token.toString());
    _sharedPreferences.setString(TOKEN_KEY, token);
  }

  //TODO Get token
  static Future<String> getToken() async {
//    if (APIProvider().accessToken != null && APIProvider().accessToken.isEmpty) {
    String token = await _sharedPreferences.getString(TOKEN_KEY);
//      APIProvider().accessToken = token;
    return token;
//    }
//    return APIProvider().accessToken;
  }

  //TODO Save user
  static void saveUserInfor(String data) {
    _sharedPreferences.setString(USER_INFO, data);
  }

  //TODO get user
  static Future<String> getUserInfor() async {
    String user = await _sharedPreferences.getString(USER_INFO);
    return user;
  }
}

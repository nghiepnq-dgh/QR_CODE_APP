import 'package:dio/dio.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';
import 'package:qr_code_app/page/login/login.model.dart';
import 'package:qr_code_app/page/user/model/user_me.dart';
import 'package:qr_code_app/util/LocalStored.dart';

class ApiProvider {
  Dio _dio;
  static final ApiProvider _singleton = ApiProvider._internal();
  factory ApiProvider() {
    return _singleton;
  }
  ApiProvider._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: "http://192.168.1.9:3000/",
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
      contentType: Headers.jsonContentType, responseType: ResponseType.json,
      validateStatus: (_) => true,
      followRedirects: false,
    );
    _dio = new Dio(options);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      String path = options.path;
      if (!path.contains("auth/login") && !path.contains("auth/me")) {
        //TODO somethings
      } else {
        String token = await LocalStore.getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer " + token;
        }
      }
    }));
  }

  //TODO Login
  Future<LoginResponse> login(identity, password) async {
    Response response;
    try {
      response = await _dio.post("auth/signin",
          data: {"identity": identity, "password": password});
      return LoginResponse.fromJson(response?.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.fromJson(response?.data);
    }
  }

  Future<UserMeResponse> getMe() async {
    try {
      Response response = await _dio.post("auth/me");
      return UserMeResponse.fromJson(response?.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<DocumentsResponse> listDocuments() async {
    Response response;
    try {
      response = await _dio.get("document");
      return DocumentsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DocumentsResponse.fromJson(response?.data);
    }
  }
}


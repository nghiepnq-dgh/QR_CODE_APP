import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_app/page/home/HomePage.dart';
import 'package:qr_code_app/page/login/login.model.dart';
import 'package:qr_code_app/page/user/model/user_me.dart';
import 'package:qr_code_app/util/LocalStored.dart';
import 'package:qr_code_app/util/Navigation.dart';

class ApiProvider {
  Dio _dio;
  static final ApiProvider _singleton = ApiProvider._internal();
  factory ApiProvider() {
    return _singleton;
  }
  ApiProvider._internal() {
    BaseOptions options = new BaseOptions(
       baseUrl: "http://192.168.1.9:3000/",
//      baseUrl: "localhost:3000/",
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
//      _handleError(error);
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
}

String _handleError(Error error) {
  String errorDescription = "";
  if (error is DioError) {
    DioError dioError = error as DioError;
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
            "Received invalid status code: ${dioError.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
  } else {
    errorDescription = "Unexpected error occured";
  }
  return errorDescription;
}

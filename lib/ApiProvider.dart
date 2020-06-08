import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_app/page/login/login.model.dart';

class ApiProvider {
  BuildContext mContext;
  static BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.100.10:3000/",
    connectTimeout: 60 * 1000, // 60 seconds
    receiveTimeout: 60 * 1000, // 60 seconds
    contentType: Headers.jsonContentType, responseType: ResponseType.json,
    validateStatus: (_) => true,
    followRedirects: false,
  );
  Dio _dio = new Dio(options);
  Future<LoginResponse> login(identity, password) async {
    Response response;
    try {
      response = await _dio
          .post("auth/signin", data: {"identity": identity, "password": password});
      return LoginResponse.fromJson(response?.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
//      _handleError(error);
      return LoginResponse.fromJson(response.data);
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

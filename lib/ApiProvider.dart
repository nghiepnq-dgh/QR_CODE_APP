import 'package:dio/dio.dart';
import 'package:load/load.dart';
import 'package:qr_code_app/page/document/model/doc_detail.model.dart';
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
      baseUrl: "http://localhost:3000/",
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
      String token = await LocalStore.getToken();
      if (!path.contains("auth/signin") && token != null) {
        //TODO somethings
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

  Future<DocumentsResponse> listDocuments(query) async {
    Response response;
    try {
      showLoadingDialog();
      response = await _dio.get("document", queryParameters: query);
      hideLoadingDialog();
      return DocumentsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DocumentsResponse.fromJson(response?.data);
    }
  }

  Future<DocumentDetailResponse>getDocId(id) async {
    Response response;
      try {
      showLoadingDialog();
      response = await _dio.get("document/$id");
      hideLoadingDialog();
      return DocumentDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DocumentDetailResponse.fromJson(response?.data);
    }
  }

   Future<DocumentDetailResponse>updateDoc(id, data) async {
    Response response;
      try {
      showLoadingDialog();
      response = await _dio.put("document/$id", data: data);
      hideLoadingDialog();
      return DocumentDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DocumentDetailResponse.fromJson(response?.data);
    }
  }
}


import 'package:qr_code_app/util/Base_Response.dart';

class LoginResponse extends BaseResponse {
  int statusCode;

  bool success;
  String acccessToken;

  LoginResponse({this.statusCode, this.success, this.acccessToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    acccessToken = json['acccessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['acccessToken'] = this.acccessToken;
    return data;
  }
}

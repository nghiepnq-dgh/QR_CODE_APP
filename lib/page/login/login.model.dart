class LoginResponse {
  int statusCode;
  String message;
  String error;
  bool success;
  String acccessToken;

  LoginResponse(
      {this.statusCode,
        this.message,
        this.error,
        this.success,
        this.acccessToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
    success = json['success'];
    acccessToken = json['acccessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    data['success'] = this.success;
    data['acccessToken'] = this.acccessToken;
    return data;
  }
}
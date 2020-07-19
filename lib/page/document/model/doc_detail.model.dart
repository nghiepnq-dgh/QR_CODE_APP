class DocumentDetailResponse {
  String id;
  String contend;
  String status;
  String reason;
  User user;
  int statusCode;
  String message;
  String error;
  String room;

  DocumentDetailResponse(
      {this.id,
      this.contend,
      this.status,
      this.reason,
      this.user,
      this.statusCode,
      this.message,
      this.error,
      this.room});

  DocumentDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contend = json['contend'];
    status = json['status'];
    reason = json['reason'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contend'] = this.contend;
    data['status'] = this.status;
    data['reason'] = this.reason;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    data['room'] = this.room;
    return data;
  }
}

class User {
  int id;
  String email;
  String name;
  String password;
  String address;
  String identity;
  String role;
  String salt;

  User(
      {this.id,
      this.email,
      this.name,
      this.password,
      this.address,
      this.identity,
      this.role,
      this.salt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    address = json['address'];
    identity = json['identity'];
    role = json['role'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['address'] = this.address;
    data['identity'] = this.identity;
    data['role'] = this.role;
    data['salt'] = this.salt;
    return data;
  }
}

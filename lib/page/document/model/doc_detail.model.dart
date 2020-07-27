class DocumentDetailResponse {
  User user;
  String contend;
  List<Rooms> rooms;
  String id;
  String reason;
  String status;
  bool success;
  int statusCode;
  String message;
  String error;
  DocumentDetailResponse(
      {this.user,
      this.contend,
      this.rooms,
      this.id,
      this.reason,
      this.status,
        this.statusCode,
      this.message,
      this.error,
      this.success});

  DocumentDetailResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    contend = json['contend'];
    if (json['rooms'] != null) {
      rooms = new List<Rooms>();
      json['rooms'].forEach((v) {
        rooms.add(new Rooms.fromJson(v));
      });
    }
    id = json['id'];
    reason = json['reason'];
    status = json['status'];
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['contend'] = this.contend;
    if (this.rooms != null) {
      data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
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

class Rooms {
  int id;
  String type;
  String createdAt;
  String updatedAt;

  Rooms({this.id, this.type, this.createdAt, this.updatedAt});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

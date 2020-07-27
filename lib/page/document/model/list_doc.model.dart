import 'package:qr_code_app/util/Base_Response.dart';

class DocumentsResponse extends BaseResponse {
  List<Data> data;
  int total;

  DocumentsResponse({this.data, this.total});

  DocumentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    total = json['total'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String id;
  String contend;
  String status;
  String reason;
  User user;
  List<Rooms> rooms;

  Data(
      {this.id, this.contend, this.status, this.reason, this.user, this.rooms});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contend = json['contend'];
    status = json['status'];
    reason = json['reason'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['rooms'] != null) {
      rooms = new List<Rooms>();
      json['rooms'].forEach((v) {
        rooms.add(new Rooms.fromJson(v));
      });
    }
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
    if (this.rooms != null) {
      data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
    }
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

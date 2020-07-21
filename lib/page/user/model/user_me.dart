class UserMeResponse {
  int id;
  String email;
  String name;
  String address;
  String identity;
  String role;
  String salt;
  bool success;
  String message;

  UserMeResponse(
      {this.id,
      this.email,
      this.name,
      this.address,
      this.identity,
      this.role,
      this.success,
      this.message});

  UserMeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    address = json['address'];
    identity = json['identity'];
    role = json['role'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['address'] = this.address;
    data['identity'] = this.identity;
    data['role'] = this.role;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

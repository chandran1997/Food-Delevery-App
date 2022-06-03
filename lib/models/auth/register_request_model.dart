

class RegisterRequestModel {
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  int? phone;
  String? role;

  RegisterRequestModel(
      {this.username,
      this.email,
      this.password,
      this.role,
      this.phone,
      this.confirmPassword});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['conformPassword'];
    // phone = json['phone'];
    // role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['conformPassword'] = this.confirmPassword;
    // data['phone'] = this.phone;
    // data['role'] = this.role;
    return data;
  }
}

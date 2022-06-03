class UserModel {
  String? msg;
  Payload? payload;
  Payload? get userDetails => payload!;

  UserModel({this.msg, this.payload});

  UserModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? username;
  String? email;
  String? createdAt;

  Payload({this.username, this.email, this.createdAt});

  Payload.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    return data;
  }
}


import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
    
class LoginResponseModel {
  String? msg;
  Payload? payload;

  LoginResponseModel({this.msg, this.payload});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    payload =
        json['payload'] != null ?  Payload.fromJson(json['payload']) : null;
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
  String? acessToken;
  String? iD;

  Payload({this.acessToken, this.iD});

  Payload.fromJson(Map<String, dynamic> json) {
    acessToken = json['AcessToken'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AcessToken'] = this.acessToken;
    data['ID'] = this.iD;
    return data;
  }
}
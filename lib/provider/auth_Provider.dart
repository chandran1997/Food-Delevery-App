import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delevery_app/Utilis/app_constant.dart';
import 'package:food_delevery_app/models/auth/login_response_model.dart';
import 'package:food_delevery_app/models/auth/register_response_model.dart';

import 'package:food_delevery_app/provider/shared_service_provider.dart';
import 'package:http/http.dart' as http;
import '../models/AUTH/login_request_model.dart';
import '../models/auth/register_request_model.dart';
import '../models/user_model.dart';

class APIService extends ChangeNotifier {
  static var client = http.Client();
  bool _isloading = false;
  bool get isloading => _isloading;

  late UserModel userModel;

  Future<bool> login(LoginRequestModel model) async {
    try {
      _isloading = true;
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      //https://e-commerce-node-deploy.herokuapp.com/api/auth/login
      var url = Uri.https(AppConstants.baseUrl, AppConstants.login);
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        _isloading = false;
        //SHARED
        await SharedServices.setLoginDetails(loginResponseJson(response.body));
        print("My token " + response.body.toString());

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    _isloading = true;
    var url = Uri.http(AppConstants.baseUrl, AppConstants.register);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    notifyListeners();
    return registerResponseModel(response.body);
  }

  Future<String> getUserProfile() async {
    _isloading = true;
    notifyListeners();
    var loginDetails = await SharedServices.loginDetails();

    Map<String, String> resquestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.payload!.acessToken}'
    };
    print("${loginDetails.payload!.acessToken}");
    // var url = Uri.https(AppConstants.baseUrl, AppConstants.userProfileAPI);

    var response = await client.get(
      Uri.parse(AppConstants.https +
          AppConstants.userProfileAPI +
          "${loginDetails.payload!.iD}"),
      headers: resquestHeaders,
    );

    if (response.statusCode == 200) {
      _isloading = false;
      userModel = UserModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      return response.body;
    } else {
      throw Exception("error");
    }
  }
}

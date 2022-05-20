import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delevery_app/Utilis/app_constant.dart';
import 'package:food_delevery_app/models/auth/login_response_model.dart';

import 'package:food_delevery_app/models/auth/register_response_model.dart';

import 'package:food_delevery_app/provider/shared_service_provider.dart';

import 'package:http/http.dart' as http;

import '../models/AUTH/login_request_model.dart';
import '../models/auth/register_request_model.dart';

class APIService extends ChangeNotifier {
  static var client = http.Client();

  SharedServices sharedServices = SharedServices();

  Future<bool> login(LoginRequestModel model) async {
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
      //SHARED
      await sharedServices.setLoginDetails(loginResponseJson(response.body));
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
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
    var loginDetails = await sharedServices.loginDetails();

    Map<String, String> resquestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.payload!.acessToken}'
    };

    var url = Uri.https(AppConstants.baseUrl, AppConstants.userProfileAPI);

    var response = await client.get(
      url,
      headers: resquestHeaders,
    );

    if (response.statusCode == 200) {
      notifyListeners();
      return response.body;
    } else {
      return "";
    }
  }
}

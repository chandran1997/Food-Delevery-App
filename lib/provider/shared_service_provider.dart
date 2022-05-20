import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delevery_app/Screens/auth/singnIn_page.dart';
import 'package:food_delevery_app/models/auth/login_response_model.dart';
import 'package:get/get.dart';

class SharedServices extends ChangeNotifier {
  Future<bool> isLoggedIn() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");
    notifyListeners();
    return isKeyExist;
  }

  Future<LoginResponseModel?> loginDetails() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      notifyListeners();
      return loginResponseJson(cacheData.syncData);
    }
  }

  Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBNodel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(model.toJson()),
    );
    notifyListeners();
    await APICacheManager().addCacheData(cacheDBNodel);
  }

  Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
        (route) => false);
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

import '../Utilis/app_constant.dart';
import 'package:http/http.dart' as http;

import '../models/popular_Product_Model.dart';


class RecommendedProductProvider extends ChangeNotifier {
  static var client = http.Client();

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  Future<void> getRecommendedProduct() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(AppConstants.baseUrl, AppConstants.getProduct);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    // var response = await http.get(
    //     Uri.parse('https://e-commerce-node-deploy.herokuapp.comapi/product/recommended'));

    if (response.statusCode == 200) {
      // print("got product");
      _recommendedProductList = [];
      _recommendedProductList.addAll(
          PopularProductModel.fromJson(jsonDecode(response.body)).products);

      _isLoaded = true;
      notifyListeners();
    } else {
      print("cound not get the product");
    }
  }
}

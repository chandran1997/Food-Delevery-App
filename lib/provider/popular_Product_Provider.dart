import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delevery_app/provider/Cart_provider.dart';
import 'package:get/get.dart';

import '../Utilis/app_constant.dart';
import '../Utilis/colors.dart';
import '../models/popular_Product_Model.dart';
import 'package:http/http.dart' as http;

import '../models/cart_model.dart';

class PopularProductProvider extends ChangeNotifier {
  static var client = http.Client();
  CartProvider? _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCardItems = 0;
  int get inCardItems => _inCardItems + _quantity;

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProduct() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(AppConstants.baseUrl, AppConstants.getProduct);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      // print("got product");
      _popularProductList = [];
      _popularProductList.addAll(
          PopularProductModel.fromJson(jsonDecode(response.body)).products);

      _isLoaded = true;
      notifyListeners();
    } else {
      print("cound not get the product");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      // print("increment" + _quantity.toString());
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("decrement" + _quantity.toString());
    }
    notifyListeners();
  }

  int checkQuantity(int quantity) {
    if ((_inCardItems + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more !",
        backgroundColor: AppColors.maincolor,
        colorText: Colors.white,
      );
      if (_inCardItems > 0) {
        _quantity = -_inCardItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCardItems + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more !",
        backgroundColor: AppColors.maincolor,
        colorText: Colors.white,
      );
      if (_inCardItems > 20) {
        _quantity = -_inCardItems;
        return _quantity;
      }
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(PopularModel product, CartProvider cart) {
    _quantity = 0;
    _inCardItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart!.existInCard(product);
    //if exist
    //get from storage _inCardItems=3

    // print("Exist or not " + exist.toString());

    if (exist) {
      _inCardItems = _cart!.getQuantity(product);
    }

    // print("The Quantity in the cart is  " + _inCardItems.toString());
  }

  void addItem(PopularModel product) {
    _cart!.addItem(product, _quantity);
    _quantity = 0;
    _inCardItems = _cart!.getQuantity(product);

    _cart!.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          " The Quantity is " +
          value.quantity.toString());
    });

    notifyListeners();
  }

  void addtocardPageItems(PopularModel product, int quantity) {
    _cart!.addItem(product, quantity);
    notifyListeners();
  }

  int get totalItems {
    return _cart!.totalItems;
  }

  List<CartModel> get getItems {
    return _cart!.getItems;
  }
}

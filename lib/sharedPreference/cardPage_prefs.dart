import 'dart:convert';

import 'package:food_delevery_app/Utilis/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

class CardPrefs {
  static late SharedPreferences prefs;
  static bool _init = false;
  static Future init() async {
    if (_init) return;
    prefs = await SharedPreferences.getInstance();
    _init = true;
    return prefs;
  }

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCardList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }
    prefs.setStringList(AppConstants.CART_LIST, cart);
    // print(prefs.getStringList(AppConstants.CART_LIST));
    getCardList();
  }

  List<CartModel> getCardList() {
    List<String> cart = [];

    if (prefs.containsKey(AppConstants.CART_LIST)) {
      cart = prefs.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList " + cart.toString());
    }
    List<CartModel> cartList = [];
    for (var element in cart) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (prefs.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];

      cartHistory = prefs.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];

    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void addToCartHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = prefs.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();
    prefs.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  removeCart() async {
    cart = [];
    prefs.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    prefs.remove(AppConstants.CART_HISTORY_LIST);
  }
}

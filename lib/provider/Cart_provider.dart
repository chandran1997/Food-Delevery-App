import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:food_delevery_app/models/cart_model.dart';
import 'package:food_delevery_app/provider/popular_Product_Provider.dart';

import '../Utilis/colors.dart';
import '../models/popular_Product_Model.dart';
import '../sharedPreference/cardPage_prefs.dart';

class CartProvider extends ChangeNotifier {
  // PopularProductProvider popularProductProvider;
  // CartProvider({
  //   required this.popularProductProvider,
  // });
  CardPrefs cardPrefs = CardPrefs();
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(PopularModel product, int quantity) {
    // print("length of the items is " + _items.length.toString());
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add an one item in the cart !",
          backgroundColor: AppColors.maincolor,
          colorText: Colors.white,
        );
      }
    }
    cardPrefs.addToCardList(getItems);
    notifyListeners();
  }

  bool existInCard(PopularModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

//quantity value store in app
  int getQuantity(PopularModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    //update
    notifyListeners();
    return totalQuantity;
  }

  List<CartModel> get getItems {
    //entries helps to create another map
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  List<CartModel> getCardData() {
    setCart = cardPrefs.getCardList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("Length of cart items " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(
        storageItems[i].product!.id!,
        () => storageItems[i],
      );
    }
  }

  void addTocardHistory() {
    cardPrefs.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  List<CartModel> getCartHistoryList() {
    return cardPrefs.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addtoCardList() {
    cardPrefs.addToCardList(getItems);
    notifyListeners();
  }

  void clearCartHistory() {
    cardPrefs.clearCartHistory();
    notifyListeners();
  }
}

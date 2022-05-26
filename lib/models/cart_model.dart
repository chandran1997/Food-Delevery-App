import 'package:food_delevery_app/models/popular_Product_Model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  PopularModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = PopularModel.fromJson(json['product']);
  }

  // Map<String, Object?> toMap() {
  //   return {
  //     "id": id,
  //     "name": name,
  //     "price": price,
  //     "img": img,
  //     "quantity": quantity,
  //     "isExist": isExist,
  //     "time": time
  //   };
  // }
}

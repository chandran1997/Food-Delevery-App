import 'dart:convert';

PopularProductModel popularProductJson(String str) =>
    PopularProductModel.fromJson(json.decode(str));

class PopularProductModel {
  String? msg;
  List<PopularModel>? payload;
  List<PopularModel> get products => payload!;

  PopularProductModel({this.msg, this.payload});

  PopularProductModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['payload'] != null) {
      payload = <PopularModel>[];
      json['payload'].forEach((v) {
        payload!.add(PopularModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = msg;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopularModel {
  bool? isPopular;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  int? typeId;

  PopularModel(
      {this.isPopular,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.typeId});

  PopularModel.fromJson(Map<String, dynamic> json) {
    isPopular = json['is_popular'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_popular'] = isPopular;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stars'] = stars;
    data['img'] = img;
    data['location'] = location;
    data['type_id'] = typeId;
    return data;
  }
}

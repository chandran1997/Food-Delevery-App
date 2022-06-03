import 'dart:core';

import 'package:flutter/material.dart';

import 'package:food_delevery_app/Utilis/app_constant.dart';
import 'package:food_delevery_app/provider/Cart_provider.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../Utilis/colors.dart';
import '../../provider/popular_Product_Provider.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../carts/cart_page.dart';
import '/Utilis/dimensions.dart';
import '/widgets/app_icon.dart';
import '/widgets/expandable_text_widgets.dart';

class PopularFoodDetails extends StatefulWidget {
  int pageId;
  PopularFoodDetails({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<PopularProductProvider>(context, listen: false)
        .popularProductList[widget.pageId];
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    Provider.of<PopularProductProvider>(context, listen: false)
        .initProduct(product, cartProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite, //its take all the available space
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "${AppConstants.getImageUrl + product.img!}"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                Consumer<CartProvider>(builder: (context, controller, child) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CartPages()));
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.maincolor,
                                ))
                            : Container(),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 4,
                                top: 4,
                                child: BigText(
                                  text: controller.totalItems.toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: "${product.name!}",
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: 'Introduce'),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  //Expandable text widgets
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ExpandableTextWidgets(
                          text: product.description!.toString()),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Consumer<PopularProductProvider>(
        builder: (context, popularProduct, child) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width30,
              right: Dimensions.width30,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.appsignColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(
                        text: popularProduct.inCardItems.toString(),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.appsignColor,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.maincolor,
                    ),
                    child: BigText(
                      text: "${product.price!} | Add to card",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delevery_app/Screens/carts/cart_page.dart';
import 'package:food_delevery_app/Utilis/app_constant.dart';
import 'package:food_delevery_app/Utilis/colors.dart';
import 'package:food_delevery_app/Utilis/dimensions.dart';
import 'package:food_delevery_app/models/cart_model.dart';
import 'package:food_delevery_app/provider/Cart_provider.dart';
import 'package:food_delevery_app/widgets/app_icon.dart';
import 'package:food_delevery_app/widgets/big_text.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../base/no_data_page.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Provider.of<CartProvider>(context, listen: false)
        .getCartHistoryList()
        .reversed
        .toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    print(cartItemsPerOrder.toString());
    //print the cetain value
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    print(itemsPerOrder);

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormate = DateFormat('MM/dd/yyyy hh:mm a');
         outputDate = outputFormate.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 9,
            color: AppColors.maincolor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.maincolor,
                ),
              ],
            ),
          ),
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
            return cartProvider.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: Dimensions.height20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Immediately-invoked Function
                                    // (() {
                                    //  return
                                    // }()),
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    height:
                                                        Dimensions.height20 * 4,
                                                    width:
                                                        Dimensions.height20 * 4,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(AppConstants
                                                                  .getImageUrl +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2)),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        Container(
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SmallText(
                                                text: "Total",
                                                color: Color(0xff0c1517),
                                              ),
                                              BigText(
                                                text: itemsPerOrder[i]
                                                        .toString() +
                                                    " Items",
                                                color: Color(0xff0c1517),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .setItems = moreOrder;
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .addtoCardList();

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const CartPages()));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimensions.width10 /
                                                              2,
                                                      vertical:
                                                          Dimensions.width10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                3),
                                                    border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.maincolor,
                                                    ),
                                                  ),
                                                  child: SmallText(
                                                    text: "one more",
                                                    color: AppColors.maincolor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: NoDataPage(
                        text: "Your didn't buy anything so far !",
                        imgPath: "assets/history.png",
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}

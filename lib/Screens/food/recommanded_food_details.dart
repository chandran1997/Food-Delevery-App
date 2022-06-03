import 'package:flutter/material.dart';
import 'package:food_delevery_app/Utilis/app_constant.dart';
import 'package:food_delevery_app/provider/Cart_provider.dart';
import 'package:provider/provider.dart';

import 'package:food_delevery_app/provider/recommended_Product_Provider.dart';

import '../../provider/popular_Product_Provider.dart';
import '../carts/cart_page.dart';
import '/Utilis/colors.dart';
import '/Utilis/dimensions.dart';
import '/widgets/app_icon.dart';
import '/widgets/big_text.dart';
import '/widgets/expandable_text_widgets.dart';

class RecommandedFoodDetails extends StatelessWidget {
  int pageId;
  RecommandedFoodDetails({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedProduct =
        Provider.of<RecommendedProductProvider>(context, listen: false)
            .recommendedProductList[pageId];
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    Provider.of<PopularProductProvider>(context, listen: false)
        .initProduct(recommendedProduct, cartProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcon(icon: Icons.clear),
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                  child: BigText(
                    text: recommendedProduct.name!,
                    size: Dimensions.font26,
                  ),
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.getImageUrl + recommendedProduct.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: ExpandableTextWidgets(
                    text: recommendedProduct.description!),
              )
            ],
          )),
        ],
      ),
      bottomNavigationBar: Consumer<PopularProductProvider>(
          builder: (context, controller, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20 * 3,
                right: Dimensions.width20 * 3,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.maincolor,
                        icon: Icons.remove),
                  ),
                  BigText(
                    text: "${recommendedProduct.price} " +
                        " X " +
                        " ${controller.inCardItems}",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.maincolor,
                        icon: Icons.add),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.addItem(recommendedProduct);
              },
              child: Container(
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.maincolor,
                        )),
                    Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width30,
                        right: Dimensions.width30,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.maincolor,
                      ),
                      child: BigText(
                        text: "${recommendedProduct.price} | Add to card",
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

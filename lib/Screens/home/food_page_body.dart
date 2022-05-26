import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:food_delevery_app/Screens/food/popular_food_details.dart';
import 'package:food_delevery_app/Screens/food/recommanded_food_details.dart';
import 'package:food_delevery_app/Utilis/app_constant.dart';
import 'package:food_delevery_app/models/popular_Product_Model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/popular_Product_Provider.dart';
import '../../provider/recommended_Product_Provider.dart';
import '/Utilis/colors.dart';
import '/Utilis/dimensions.dart';
import '/widgets/app_column.dart';
import '/widgets/big_text.dart';
import '/widgets/icon_and_text_widget.dart';
import '/widgets/small_text.dart';
import 'package:flutter/material.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentpageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentpageValue = pageController.page!;
      });
    });
    Provider.of<PopularProductProvider>(context, listen: false);
    Provider.of<RecommendedProductProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var popularProduct = Provider.of<PopularProductProvider>(context);
    var recommendedProduct = Provider.of<RecommendedProductProvider>(context);
    return Column(
      children: [
        //slider Section
        // Consumer<PopularProductProvider>(
        //     builder: (context, popularProduct, child) {
        //   return popularProduct.isLoaded
        //       ?
        //       : Text("${popularProduct.i}");
        // }),

        FutureBuilder(
            future: popularProduct.getPopularProduct(),
            builder: (context, snapshot) {
              return popularProduct.isLoaded
                  ? Container(
                      // color: Colors.green,
                      height: Dimensions.pageView,
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: popularProduct.popularProductList.length,
                          itemBuilder: (context, position) {
                            return _buildPageITem(
                              position,
                              popularProduct.popularProductList[position],
                            );
                          }),
                    )
                  : CircularProgressIndicator(
                      color: AppColors.maincolor,
                    );
            }),

        //dots
        FutureBuilder(
            future: popularProduct.getPopularProduct(),
            builder: (context, snapshot) {
              return popularProduct.isLoaded
                  ? DotsIndicator(
                      dotsCount: popularProduct.popularProductList.length,
                      position: _currentpageValue,
                      decorator: DotsDecorator(
                        activeColor: AppColors.maincolor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )
                  : DotsIndicator(
                      dotsCount: 1,
                      position: _currentpageValue,
                      decorator: DotsDecorator(
                        activeColor: AppColors.maincolor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    );
            }),

        //popular text
        SizedBox(height: Dimensions.height30),
        Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: 'Recommended'),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  child: SmallText(
                    text: 'Food pairing',
                  ),
                ),
              ],
            )),

        //list of food and images
        FutureBuilder(
            future: recommendedProduct.getRecommendedProduct(),
            builder: (context, snapshot) {
              return recommendedProduct.isLoaded
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          recommendedProduct.recommendedProductList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return RecommandedFoodDetails(
                                  pageId: index,
                                );
                              }),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                                bottom: Dimensions.height10),
                            child: Row(
                              children: [
                                //image section
                                Container(
                                  width: Dimensions.listviewImgSize,
                                  height: Dimensions.listviewImgSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    image: DecorationImage(
                                        image: NetworkImage(AppConstants
                                                .getImageUrl +
                                            recommendedProduct
                                                .recommendedProductList[index]
                                                .img!),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                //text container
                                Expanded(
                                  child: Container(
                                    height: Dimensions.listviewTextcontSize,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                Dimensions.radius20),
                                            bottomRight: Radius.circular(
                                                Dimensions.radius20)),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: Dimensions.width15,
                                        right: Dimensions.width15,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                              text: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .name!),
                                          SizedBox(height: Dimensions.height10),
                                          SmallText(
                                              text: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .description!),

                                          SizedBox(height: Dimensions.height10),
                                          //time and distance
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: 'Normal',
                                                iconcolor: AppColors.iconcolor1,
                                              ),
                                              IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: '1.7km',
                                                iconcolor: AppColors.maincolor,
                                              ),
                                              IconAndTextWidget(
                                                icon: Icons.access_time_rounded,
                                                text: '32min',
                                                iconcolor: AppColors.iconcolor2,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : CircularProgressIndicator(
                      color: AppColors.maincolor,
                    );
            }),
      ],
    );
  }

  Widget _buildPageITem(int index, PopularModel model) {
    // x, y, z axis
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentpageValue.floor()) {
      var currentScale = 1 - (_currentpageValue - index) * (1 - _scaleFactor);
      var currentTransformation = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransformation, 0);
    } else if (index == _currentpageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentpageValue - index + 1) * (1 - _scaleFactor);
      var currentTransformation = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransformation, 0);
    } else if (index == _currentpageValue.floor() - 1) {
      var currentScale = 1 - (_currentpageValue - index) * (1 - _scaleFactor);
      var currentTransformation = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransformation, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PopularFoodDetails(
                    pageId: index,
                  )));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xff69c5df)
                    : const Color(0xff9294cc),
                image: DecorationImage(
                    //  "https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?cs=srgb&dl=pexels-lisa-fotios-1279330.jpg&fm=jpg"
                    image: NetworkImage(AppConstants.getImageUrl + model.img!),
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.height15,
                      right: Dimensions.height15),
                  child: AppColumn(
                    text: model.name!,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import '/Utilis/colors.dart';
import '/Utilis/dimensions.dart';
import '/widgets/app_icon.dart';
import '/widgets/big_text.dart';
import '/widgets/expandable_text_widgets.dart';
import 'package:flutter/material.dart';

class RecommandedFoodDetails extends StatelessWidget {
  const RecommandedFoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                  child: BigText(
                    text: "Chenese Side",
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
                "https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?cs=srgb&dl=pexels-lisa-fotios-1279330.jpg&fm=jpg",
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
                    text:
                        " One method of preparing chow mein noodles is to fry them separately into a “noodle pancake” and then pour the stir-fried meat and vegetables over the fried noodles. The chow mein noodles can also be stir-fried with meat/poultry and vegetables.With lo mein, the parboiled noodles are frequently added near the end of cooking to heat through and toss with the other ingredients and sauce. Alternately, the parboiled noodles may be tossed with a sauce and the stir-fried ingredients poured over.Since the real star of any lo mein dish is the sauce, it's not surprising that lo mein recipes often use more sauce than chow mein recipes. One method of preparing chow mein noodles is to fry them separately into a “noodle pancake” and then pour the stir-fried meat and vegetables over the fried noodles. The chow mein noodles can also be stir-fried with meat/poultry and vegetables.With lo mein, the parboiled noodles are frequently added near the end of cooking to heat through and toss with the other ingredients and sauce. Alternately, the parboiled noodles may be tossed with a sauce and the stir-fried ingredients poured over.Since the real star of any lo mein dish is the sauce, it's not surprising that lo mein recipes often use more sauce than chow mein recipes. One method of preparing chow mein noodles is to fry them separately into a “noodle pancake” and then pour the stir-fried meat and vegetables over the fried noodles. The chow mein noodles can also be stir-fried with meat/poultry and vegetables.With lo mein, the parboiled noodles are frequently added near the end of cooking to heat through and toss with the other ingredients and sauce. Alternately, the parboiled noodles may be tossed with a sauce and the stir-fried ingredients poured over.Since the real star of any lo mein dish is the sauce, it's not surprising that lo mein recipes often use more sauce than chow mein recipes. One method of preparing chow mein noodles is to fry them separately into a “noodle pancake” and then pour the stir-fried meat and vegetables over the fried noodles. The chow mein noodles can also be stir-fried with meat/poultry and vegetables.With lo mein, the parboiled noodles are frequently added near the end of cooking to heat through and toss with the other ingredients and sauce. Alternately, the parboiled noodles may be tossed with a sauce and the stir-fried ingredients poured over.Since the real star of any lo mein dish is the sauce, it's not surprising that lo mein recipes often use more sauce than chow mein recipes. One method of preparing chow mein noodles is to fry them separately into a “noodle pancake” and then pour the stir-fried meat and vegetables over the fried noodles. The chow mein noodles can also be stir-fried with meat/poultry and vegetables.With lo mein, the parboiled noodles are frequently added near the end of cooking to heat through and toss with the other ingredients and sauce. Alternately, the parboiled noodles may be tossed with a sauce and the stir-fried ingredients poured over.Since the real star of any lo mein dish is the sauce, it's not surprising that lo mein recipes often use more sauce than chow mein recipes."),
              )
            ],
          )),
        ],
      ),
      bottomNavigationBar: Column(
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
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.maincolor,
                    icon: Icons.remove),
                BigText(
                  text: "\$12.88 " + " X " + " 0 ",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.maincolor,
                    icon: Icons.add),
              ],
            ),
          ),
          Container(
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
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.maincolor,
                  ),
                  child: BigText(
                    text: "\$10 | Add to card",
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

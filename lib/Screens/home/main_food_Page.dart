import 'package:food_delevery_app/provider/shared_service_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/show_custom_snackBar.dart';
import '../../provider/auth_Provider.dart';
import '/Utilis/colors.dart';
import '/Utilis/dimensions.dart';
import '/widgets/big_text.dart';
import '/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<SharedServices>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var sharedServices = Provider.of<SharedServices>(context);
    // print('height +${MediaQuery.of(context).size.height}');
    // print('width +${MediaQuery.of(context).size.width}');
    return Scaffold(
        body: Column(
      children: [
        //showing the header
        Container(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'Bangladesh',
                      color: AppColors.maincolor,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: 'Naringdi',
                          color: Colors.black45,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    ),
                  ],
                ),
                SizedBox(width: Dimensions.width20 * 8),
                GestureDetector(
                  onTap: () {
                    sharedServices.logout(context).then((value) {
                      print("SuccessFully Logout");
                      showCustomSnackBar("SuccessFully Logout",
                          title: "Success", background: AppColors.maincolor);
                    });
                  },
                  child: Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.maincolor),
                      child: Icon(
                        Icons.logout_sharp,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.maincolor),
                    child: Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //showing the body
        const Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: FoodPageBody(),
          ),
        ),
      ],
    ));
  }
}

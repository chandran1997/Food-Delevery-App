import 'package:flutter/material.dart';
import 'package:food_delevery_app/Screens/auth/singnIn_page.dart';
import 'package:food_delevery_app/base/custom_loader.dart';

import 'package:food_delevery_app/provider/Cart_provider.dart';
import 'package:food_delevery_app/provider/shared_service_provider.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_Provider.dart';
import '../../Utilis/colors.dart';
import '../../Utilis/dimensions.dart';

import '../../base/show_custom_snackBar.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<APIService>(context, listen: false).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.maincolor,
        title: Center(
          child: BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<APIService>(context, listen: false).getUserProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height20),
              child: Column(
                children: [
                  //profile icon
                  AppIcon(
                    icon: Icons.person,
                    size: Dimensions.height15 * 10,
                    backgroundColor: AppColors.maincolor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height45 + Dimensions.height30,
                  ),
                  SizedBox(height: Dimensions.height30),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          //name
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.person,
                              size: Dimensions.height10 * 5,
                              backgroundColor: AppColors.maincolor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                            ),
                            bigText: BigText(
                                text: Provider.of<APIService>(context)
                                    .userModel
                                    .payload!
                                    .username!
                                    .toString()),
                          ),
                          SizedBox(height: Dimensions.height30),

                          //email
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.email,
                              size: Dimensions.height10 * 5,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                            ),
                            bigText: BigText(
                                text: Provider.of<APIService>(context)
                                    .userModel
                                    .payload!
                                    .email!
                                    .toString()),
                          ),
                          SizedBox(height: Dimensions.height30),
                          //address
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.location_on,
                              size: Dimensions.height10 * 5,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                            ),
                            bigText: BigText(text: "Fill in your address"),
                          ),
                          SizedBox(height: Dimensions.height30),
                          //message
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.message_outlined,
                              size: Dimensions.height10 * 5,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                            ),
                            bigText: BigText(text: "Message"),
                          ),
                          SizedBox(height: Dimensions.height30),
                          //message
                          GestureDetector(
                            onTap: () {
                              // bool _result = await SharedServices.isLoggedIn();

                              // if (_result) {
                              Provider.of<CartProvider>(context, listen: false)
                                  .clear();
                              Provider.of<CartProvider>(context, listen: false)
                                  .clearCartHistory();
                              SharedServices.logout(context).then((value) {
                                print("SuccessFully Logout");
                                showCustomSnackBar("SuccessFully Logout",
                                    title: "Success",
                                    background: AppColors.maincolor);
                              });
                              // }
                            },
                            child: AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.logout,
                                size: Dimensions.height10 * 5,
                                backgroundColor: Colors.redAccent,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                              ),
                              bigText: BigText(text: "Logout"),
                            ),
                          ),
                          SizedBox(height: Dimensions.height30),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const CustomLoader();
          }
        },
      ),
    );
  }
}

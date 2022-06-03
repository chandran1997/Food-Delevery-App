import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:food_delevery_app/provider/shared_service_provider.dart';
import 'package:get/get.dart';

import '../../Utilis/colors.dart';
import '../../Utilis/dimensions.dart';
import '../auth/singnIn_page.dart';
import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    super.initState();

    SharedServices sharedServices;

    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false),
    );
  }

  // isloggedIn() async {
  //   bool _result = await SharedServices.isLoggedIn();
  //   if (_result) {

  //   } else {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => SignInPage()),
  //         (route) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/splashScreen.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "The Best Food",
            style: TextStyle(
              color: AppColors.maincolor,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          CircularProgressIndicator(
            color: AppColors.maincolor,
          )
        ],
      ),
    );
  }
}

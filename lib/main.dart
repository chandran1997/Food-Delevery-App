import 'package:flutter/material.dart';
import 'package:food_delevery_app/Screens/home/home_page.dart';
import 'package:food_delevery_app/Screens/home/main_food_Page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/auth_Provider.dart';

import 'Screens/splash/splash_page.dart';
import 'provider/Cart_provider.dart';
import 'provider/popular_Product_Provider.dart';
import 'provider/recommended_Product_Provider.dart';

import 'sharedPreference/cardPage_prefs.dart';

Widget _defaultHome = const SplashScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await SharedPreferences.getInstance();
  CardPrefs.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => APIService()),
        ChangeNotifierProvider(create: (context) => PopularProductProvider()),
        ChangeNotifierProvider(
            create: (context) => RecommendedProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {'/': (context) => const SplashScreen()},
        // initialRoute: '/',
        // home: const SplashScreen(),
      ),
    );
  }
}

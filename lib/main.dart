import 'package:flutter/material.dart';
import 'package:food_delevery_app/Screens/home/main_food_Page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Provider/auth_Provider.dart';
import 'Screens/auth/singnIn_page.dart';

import 'provider/Cart_provider.dart';
import 'provider/popular_Product_Provider.dart';
import 'provider/recommended_Product_Provider.dart';
import 'provider/shared_service_provider.dart';

Widget _defaultHome = const SignInPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  SharedServices sharedServices = SharedServices();
  bool _result = await sharedServices.isLoggedIn();
  if (_result) {
    _defaultHome = const MainFoodPage();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => APIService()),
        ChangeNotifierProvider(create: (context) => SharedServices()),
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
        routes: {'/': (context) => _defaultHome},
        initialRoute: '/',
        // home: Wrapper(),
      ),
    );
  }
}

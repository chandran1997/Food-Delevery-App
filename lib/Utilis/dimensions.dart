import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

//screen height 816

//816/220 = 3.84
  static double pageViewContainer = screenHeight / 3.70;
//816/120 = 3.84
  static double pageViewTextContainer = screenHeight / 6.8;
//816/320 = 2.
  static double pageView = screenHeight / 2.55;

  //816/10 =
  //dynamic height
  static double height10 = screenHeight / 81.6;
  static double height15 = screenHeight / 54.4;
  static double height20 = screenHeight / 40.8;
  static double height30 = screenHeight / 27.2;
  static double height40 = screenHeight / 20.4;
  static double height45 = screenHeight / 18.13;

//dynamic width
  static double width10 = screenWidth / 81.6;
  static double width15 = screenWidth / 54.4;
  static double width20 = screenWidth / 40.8;
  static double width30 = screenWidth / 27.2;
  static double width40 = screenWidth / 20.4;
  static double width45 = screenWidth / 18.13;

//fontSize
  static double font16 = screenHeight / 51;
  static double font20 = screenHeight / 40.8;
  static double font26 = screenHeight / 31.3;

//radius
  static double radius15 = screenHeight / 54.4;
  static double radius20 = screenHeight / 40.8;
  static double radius30 = screenHeight / 27.2;

  //iconSize
  static double iconSize16 = screenHeight / 51;
  static double iconSize24 = screenHeight / 34;

  //list view size -> width = 432
  static double listviewImgSize = screenWidth / 3.6;
  static double listviewTextcontSize = screenWidth / 4.32;

  // food/Popular Food Page
  static double popularFoodImgSize = screenHeight / 2.33; //350 height

  //bottom navigation height = 120
  static double bottomHeightBar = screenHeight / 6.8;
}

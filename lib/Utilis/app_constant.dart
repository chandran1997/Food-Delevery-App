// class AppConstants {
//   static const String APP_NAME = "DBFood";
//   static const int APP_VERSION = 1;

//   static const String BASE_URL = "http://mvs.bslmeiyu.com";
//   static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
//   static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
//   static const String UPLOAD_URL = "/uploads/";

//   static const String TOKEN = "DBtoken";
// }

class AppConstants {
  static const String liveBaseUrl = "e-commerce-node-deploy.herokuapp.com";
  static const String baseUrl = liveBaseUrl;
  static const String login = "/api/auth/login";
  static const String register = "/api/auth/register";
  static const String forgetPassword = "/reset_password";
  static const String userProfileAPI = "/api/user/myAccount/";
  static const String getProduct = "/api/product";
  static const String getRecommendedProduct = "/api/product/recommended";
  static const String getImageUrl = "http://mvs.bslmeiyu.com/uploads/";
}

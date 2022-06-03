import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delevery_app/Provider/auth_Provider.dart';
import 'package:food_delevery_app/Screens/home/home_page.dart';

import 'package:food_delevery_app/Utilis/colors.dart';
import 'package:food_delevery_app/Utilis/dimensions.dart';
import 'package:food_delevery_app/base/custom_loader.dart';
import 'package:food_delevery_app/widgets/big_text.dart';
import 'package:provider/provider.dart';

import '../../../widgets/app_text_fiels.dart';

import '../../base/show_custom_snackBar.dart';
import '../../models/AUTH/login_request_model.dart';

import '../home/main_food_Page.dart';
import 'signUp_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool valid = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    Provider.of<APIService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var apiService = Provider.of<APIService>(context);

    void _doLogin() {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      bool emailValid = true;
      bool passwordValid = false;
      emailValid = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
      passwordValid = RegExp('^[A-Z]+[a-z]+[@][0-9]{1,}').hasMatch(password);

      if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (emailValid == false) {
        showCustomSnackBar("Type in your valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else if (passwordValid == false) {
        showCustomSnackBar(
            "Required starting capital letter, special character, one number",
            title: "Invalid Pasword");
      } else {
        LoginRequestModel model = LoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        );

        apiService.login(model).then((response) {
          if (response) {
            valid = true;

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false);
            showCustomSnackBar("SuccessFully Login",
                title: "Success", background: AppColors.maincolor);

            print("SuccessFully Login");
          } else {
            showCustomSnackBar('UserName and Password is incorrect');
          }
        });
      }
    }

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          TextEditingController().clear();
        },
        child: Scaffold(
            backgroundColor: const Color(0xffffffff),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),

                  //app logo
                  Container(
                    height: Dimensions.screenHeight * 0.25,
                    child: const Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        backgroundImage: AssetImage("assets/signIn.jpg"),
                      ),
                    ),
                  ),

                  //welcome
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font20 * 2 + Dimensions.font20 / 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width40),
                    child: RichText(
                      text: TextSpan(
                        text: "Sign into your sccount",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  //your email
                  AppTextField(
                    textEditingController: emailController,
                    hintText: "Email",
                    icon: Icons.email,
                  ),
                  SizedBox(height: Dimensions.height20),

                  //your password
                  AppTextField(
                    textEditingController: passwordController,
                    hintText: "Password",
                    icon: Icons.lock,
                  ),
                  SizedBox(height: Dimensions.height20),

                  Container(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Sign into your sccount",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  SizedBox(height: Dimensions.height10),
                  //sign Up button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _doLogin();
                      },
                      child: valid
                          ? Center(
                              child: CircularProgressIndicator(
                              color: AppColors.maincolor,
                            ))
                          : Container(
                              width: Dimensions.screenHeight / 4,
                              height: Dimensions.screenHeight / 13,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.maincolor,
                              ),
                              child: Center(
                                child: BigText(
                                  text: "Sign In",
                                  size:
                                      Dimensions.font20 + Dimensions.font20 / 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: Dimensions.height10),

                  SizedBox(height: Dimensions.screenHeight * 0.05),

                  //sign Up option
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Dont\'t have an account? ",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SignUpPage(),
                                      ),
                                    ),
                              text: "Create ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )));
  }
}

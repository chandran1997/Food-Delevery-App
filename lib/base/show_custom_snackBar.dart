import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delevery_app/widgets/big_text.dart';
import 'package:get/get.dart';

void showCustomSnackBar(
  String message, {
  bool isError = true,
  String title = "Error",
  Color background = Colors.redAccent,
}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: background);
}

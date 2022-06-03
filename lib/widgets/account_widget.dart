import 'package:flutter/material.dart';

import 'package:food_delevery_app/Utilis/dimensions.dart';

import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width30,
          top: Dimensions.width10,
          bottom: Dimensions.width10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          color: Colors.grey.withOpacity(0.2),
        )
      ]),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width30,
          ),
          bigText,
        ],
      ),
    );
  }
}

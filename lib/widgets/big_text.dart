import '/Utilis/dimensions.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  TextOverflow overflow; // eg this is overf...
  BigText({
    Key? key,
    this.color = const Color(0xff332d2b),
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontSize: size == 0 ? Dimensions.font20 : size,
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}


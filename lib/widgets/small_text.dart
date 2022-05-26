import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  double height;
  TextOverflow overflow;
  SmallText({
    Key? key,
    this.color = const Color.fromARGB(255, 180, 177, 176),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
        fontSize: size,
        color: color,
        height: height,
      ),
    );
  }
}

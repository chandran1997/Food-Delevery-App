import '/Utilis/colors.dart';
import '/Utilis/dimensions.dart';
import '/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class ExpandableTextWidgets extends StatefulWidget {
  final String text;
  const ExpandableTextWidgets({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableTextWidgets> createState() => _ExpandableTextWidgetsState();
}

class _ExpandableTextWidgetsState extends State<ExpandableTextWidgets> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  bool flag = true;

  double textHeight = Dimensions.screenHeight / 5.6;

  @override
  void initState() {
    super.initState();
    firstHalf = widget.text.substring(0, textHeight.toInt());
    secondHalf =
        widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    if (widget.text.length > textHeight.toInt()) {
      firstHalf; //  total 50 line - first 30 line
      secondHalf; //last 20 line
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstHalf;
    secondHalf;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf)
          : Column(
              children: [
                hiddenText
                    ? Text(
                        firstHalf + "...",
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: AppColors.paraColor,
                          height: 1.8,
                        ),
                      )
                    : Text(
                        firstHalf + secondHalf,
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: AppColors.paraColor,
                          height: 1.8,
                        ),
                      ),
                // hiddenText
                //     ? SmallText(text: firstHalf)
                // : SmallText(text: widget.text),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: "Show more",
                        color: AppColors.maincolor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.maincolor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

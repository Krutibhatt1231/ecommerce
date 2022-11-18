import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/colors_helper.dart';

class CustomText extends StatelessWidget {
  String title;
  Color fontColor;
  FontWeight fontWeight;
  double? fontSize;
  int? maxLines;
  TextAlign textAlign;
  CustomText(
      {Key? key,
      required this.title,
      this.fontWeight = FontWeight.normal,
      this.fontColor = ColorsHelper.whiteColor,
      this.maxLines = 1,
      required this.fontSize,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

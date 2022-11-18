import 'package:flutter/material.dart';

import '../helpers/colors_helper.dart';
import '../helpers/dimentions_helper.dart';

class RoundedButton extends StatelessWidget {
  Color fontColor;
  final double fontSize;
  FontWeight fontWeight;
  Color backgroundColor;
  Color borderColor;
  double borderRadius;
  String title;
  final VoidCallback onTap;

  RoundedButton({
    Key? key,
    this.fontColor = ColorsHelper.primaryColor,
    this.fontWeight = FontWeight.bold,
    required this.fontSize,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderRadius = 40,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * .07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: backgroundColor,
                width: 2.0,
                style: BorderStyle.solid), //set border for the button
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          onPrimary: backgroundColor,
        ),
        onPressed: onTap,
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: fontWeight,
                  fontSize: Diamentions.font16,
                  color: fontColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

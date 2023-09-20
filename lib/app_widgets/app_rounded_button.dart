import 'package:expenser_app/color_constant.dart';
import 'package:expenser_app/models/theme_modal.dart';
import 'package:expenser_app/utils/my_styles.dart';
import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {

  VoidCallback onTap;
  Color bgColor;
  String  title;
  Color textColor;
  Widget? mWidget;

  AppRoundedButton({required this.onTap, this.bgColor = ColorConstants.mattBlackColor, required this.title, this.textColor = Colors.white, this.mWidget});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ), child: Text(title, style: mTextStyle25(fontColor: textColor),)),
          );


  }
}

import 'dart:ui';
import 'package:expenser_app/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



/// Text Field Decoration

InputDecoration mDecoration ({
  bool isPassword = false,
  IconData? mPrefixIcon,
  IconButton? mSuffixIcon,
required String mLabel,
  required String mHint,
}){
  return InputDecoration(
    label: Text(mLabel),
    hintText: mHint,
    prefixIcon: mPrefixIcon !=null ? Icon(mPrefixIcon) : null,
    suffixIcon: mSuffixIcon !=null ? IconButton(onPressed: (){}, icon: mSuffixIcon) : null,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
            color: ColorConstants.mattBlackColor,
            width: 1
        )
    ),
  );

}


/// spacers

Widget hSpacer({double mHeight = 15.0}){
  return SizedBox(
    height: mHeight,
  );
}

Widget wSpacer ({double mWidth = 15.0}){

  return SizedBox(
    width: mWidth,
  );
}


//styles

TextStyle mTextStyle12 ({
  FontWeight mWeight = FontWeight.normal,
  Color fontColor = Colors.black,
}){
  return TextStyle(
    fontSize: 12,
    fontWeight: mWeight,
    fontFamily: 'Mulish',
    color: fontColor,
  );

}

TextStyle mTextStyle16 ({
  FontWeight mWeight = FontWeight.normal,
  Color fontColor = Colors.black,
}){
  return TextStyle(
    fontSize: 16,
    fontWeight: mWeight,
    fontFamily: 'Mulish',
    color: fontColor,
  );

}

TextStyle mTextStyle20 ({
  FontWeight mWeight = FontWeight.normal,
  Color fontColor = Colors.black,
}){
  return TextStyle(
    fontSize: 20,
    fontWeight: mWeight,
    fontFamily: 'Mulish',
    color: fontColor,
  );

}

TextStyle mTextStyle25 ({
  FontWeight mWeight = FontWeight.normal,
  Color fontColor = Colors.black,
}){
  return TextStyle(
    fontSize: 25,
    fontWeight: mWeight,
    fontFamily: 'Mulish',
    color: fontColor,
  );

}

TextStyle mTextStyle36 ({
  FontWeight mWeight = FontWeight.normal,
  Color fontColor = Colors.black,
}){
  return TextStyle(
    fontSize: 36,
    fontWeight: mWeight,
    fontFamily: 'Mulish',
    color: fontColor,
  );


}



import 'dart:async';

import 'package:expenser_app/screens/home_page.dart';
import 'package:expenser_app/shared_preferences/user_preference.dart';
import 'package:expenser_app/user_onboarding/login_page.dart';
import 'package:expenser_app/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:expenser_app/utils/my_styles.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () async{
      int uid = await UserPreferences().getUID();
       Widget nextPage;
       if(uid>0){
         nextPage = HomePage();
       } else{
         nextPage = LoginPage();
       }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextPage,));
    });
  }

  @override
  Widget build(BuildContext context) {
  var mediaQueryData = MediaQuery.of(context);
  var mWidth =  mediaQueryData.size.width;
  var mHeight = mediaQueryData.size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius:mWidth*0.09,
                child: Image.asset(IconConstants.appLogoIcon, color: Colors.white, width: mWidth*0.1, height:  mWidth*0.1,),
              ),
          ),
          Text("Expenser", style: mWidth>700 ? mTextStyle36(mWeight: FontWeight.bold): mTextStyle25(mWeight: FontWeight.bold)),
        ],

      ),
    );
  }
}

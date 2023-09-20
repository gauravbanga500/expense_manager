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

import 'package:expenser_app/app_widgets/app_rounded_button.dart';
import 'package:expenser_app/color_constant.dart';
import 'package:expenser_app/database/app_database.dart';
import 'package:expenser_app/models/user_model.dart';
import 'package:expenser_app/screens/home_page.dart';
import 'package:expenser_app/utils/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../utils/image_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var db = AppDataBase.db;

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var mWidth =  mediaQueryData.size.width;
    var mHeight = mediaQueryData.size.height;
    print("MQWidth : $mWidth, MQHeight : $mHeight");
    var mOrientation = mediaQueryData.orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: mOrientation == Orientation.portrait ? portraitUI(mWidth, mWidth) : landscapeUI(mWidth, mHeight),
        ),
      )
    );
  }

  Widget mainUI (double mWidth, double mHeight){
    return mHeight >370 ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          radius:mWidth*0.09,
          child: Image.asset(IconConstants.appLogoIcon, color: Colors.white, width: mWidth*0.1, height:  mWidth*0.1,),
        ),
        hSpacer(),
        SizedBox(
          width: mWidth*0.39,
            child: FittedBox(child: Text("Welcome Back!!", style: mTextStyle25(mWeight: FontWeight.normal),))),

        hSpacer(),

        TextField(
          controller: emailController,
          decoration: mDecoration(mLabel: "Email", mHint: "Enter Your Email", mPrefixIcon: Icons.email),
        ),

        hSpacer(),

        TextField(
          controller: passwordController,
          obscuringCharacter: "*",
          obscureText: true,
          decoration: mDecoration(mLabel: "Password", mHint: "Enter Your Password", mPrefixIcon: Icons.password),
        ),

        hSpacer(
          mHeight: 20,
        ),




        AppRoundedButton(onTap: () async{
            var email = emailController.text.toString();
            var password = passwordController.text.toString();

            if(email == ""){
              print("Please Enter Your Email");
            } else if(password == ""){
              print("Please Enter Your Password");
            } else {
              if(await db.authenticateUser(email, password)){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
              } else{
                print("Account Doesn't Exist");
              }
            }

        }, title: "Login", textColor: Colors.white,)

      ],
    ) : SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius:mWidth*0.09,
            child: Image.asset(IconConstants.appLogoIcon, color: Colors.white, width: mWidth*0.1, height:  mWidth*0.1,),
          ),
          hSpacer(),
          Text("Welcome Back!!", style: mTextStyle25(mWeight: FontWeight.normal),),

          hSpacer(),

          TextField(
            decoration: mDecoration(mLabel: "Email", mHint: "Enter Your Email", mPrefixIcon: Icons.email),
          ),

          hSpacer(),

          TextField(
            obscuringCharacter: "*",
            obscureText: true,
            decoration: mDecoration(mLabel: "Password", mHint: "Enter Your Password", mPrefixIcon: Icons.password),
          ),

          hSpacer(
            mHeight: 20,
          ),

          AppRoundedButton(onTap: (){

          }, title: "Login", textColor: Colors.white,)
        ],
      ),
    );
  }

  Widget portraitUI (double mWidth, double mHeight) {
    return mainUI(mWidth, mHeight);
  }
  Widget landscapeUI (double mWidth, double mHeight){
    return Row(
      children: [
        Expanded(child: Container(
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius:mHeight*0.09,
              child: Image.asset(IconConstants.appLogoIcon, color: Colors.white, width: mHeight*0.1, height:  mHeight*0.1,),
            ),
          ),
        )),
        Expanded(child: LayoutBuilder(
          builder: (context, constraints){
            var mWidth = constraints.maxWidth;
            var mHeight = constraints.maxHeight;
            print("LBWidth : $mWidth, LBHeight : $mHeight");
            return mainUI(constraints.maxWidth, mHeight);
          },
      )),
      ],
    );
  }
}









// Widget mainUI (double mWidth, bool isLandscape){
//   return  Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       CircleAvatar(
//         backgroundColor: Colors.black,
//         radius:mWidth*0.09,
//         child: Image.asset(ImageConstants.appLogoIcon, color: Colors.white, width: mWidth*0.1, height:  mWidth*0.1,),
//       ),
//       hSpacer(),
//       Text("Welcome Back!!", style: mTextStyle25(mWeight: FontWeight.normal),),
//
//       hSpacer(),
//
//       SizedBox(
//         height: 200,
//         width: double.infinity,
//         child: isLandscape ? Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 decoration: mDecoration(mLabel: "Email", mHint: "Enter Your Email", mPrefixIcon: Icons.email),
//               ),
//             ),
//
//             wSpacer(),
//
//             Expanded(
//               child: TextField(
//                 obscuringCharacter: "*",
//                 obscureText: true,
//                 decoration: mDecoration(mLabel: "Password", mHint: "Enter Your Password", mPrefixIcon: Icons.password),
//               ),
//             ),
//           ],
//         ) : Column(
//
//           children: [
//             TextField(
//               decoration: mDecoration(mLabel: "Email", mHint: "Enter Your Email", mPrefixIcon: Icons.email),
//             ),
//
//             hSpacer(),
//
//             TextField(
//               obscuringCharacter: "*",
//               obscureText: true,
//               decoration: mDecoration(mLabel: "Password", mHint: "Enter Your Password", mPrefixIcon: Icons.password),
//             ),
//           ],
//         ),
//       ),
//
//
//       hSpacer(
//         mHeight: 20,
//       ),
//
//       AppRoundedButton(onTap: (){
//
//       }, title: "Login", textColor: Colors.white,)
//     ],
//   );
// }
//
// Widget portraitUI (double mWidth) {
//   return mainUI(mWidth, false);
// }
// Widget landscapeUI (double mWidth){
//   return Expanded(child: mainUI(mWidth, true));
// }


// else{await db.authenticateUser(email, password).then((value) {
// if(value){
// Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => HomePage(),));
// } else {
// return Text("Account Not Exist");
// }
// });
// }
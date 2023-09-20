import 'package:expenser_app/app_widgets/app_rounded_button.dart';
import 'package:expenser_app/color_constant.dart';
import 'package:expenser_app/main.dart';
import 'package:expenser_app/models/theme_modal.dart';
import 'package:expenser_app/models/user_model.dart';
import 'package:expenser_app/utils/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:expenser_app/database/app_database.dart';
import 'package:provider/provider.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formfield = GlobalKey<FormState>();
  bool passToggle = true;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobController = TextEditingController();
  var passController = TextEditingController();
  var passController2 = TextEditingController();
  var ageController =  TextEditingController();

  var db =  AppDataBase.db;

  Color bgColor = Colors.white;
  Color secondaryColor = Colors.black;
  Color textColor = Colors.black;
  Color secondaryTextColor = Colors.white;
  String title = "light";



  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModal>(builder: (context, ThemeModal themeNotifier, child){
      return Form(
      key: _formfield,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Switch(value: themeNotifier.isDark ? false : true, onChanged: (value){
                themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
              })
            ],
            title: Text("Sign Up"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Text(themeNotifier.isDark ? "Sign Up" : "Sign Up", style: Theme.of(context).textTheme.headlineLarge!),
                  hSpacer(
                    mHeight: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration:
                    mDecoration(mLabel: "Name", mHint: "Enter Your Name", mPrefixIcon: Icons.person,),
                  ),
                  hSpacer(),
                  TextFormField(
                    controller: emailController,
                    decoration:
                    mDecoration(mLabel: "Email", mHint: "Enter Your Email..", mPrefixIcon: Icons.email,),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Your Email";
                      }
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                      if(!emailValid){
                        return "Enter Valid Email";
                      }
                    },
                  ),
                  hSpacer(),
                  TextFormField(
                    controller: mobController,
                    decoration:
                    mDecoration(mLabel: "Mobile", mHint: "Enter Your Mobile", mPrefixIcon: Icons.phone,),
                  ),
                  hSpacer(),
                  TextFormField(
                    obscuringCharacter: "*",
                    obscureText: passToggle,
                    controller: passController,
                    decoration:
                    mDecoration(mLabel: "Password", mHint: "Enter Your Password", mSuffixIcon: IconButton(onPressed: (){
                      setState(() {
                        passToggle = !passToggle;
                      });
                    }, icon: Icon(passToggle ? Icons.visibility : Icons.visibility_off)),),

                  ),
                  hSpacer(),
                  TextFormField(
                    obscuringCharacter: "*",
                    obscureText: passToggle,
                    controller: passController2,
                    decoration:
                    mDecoration(mLabel: "Confirm Password", mHint: "Enter Your Password", mSuffixIcon: IconButton(onPressed: (){
                      setState(() {
                        passToggle = !passToggle;
                      });
                    }, icon: Icon(passToggle ? Icons.visibility : Icons.visibility_off)),),
                  ),
                  hSpacer(),
                  TextFormField(
                    controller: ageController,
                    decoration:
                    mDecoration(mLabel: "Age", mHint: "Enter Your Age", mPrefixIcon: Icons.date_range,),
                  ),
                  hSpacer(
                      mHeight: 20
                  ),

                  AppRoundedButton(onTap: () async {
                    var name = nameController.text.toString();
                    var email = emailController.text.toString();
                    var mobile = mobController.text.toString();
                    var password = passController.text.toString();
                    var password2 = passController2.text.toString();
                    var age = ageController.text.toString();


                    if(_formfield.currentState!.validate()){
                      print("Validate Successfully");
                      if(await db.checkIfEmailAlreadyExist(UserModel(email: email)) ){
                        print("You Already Have An Account");
                      }
                      else if(password == password2 ){
                        print("Good Both Password Are Matched");
                        await db.CreateNewAccount(UserModel(email: email, mob: mobile, name: name, password: password, age: age));
                        print("Account Created");
                      }
                      else if(password != password2){
                        showDialog(context: context, builder: (ctx) =>  AlertDialog(
                          content: Text("Please Check Both The Password"),
                          actions:<Widget>[
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Close"))
                          ],
                        ));
                      }

                      emailController.clear();
                      passController.clear();
                    }





                  },title: "Sign Up")
                ],
              ),
            ),
          )

      ));
    });
  }
}

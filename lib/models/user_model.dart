import '../database/app_database.dart';

class UserModel {

  int? user_id;
  String? name;
  String email;
  String? mob;
  String? password;
  String? age;



  UserModel({this.user_id,  this.name,  required this.email,  this.mob,  this.password, this.age});




  // creating a user_model from map data

   factory UserModel.fromMap(Map<String, dynamic> map){
     return UserModel(
         user_id: map[AppDataBase.USER_ID],
         name: map[AppDataBase.USER_NAME],
         email: map[AppDataBase.USER_EMAIL],
         mob: map[AppDataBase.USER_MOBILE],
         password: map[AppDataBase.USER_PASSWORD],
         age: map[AppDataBase.USER_AGE],
     );
   }

    // creating a map data from user_model

   Map<String,dynamic> toMap(){
     return {
       AppDataBase.USER_ID : user_id,
       AppDataBase.USER_NAME : name,
       AppDataBase.USER_EMAIL : email,
       AppDataBase.USER_MOBILE : mob,
       AppDataBase.USER_PASSWORD : password,
       AppDataBase.USER_AGE : age,

     };
   }

}
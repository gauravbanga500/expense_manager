
import 'package:expenser_app/models/user_model.dart';

abstract class UserEvent {}


class CreateNewUserEvent extends UserEvent {

  UserModel user;
  CreateNewUserEvent({required this.user});

}


class LoginUserEvent extends UserEvent{
  String uName, pass;

  LoginUserEvent({required this.uName, required this.pass});

}


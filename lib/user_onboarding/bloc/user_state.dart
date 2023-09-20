

abstract class UserState {}



class UserInitialState extends UserState{}

class UserLoadingState extends UserState{}

class UserSuccessState extends UserState{}

class UserErrorState extends UserState{

  String ErrorMsg;
  UserErrorState({required this.ErrorMsg});

}
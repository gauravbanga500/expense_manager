import 'package:expenser_app/database/app_database.dart';
import 'package:expenser_app/user_onboarding/bloc/user_event.dart';
import 'package:expenser_app/user_onboarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
   AppDataBase db;
  UserBloc({required this.db}): super(UserInitialState()){

    on<CreateNewUserEvent>((event, emit) async {
     emit(UserLoadingState());
     
     
     bool check =  await db.CreateNewAccount(event.user);

     if(check){
       emit(UserSuccessState());
     } else{
       emit(UserErrorState(ErrorMsg: "Email Already Exists"));
     }
    });
    
    
    on<LoginUserEvent>((event, emit) async{
      emit(UserLoadingState());

      bool check = await db.authenticateUser(event.uName, event.pass);
      
     if(check){
       emit(UserSuccessState());
     } else {
       emit(UserErrorState(ErrorMsg: "Invalid Username & Password"));
     }
      


    });

  }


}
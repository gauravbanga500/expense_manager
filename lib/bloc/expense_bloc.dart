import 'package:expenser_app/bloc/expense_event.dart';
import 'package:expenser_app/bloc/expense_state.dart';
import 'package:expenser_app/database/app_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{

  AppDataBase db;
  ExpenseBloc({required this.db}) : super(ExpenseInitialState()) {


    on<AddExpenseEvent>((event, emit) async{

      emit(ExpenseLoadingState());
      bool check = await db.addExpense(event.newExpense);
      if(check){
        var expenses = await db.getAllExpenseOfUser();
        emit(ExpenseLoadedState(arrExpenses: expenses));
      }else{
        emit(ExpenseErrorState(errorMsg: "Expense Not Added"));
      }

    });

    on<FetchAllExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var expenses = await db.getAllExpenseOfUser();
      emit(ExpenseLoadedState(arrExpenses: expenses));
    });
  }
}
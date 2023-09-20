import 'expense_model.dart';


class FilteredExpenseModel {

  String dateName;
  num totalAmount;
  List<ExpenseModel> arrExpenses;



 FilteredExpenseModel({required this.dateName, required this.totalAmount, required this.arrExpenses});

}

class FilteredMonthExpenseModel{

  String monthName;
  num totalAmount;
  List<ExpenseModel> arrMonthExpense;



  FilteredMonthExpenseModel({required this.monthName, required this.totalAmount, required this.arrMonthExpense});

}
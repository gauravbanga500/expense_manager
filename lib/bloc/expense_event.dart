import 'package:expenser_app/models/user_model.dart';

import '../models/expense_model.dart';

abstract class ExpenseEvent{}



class AddExpenseEvent extends ExpenseEvent{

  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}



class FetchAllExpenseEvent extends ExpenseEvent{}




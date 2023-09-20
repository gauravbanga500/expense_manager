

import 'package:expenser_app/database/app_database.dart';

class ExpenseModel{

  int? exp_id;
  int  user_id;
  String expense_title;
  String expense_desc;
  num expense_amount;
  num expense_balance;
  num expense_investment;
  int expense_type;
  int expense_cat_id;
  String expense_time;

  ExpenseModel({this.exp_id, required this.user_id, required this.expense_title, required this.expense_desc, required this.expense_amount, required this.expense_balance, required this.expense_investment, required this.expense_cat_id, required this.expense_type, required this.expense_time});


  factory ExpenseModel.fromMap(Map<String, dynamic> map) =>
       ExpenseModel(
         exp_id: map[AppDataBase.EXPENSE_COLUMN_ID],
         user_id: map[AppDataBase.USER_ID],
         expense_title: map[AppDataBase.EXPENSE_COLUMN_TITLE],
         expense_desc:  map[AppDataBase.EXPENSE_COLUMN_DESC],
         expense_amount: map[AppDataBase.EXPENSE_COLUMN_AMOUNT],
         expense_balance: map[AppDataBase.EXPENSE_COLUMN_BALANCE],
         expense_investment: map[AppDataBase.EXPENSE_COLUMN_INVESTMENT],
         expense_type: map[AppDataBase.EXPENSE_COLUMN_TYPE],
         expense_cat_id: map[AppDataBase.EXPENSE_COLUMN_CAT_ID],
         expense_time: map[AppDataBase.EXPENSE_COLUMN_TIME],
       );






    Map<String, dynamic> toMap() =>

        {
          AppDataBase.EXPENSE_COLUMN_ID : exp_id,
          AppDataBase.USER_ID : user_id,
          AppDataBase.EXPENSE_COLUMN_TITLE : expense_title,
          AppDataBase.EXPENSE_COLUMN_DESC : expense_desc,
          AppDataBase.EXPENSE_COLUMN_AMOUNT : expense_amount,
          AppDataBase.EXPENSE_COLUMN_BALANCE : expense_balance,
          AppDataBase.EXPENSE_COLUMN_INVESTMENT : expense_investment,
          AppDataBase.EXPENSE_COLUMN_TYPE :expense_type,
          AppDataBase.EXPENSE_COLUMN_CAT_ID : expense_cat_id,
          AppDataBase.EXPENSE_COLUMN_TIME : expense_time

        };









}
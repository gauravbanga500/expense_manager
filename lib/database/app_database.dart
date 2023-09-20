import 'dart:io';
import 'package:expenser_app/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class AppDataBase{


  // for singleton class

  AppDataBase._();
  static final AppDataBase db = AppDataBase._();

  Database? _database;


  /// sign_up fields

   static final USER_TABLE = "user";
   static final USER_ID   = "user_id";
   static final USER_NAME = "name";
   static final USER_EMAIL = "email";
   static final USER_MOBILE = "mobile";
   static final USER_PASSWORD = "password";
   static final USER_AGE = "age";



   /// expense fields

   static const EXPENSE_TABLE = "expense";
   static const EXPENSE_COLUMN_ID = "expense_id";
   static const EXPENSE_COLUMN_TITLE = "expense_title";
   static const EXPENSE_COLUMN_DESC = "expense_desc";
   static const EXPENSE_COLUMN_AMOUNT = "expense_amount";
   static const EXPENSE_COLUMN_BALANCE = "expense_balance";
   static const EXPENSE_COLUMN_INVESTMENT = "expense_investment";
   static const EXPENSE_COLUMN_TYPE = "expense_type";
   static const EXPENSE_COLUMN_CAT_ID = "expense_cat_id";
   static const EXPENSE_COLUMN_TIME =   "expense_time";





   Future<Database> getDB() async{
     if(_database != null){
        return _database!;
     } else{
       _database = await initDB();
       return _database!;
     }
   }


   Future<Database> initDB() async{

     Directory documentDirectory = await getApplicationDocumentsDirectory();
     var dbPath  = join(documentDirectory.path, "expenseDB.db");

     return openDatabase(
       dbPath,
       version: 1,
       onCreate:(db, version) async{

         // create database tables here

         db.execute("Create table $USER_TABLE($USER_ID integer primary key autoincrement, $USER_NAME text, $USER_EMAIL  text unique, $USER_MOBILE text unique, $USER_PASSWORD text, $USER_AGE text )");
         db.execute("Create table $EXPENSE_TABLE($EXPENSE_COLUMN_ID integer primary key autoincrement, $USER_ID integer, $EXPENSE_COLUMN_TITLE text, $EXPENSE_COLUMN_DESC text, $EXPENSE_COLUMN_AMOUNT real, $EXPENSE_COLUMN_BALANCE real, $EXPENSE_COLUMN_INVESTMENT real, $EXPENSE_COLUMN_TYPE integer, $EXPENSE_COLUMN_CAT_ID integer, $EXPENSE_COLUMN_TIME String )");

       },

     );
   }


     // create new account
      Future<bool> CreateNewAccount(UserModel user) async {
       bool check = await checkIfEmailAlreadyExist(user);
       var db = await  getDB();
       if(!check){
         var isInserted = await db.insert(USER_TABLE, user.toMap());
         return isInserted>0;
       } else {
         return false;
       }

  }

     // check if email is already exist
     Future<bool> checkIfEmailAlreadyExist(UserModel user) async{
      var db = await getDB();

      var data = await db.query(USER_TABLE, where: "$USER_EMAIL = ? ", whereArgs: [user.email]);
      return data.isNotEmpty;

     }


     // Authentication User

      Future<bool> authenticateUser (String email, String password)  async{
       var db = await getDB();
       var data = await db.query(USER_TABLE, where: "$USER_EMAIL = ? and  $USER_PASSWORD = ?", whereArgs: [email, password] );

       if(data.isNotEmpty){
         var pref = await SharedPreferences.getInstance();
         pref.setInt("uid", data[0][USER_ID] as int);
       }


       return data.isNotEmpty;
      }


      /// Expense Table Operations

      Future<bool> addExpense(ExpenseModel newExpense) async{
      var db = await getDB();

      int check = await db.insert(EXPENSE_TABLE, newExpense.toMap());

      return check>0;

      }

      Future<List<ExpenseModel>> getAllExpenseOfUser() async {
      var db = await getDB();
      int uid = 1;


      List<Map<String, dynamic>> data = await db.query(EXPENSE_TABLE, where: "$USER_ID = ? ", whereArgs: ["$uid"]);

      List<ExpenseModel> listExpenses = [];

      for(Map<String, dynamic> eachExpense in data){
        listExpenses.add(ExpenseModel.fromMap(eachExpense));
      }

      return listExpenses;

      }


}
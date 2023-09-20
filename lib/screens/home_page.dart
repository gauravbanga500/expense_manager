import 'package:expenser_app/bloc/expense_bloc.dart';
import 'package:expenser_app/bloc/expense_event.dart';
import 'package:expenser_app/bloc/expense_state.dart';
import 'package:expenser_app/constants/app_constants.dart';
import 'package:expenser_app/models/filtered_expense_model.dart';
import 'package:expenser_app/screens/transactions/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/expense_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FilteredExpenseModel> arrMonthWiseExpenses = [];
  List<FilteredExpenseModel> arrDateWiseExpenses = [];
  num maxAmt = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpenseEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          FloatingActionButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTransactionPage(),));
          },
            child: Icon(Icons.add),
          )
        ],
      ),

      body: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state) {
        if (state is ExpenseLoadedState) {
          filterExpensesByDate(state.arrExpenses);

          return ListView.builder(
              itemCount: arrDateWiseExpenses.length,
              itemBuilder: (_, index) {
                var currItem = arrDateWiseExpenses[index];

                // // for(Map<String,dynamic> cat in AppConstants.categories){
                //   if(cat["id"]==currItem.expense_cat_id){
                //     imgPath = cat["img"];
                //     break;
                //
                //   }
                // }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${currItem.dateName}", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                          // Divider(
                          //   height: 10,
                          //   thickness: 1,
                          //   color: Colors.black,
                          //   indent: 10,
                          //   endIndent: 10,
                          // ),
                          Text("${currItem.totalAmount}", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                    ListView.builder(
                        itemCount: currItem.arrExpenses.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, childindex){

                          var currExpense = currItem.arrExpenses[childindex];
                          var imgPath = "";
                          imgPath = AppConstants.categories.firstWhere((element) => element["id"] == currExpense.expense_cat_id)["img"];

                          return ListTile(
                            leading: Image.asset(imgPath),
                            title: Text("${currExpense.expense_title}"),
                            subtitle: Text("${currExpense.expense_desc}"),
                            trailing: Text("\$${currExpense.expense_amount}"),
                          );
                        }),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                );
              });
        } else if (state is ExpenseLoadingState) {
          Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      }),

    );
  }


  void filterExpensesByDate(List<ExpenseModel> arrExpenses) {
    arrDateWiseExpenses.clear();
    List<String> arrUniqueDates = [];
    // List<String> arrUniqueMonths = [];
    // arrMonthWiseExpenses.clear();

    for (ExpenseModel eachExp in arrExpenses) {
      var eachDate = DateTime.parse(eachExp.expense_time);

      /// 2023-09-09

      var mDate = "${eachDate.year}"
          "-${eachDate.month
          .toString()
          .length < 2 ? "0${eachDate.month}" : "${eachDate.month}"}"
          "-${eachDate.day
          .toString()
          .length < 2 ? "0${eachDate.day}" : "${eachDate.day}"}";

      if (!arrUniqueDates.contains(mDate)) {
        arrUniqueDates.add((mDate));
      }
      print(arrUniqueDates);

      // if(!arrUniqueMonths.contains(mMonth)){
      //   arrUniqueMonths.add(mMonth);
      // }
      //
      // print(arrUniqueMonths);


    }


    /// Step 2
    num eachDateAmt = 0;
    for (String eachUniqueDate in arrUniqueDates) {
      List<ExpenseModel> eachDateExpenses = [];

      for (ExpenseModel eachExp in arrExpenses) {
        if (eachExp.expense_time.contains(eachUniqueDate)) {
          eachDateExpenses.add(eachExp);

          if (eachExp.expense_type == 0) {
            //debit
            eachDateAmt -= eachExp.expense_amount;
          } else {
            //credit
            eachDateAmt += eachExp.expense_amount;
          }
        }
      }
      print(eachDateAmt);

      if (eachDateAmt > maxAmt) {
        maxAmt = eachDateAmt;
      }



      arrDateWiseExpenses.add(FilteredExpenseModel(
          dateName: eachUniqueDate,
          totalAmount: eachDateAmt,
          arrExpenses: eachDateExpenses));

      print(arrDateWiseExpenses.length);

    }

     }


     /// get month wise data

  void filterExpenseByMonth(List<ExpenseModel> arrExpense) {
    arrMonthWiseExpenses.clear();
    num totalMonthExpenseAmount = 0;

    num maxAmt = 0;
    List<String> arrUniqueMonths = [];

    for (ExpenseModel eachExp in arrExpense) {
      var eachDate = DateTime.parse(eachExp.expense_time);


      var mMonth = "${eachDate.year}"
          "-${eachDate.month
          .toString()
          .length < 2 ? "0${eachDate.month}" : "${eachDate.month}"}";

      print(mMonth);

      if(!arrUniqueMonths.contains(mMonth)){
        arrUniqueMonths.add(mMonth);
      }

      print(arrUniqueMonths);

    }


    /// get month wise amount
    for (String eachUniqueMonth in arrUniqueMonths) {
      List<ExpenseModel> eachMonthExpenses = [];
      num eachMonthAmt = 0;

      for (ExpenseModel eachExp in arrExpense) {
        if (eachExp.expense_time.contains(eachUniqueMonth)) {
          eachMonthExpenses.add(eachExp);

          if (eachExp.expense_type == 0) {
            //debit
            eachMonthAmt -= eachExp.expense_amount;
          } else {
            //credit
            eachMonthAmt += eachExp.expense_amount;
          }
        }
      }
      print(eachMonthAmt);

      if (eachMonthAmt > maxAmt) {
        maxAmt = eachMonthAmt;
      }

      arrMonthWiseExpenses.add(FilteredExpenseModel(
        dateName: eachUniqueMonth,
        arrExpenses: eachMonthExpenses,
        totalAmount: eachMonthAmt,));
        totalMonthExpenseAmount += eachMonthAmt;

     print(totalMonthExpenseAmount);
    }




  }

  }







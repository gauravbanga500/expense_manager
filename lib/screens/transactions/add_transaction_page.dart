import 'package:expenser_app/app_widgets/app_rounded_button.dart';
import 'package:expenser_app/bloc/expense_bloc.dart';
import 'package:expenser_app/bloc/expense_event.dart';
import 'package:expenser_app/models/expense_model.dart';
import 'package:expenser_app/shared_preferences/user_preference.dart';
import 'package:expenser_app/utils/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_constants.dart';


class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();
  var selectedCatIndex = -1;
  var listCatType = ['Debit', 'Credit', 'Invest'];
  var selectedTransType =  "Debit" ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: mDecoration(mLabel: "Title", mHint: "Enter Title Here..."),
            ),
            hSpacer(),
            TextField(
              controller: descController,
              decoration: mDecoration(mLabel: "Desc", mHint: "Enter Desc Here..."),
            ),
            hSpacer(),
            TextField(
              controller: amountController,
              decoration: mDecoration(mLabel: "Amount", mHint: "Enter Amount Here..."),
            ),
            hSpacer(),

            AppRoundedButton(onTap: (){
              showModalBottomSheet(context: context, builder: (context){
                return Container(
                  height: 300,
                  child: GridView.builder(
                    itemCount: AppConstants.categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ), itemBuilder: (_, index){
                      return InkWell(
                        onTap: (){
                          selectedCatIndex = index;
                          setState(() {

                          });
                          Navigator.pop(context);
                        },
                         child: Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Image.asset(AppConstants.categories[index]['img'], width: 50, height: 50,),
                             ),
                             Text("${AppConstants.categories[index]["name"]}")
                           ],
                         ),

                      );


                  }),
                );
              });
            }, title: "Choose Category", mWidget: selectedCatIndex >= 0 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppConstants.categories[selectedCatIndex]["img"],width: 30, height: 30,),
                Text("-", style: mTextStyle16(fontColor: Colors.white),),
                Text("${AppConstants.categories[selectedCatIndex]["name"]}",style: mTextStyle16(fontColor: Colors.white),),
            ],): null ),
            hSpacer(),
            DropdownButton(value: selectedTransType, items: listCatType.map((element) => DropdownMenuItem(child: Text(element), value: element)).toList(), onChanged: (value){
              selectedTransType = value!;
              setState(() {

              });
            }),
            hSpacer(),
            AppRoundedButton(onTap: () async{

              context.read<ExpenseBloc>().add(AddExpenseEvent(newExpense: ExpenseModel(
                  user_id: await UserPreferences().getUID(),
                  expense_title: titleController.text.toString(),
                  expense_desc: descController.text.toString(),
                  expense_amount: double.parse(amountController.text.toString()),
                  expense_balance: 0,
                  expense_cat_id: AppConstants.categories[selectedCatIndex]["id"],
                  expense_type: selectedTransType == "Debit" ? 0 : 1,
                  expense_time: DateTime.now().toString(),
                  expense_investment: 1000)));

                  Navigator.of(context).maybePop();

            }, title: "Add Transaction")

          ],
        ),
      ),
    );
  }
}

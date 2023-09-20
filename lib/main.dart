import 'package:expenser_app/bloc/expense_bloc.dart';
import 'package:expenser_app/database/app_database.dart';
import 'package:expenser_app/models/theme_modal.dart';
import 'package:expenser_app/provider/app_theme_provider.dart';
import 'package:expenser_app/screens/home_page.dart';
import 'package:expenser_app/screens/transactions/add_transaction_page.dart';
import 'package:expenser_app/user_onboarding/login_page.dart';
import 'package:expenser_app/user_onboarding/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

void main() {
  runApp( MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> ThemeModal()),
      BlocProvider(create: (context)=> ExpenseBloc(db: AppDataBase.db))
  ],

      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var mqData =  MediaQuery.of(context);
    var themeData  = Theme.of(context);
    var isDark = themeData.brightness == Brightness.dark;


    return Consumer<ThemeModal>(builder: (context, ThemeModal themeModal, child,){
      return MaterialApp(
        title: 'Flutter Demo',
        themeMode: themeModal.isDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        theme: ThemeData(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  HomePage(),
      );
    });
  }
}





import 'package:finance_app_class/controller/transaction_controller.dart';
import 'package:finance_app_class/ui/pages/home/home_page.dart';
import 'package:finance_app_class/ui/pages/new_transaction/new_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TransactionController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/new-transaction': (context) => const NewTransactionPage(),
      },
    );
  }
}

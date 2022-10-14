// ignore_for_file: constant_identifier_names

import 'package:finance_app_class/controller/transaction_controller.dart';
import 'package:finance_app_class/mock/category_mock.dart';
import 'package:finance_app_class/mock/transaction_mock.dart';
import 'package:finance_app_class/model/category.dart';
import 'package:finance_app_class/model/transaction.dart';
import 'package:finance_app_class/strings.dart';
import 'package:finance_app_class/ui/component/item_transaction.dart';
import 'package:finance_app_class/ui/pages/home/widgets/card_balance.dart';
import 'package:finance_app_class/ui/pages/home/widgets/card_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Category> _categories;
  late List<Transaction> _transactions;

  double get getTotalIncoming {
    double value = 0;
    var filtered = _transactions
        .where((element) => element.transactionType == TransactionType.INCOME);
    for (var transaction in filtered) {
      value += transaction.value;
    }
    return value;
  }

  double get getTotalOutcoming {
    double value = 0;
    var filtered = _transactions
        .where((element) => element.transactionType == TransactionType.EXPENSE);
    for (var transaction in filtered) {
      value += transaction.value;
    }
    return value;
  }

  /*@override
  void initState() {
    _categories = CategoryMock.getCategories();
    _transactions = TransactionMock.generateTransactions(25, _categories);
    _transactions.sort(((a, b) => b.dateTime!.compareTo(a.dateTime!)));
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionController>(
      builder: (context, transactionController, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Visão Geral"),
            titleTextStyle: const TextStyle(color: Colors.white),
            actions: [
              PopupMenuButton<MenuActionType>(
                onSelected: handleMenuClick,
                itemBuilder: (context) => [
                  const PopupMenuItem<MenuActionType>(
                      value: MenuActionType.NEW_TRANSACTION,
                      child: Text("Nova Transação"))
                ],
              )
            ],
          ),
          backgroundColor: Colors.black12,
          body: Container(
            padding: const EdgeInsets.only(left: 32, right: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    Strings.HOME_LABEL_BALANCE,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CardBalance(transactionController.getTotalIncoming -
                      transactionController.getTotalOutcoming),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    Strings.HOME_LABEL_RESULT,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CardResult(
                      incomingValue: transactionController.getTotalIncoming,
                      outcomingValue: transactionController.getTotalOutcoming),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "TRANSAÇÕES",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => Dismissible(
                            key: ValueKey(
                                transactionController.transactions[index]),
                            direction: DismissDirection.endToStart,
                            resizeDuration: const Duration(milliseconds: 300),
                            background: Container(color: Colors.red),
                            onDismissed: (direction) =>
                                transactionController.removeByPosition(index),
                            child: ItemTransaction(
                              transactionController.transactions[index],
                              key: ValueKey<int>(index),
                            ),
                          ),
                      itemCount: transactionController.transactions.length)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void handleMenuClick(MenuActionType menuActionType) {
    switch (menuActionType) {
      case MenuActionType.NEW_TRANSACTION:
        Navigator.of(context).pushNamed("/new-transaction");
        break;
      case MenuActionType.SYNC:
        sync();
    }
  }

  void sync() {
    setState(() {});
  }
}

enum MenuActionType { NEW_TRANSACTION, SYNC }

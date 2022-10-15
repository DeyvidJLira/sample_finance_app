// ignore_for_file: constant_identifier_names

import 'package:finance_app_class/controller/transaction_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Visão Geral"),
          titleTextStyle: const TextStyle(color: Colors.white),
          actions: [
            PopupMenuButton<MenuActionType>(
              onSelected: _handleMenuClick,
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
          child: Consumer<TransactionController>(
              builder: (context, transactionController, child) =>
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          Strings.HOME_LABEL_BALANCE,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
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
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CardResult(
                            incomingValue:
                                transactionController.getTotalIncoming,
                            outcomingValue:
                                transactionController.getTotalOutcoming),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          "TRANSAÇÕES",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (_, index) => Dismissible(
                                  key: ValueKey<Transaction>(
                                      transactionController
                                          .transactions[index]),
                                  direction: DismissDirection.endToStart,
                                  resizeDuration:
                                      const Duration(milliseconds: 300),
                                  background: Container(color: Colors.red),
                                  onDismissed: (direction) =>
                                      transactionController
                                          .removeByPosition(index),
                                  child: ItemTransaction(
                                    transactionController.transactions[index],
                                    key: ValueKey<int>(index),
                                  ),
                                ),
                            itemCount:
                                transactionController.transactions.length)
                      ],
                    ),
                  )),
        ));
  }

  void _handleMenuClick(MenuActionType menuActionType) {
    switch (menuActionType) {
      case MenuActionType.NEW_TRANSACTION:
        Navigator.of(context).pushNamed("/new-transaction");
        break;
    }
  }
}

enum MenuActionType { NEW_TRANSACTION }

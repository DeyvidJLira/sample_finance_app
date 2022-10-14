import 'package:finance_app_class/controller/transaction_controller.dart';
import 'package:finance_app_class/extension/extension_double.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../model/transaction.dart';

class ItemTransaction extends StatefulWidget {
  Transaction transaction;

  ItemTransaction(this.transaction, {super.key});

  @override
  State<ItemTransaction> createState() => _ItemTransactionState();
}

class _ItemTransactionState extends State<ItemTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Text(
          "${widget.transaction.dateTime?.day}/${widget.transaction.dateTime?.month}",
          style: TextStyle(color: getColor()),
        ),
        title: Text(widget.transaction.description,
            style: TextStyle(color: getColor())),
        trailing: Text(getValue(), style: TextStyle(color: getColor())),
      ),
    );
  }

  Color getColor() {
    switch (widget.transaction.transactionType) {
      case TransactionType.INCOME:
        return Colors.green;
      case TransactionType.EXPENSE:
        return Colors.red;
    }
  }

  String getValue() {
    switch (widget.transaction.transactionType) {
      case TransactionType.INCOME:
        return widget.transaction.value.formatBRL;
      case TransactionType.EXPENSE:
        return "(${widget.transaction.value.formatBRL})";
    }
  }
}

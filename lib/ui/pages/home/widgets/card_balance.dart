import 'package:finance_app_class/extension/extension_double.dart';
import 'package:flutter/material.dart';

class CardBalance extends StatelessWidget {
  final double _balance;

  const CardBalance(this._balance, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            _balance.formatBRL,
            style: const TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}

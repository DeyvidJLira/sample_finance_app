import 'package:finance_app_class/extension/extension_double.dart';
import 'package:finance_app_class/strings.dart';
import 'package:flutter/material.dart';

class CardResult extends StatelessWidget {
  final double incomingValue;
  final double outcomingValue;

  const CardResult(
      {super.key, this.incomingValue = 0, this.outcomingValue = 0});

  double get total => incomingValue - outcomingValue;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 4,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.HOME_LABEL_INCOMING),
                Text(
                  incomingValue.formatBRL,
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.HOME_LABEL_OUTCOMING),
                Text(
                  outcomingValue.formatBRL,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.HOME_LABEL_TOTAL),
                Text((incomingValue - outcomingValue).formatBRL)
              ],
            ),
          ]),
        ));
  }
}

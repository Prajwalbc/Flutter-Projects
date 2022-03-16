import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';
import '../models/transaction_model.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('Chart is built');
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.2,
              padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
              child: FittedBox(
                child: Text(
                  "This week's total spending: ₹$totalSpending",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.8,
              child: Card(
                elevation: 6,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: groupedTransactionValues.map((data) {
                      return Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          // height: constraints.maxHeight * 0.8,
                          child: ChartBar(
                            data['day'],
                            data['amount'],
                            totalSpending == 0.0
                                ? 0.0
                                : (data['amount'] as double) / totalSpending,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

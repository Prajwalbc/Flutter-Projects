import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // print('TransactionList is built');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return LayoutBuilder(builder: (ctx, constraints) {
      return transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      height: constraints.maxHeight * 0.45,
                      child: Image.asset('assets/images/hourglass.png',
                          fit: BoxFit.cover)),
                ],
              );
            })
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: isLandscape
                        ? constraints.maxHeight * 0.18
                        : constraints.maxHeight * 0.08,
                    // height: constraints.maxHeight * 0.18,
                    padding: const EdgeInsets.only(left: 9, top: 5, bottom: 5),
                    child: FittedBox(
                      child: Text(
                        'Recent transactions',
                        style: TextStyle(
                          // fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.80,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 8,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).accentColor,
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: FittedBox(
                                  child: Text(
                                    '₹${transactions[index].amount}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              transactions[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            subtitle: Text(
                              new DateFormat('dd-MM-yyyy')
                                  .add_jm()
                                  .format(transactions[index].date),
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            trailing: mediaQuery.size.width > 450
                                ? TextButton.icon(
                                    onPressed: () =>
                                        deleteTx(transactions[index].id),
                                    icon: const Icon(Icons.delete),
                                    style: TextButton.styleFrom(
                                      primary: Theme.of(context).accentColor,
                                    ),
                                    label: const Text('Delete'),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Theme.of(context).accentColor,
                                    onPressed: () =>
                                        deleteTx(transactions[index].id),
                                  ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    ),
                  ),
                ],
              ),
            );
    });
  }
}

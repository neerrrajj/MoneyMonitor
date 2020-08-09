import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;

  TransactionList(
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    final reversedTransactions = transactions.reversed.toList();
    return LayoutBuilder(
      builder: (context, contraints) {
        return transactions.isEmpty
            ? Container(
                alignment: Alignment(0.0, -0.5),
                child: Text(
                  'No transactions yet',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                  ),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(10),
                        child: reversedTransactions[index].type == 1
                            ? Icon(Icons.arrow_upward,
                                color: Colors.green, size: 33)
                            : Icon(Icons.arrow_downward,
                                color: Colors.red, size: 33),
                      ),
                      title: Text(
                        reversedTransactions[index].title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(reversedTransactions[index].date),
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 15,
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 20,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Rs.${reversedTransactions[index].amount}',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: Colors.black87,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black54,
                              size: 25,
                            ),
                            onPressed: () =>
                                deleteTx(reversedTransactions[index].id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              );
      },
    );
  }
}

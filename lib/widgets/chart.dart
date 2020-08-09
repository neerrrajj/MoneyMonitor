import 'package:flutter/material.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  Map<String, double> get separateTransactions {
    double income = 0;
    double expense = 0;
    double total = 0;
    double difference = 0;

    for (var i = 0; i < recentTransactions.length; i++) {
      if (recentTransactions[i].type == 1) {
        income += recentTransactions[i].amount;
      } else {
        expense += recentTransactions[i].amount;
      }
    }
    total = income + expense;
    difference = (income - expense);
    return {
      'income': income,
      'expense': expense,
      'total': total,
      'difference': difference,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Weekly cashflow',
              style: TextStyle(
                // fontFamily: 'Nunito',
                color: Colors.black87,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            separateTransactions['income'] == 0 &&
                    separateTransactions['expense'] == 0
                ? Text(
                    'Add a new transaction',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        children: <Widget>[
                          Container(
                            // height: constraints.maxHeight * 0.1,
                            width: constraints.maxWidth * 0.43,
                            padding: EdgeInsets.only(right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 140,
                                  height: 15,
                                  // color: Colors.grey,
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        separateTransactions['total'] == 0
                                            ? 0
                                            : separateTransactions['income'] /
                                                separateTransactions['total'],
                                    child: Container(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 140,
                                  height: 15,
                                  // color: Colors.grey,
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        separateTransactions['total'] == 0
                                            ? 0
                                            : separateTransactions['expense'] /
                                                separateTransactions['total'],
                                    child: Container(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // alignment: Alignment.centerLeft,
                            width: constraints.maxWidth * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FittedBox(
                                  child: Text(
                                    '${separateTransactions['income'].toString()}',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FittedBox(
                                  child: Text(
                                    '${separateTransactions['expense'].toString()}',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: constraints.maxWidth * 0.25,
                            child: FittedBox(
                              child: Text(
                                'Rs.${separateTransactions['difference'].abs().toInt().toString()}',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color:
                                        separateTransactions['difference'] < 0
                                            ? Colors.red
                                            : Colors.green),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}

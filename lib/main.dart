import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './models/transactions.dart';
import './widgets/newtransaction.dart';
import './widgets/transactionlist.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(200, 215, 227, 1),
        accentColor: Color.fromRGBO(47, 78, 111, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          
              headline6: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.black,
              ),
            ),
        appBarTheme: AppBarTheme(
          color: Colors.white60,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  color: Colors.white60
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _userTransactions = [];

  void _openAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(
      String title, double amount, DateTime chosenDate, int group) {
    final newTx = Transactions(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
      type: group,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Transactions> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Theme.of(context).appBarTheme.color,
        ),
        onPressed: () {},
      ),
      title: Text(
        'Hello User',
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).appBarTheme.color,
          ),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(152,177,196, 1),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.24,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape)
              Container(
                alignment: Alignment.centerLeft,
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.08,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10,),
                child: Text(
                  'Recent transactions ',
                  style: TextStyle(
                    // fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.68,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
            if (isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    1,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: mediaQuery.size.width * 0.5,
                      // height: mediaQuery.size.height * 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: mediaQuery.size.height * 0.4,
                            width: mediaQuery.size.width * 0.48,
                            child: Chart(_recentTransactions),
                          ),
                          Container(
                            height: mediaQuery.size.height * 0.1,
                            width: mediaQuery.size.width * 0.2,
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: FittedBox(
                                child: Text(
                                  'Add transaction',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              onPressed: () => _openAddNewTransaction(context),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.5,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Column(
                          children: <Widget>[
                            Container(
                              height: constraints.maxHeight * 0.15,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Recent transactions ',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: constraints.maxHeight * 0.85,
                              child: TransactionList(
                                  _userTransactions, _deleteTransaction),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Opacity(
              opacity: !isLandscape ? 1 : 0,
              child: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () => _openAddNewTransaction(context),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

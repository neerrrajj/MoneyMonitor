import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import './transactionlist.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int group = 1;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addtx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
      group,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Card(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 30),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Date : ${_selectedDate == null ? 'No date chosen' : DateFormat.yMMMd().format(_selectedDate)}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                      ),
                    ),
                    FlatButton(
                      onPressed: _datePicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: group,
                          onChanged: (val) {
                            setState(() {
                              group = val;
                            });
                          },
                        ),
                        Text(
                          'Income',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: group,
                          onChanged: (val) {
                            setState(() {
                              group = val;
                            });
                          },
                        ),
                        Text(
                          'Expense',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: _submitData,
                    child: Text(
                      'ADD',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

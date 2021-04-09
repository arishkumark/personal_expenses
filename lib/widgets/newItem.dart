import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewItem extends StatefulWidget {
  final Function onAddNew;
  NewItem(this.onAddNew);

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _handleSubmit() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (!title.isEmpty && amount > 0 && _selectedDate != null) {
      widget.onAddNew(title, amount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _handleDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate== null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              controller: _titleController,
              onSubmitted: (_) => _handleSubmit()
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount'
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _handleSubmit()
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null ? 'No date Chosen!' : DateFormat('MMM d, y').format(_selectedDate))
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: _handleDatePicker
                  )
                ]
              )
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: _handleSubmit,
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor
            )
          ]
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx){
    print('Constructor NewTransaction Widget');
  }

  @override
  State<NewTransaction> createState() {
     print('createState NewTransaction Widget');
     return _NewTransactionState();

  }
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // _selectDate is not <final> because this will change,
  // it has no value initially and it will receive a value once the
  // user choose a date,
  DateTime _selectDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  // override is added because initState is implemented by the state class
  // we're inheriting from,  and if we add it on our own, we add @override
  // to make it clear that this is not a mistake but that we deliberately
  // want to add our own, which means that the one in the parent class
  // State which we're extending is not called anymore
  void initState() {
    // TODO: implement initState
    // <super> is a keyword in Dart which refers to the parent class.
    // super.initState() make sure that the parent object <State> we
    // also call initState() there as will, So that not just our own
    // initState function runs but also the one that was built into 
    // the State.

    // But before super.initState() is called, however you can do your 
    // own initialization and often that is for example used to make a 
    // HTTP request and load some data from a server or load some data
    // from a database,

    // USE: initState() is often used for fetching some initial data you 
    // need in your app or in a widget of your app.
    super.initState();
  }

  @override
  
  // This is called when the widget that is attached to the State changes
  // and then Flutter actually gives you the old widget, so that you for
  // example could compare it to the new Widget because remember
  // <widget> property which you can use in you State, it always gives
  // you access to your related widget, to you attached widget that belongs
  // to that state.
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // widget will now automatically refer to the updated Widget, 
    print('didUpdatedWidget()');
    //
    super.didUpdateWidget(oldWidget);
  }

  // the State also can get removed at some point of time and for that
  // we can add dispose()
  @override
  void dispose() {
    // dispose is great for cleaning up data. Let's say you have a listner
    // to a real time internet connection which sends you new messages
    // because you're building a chat application or anything like that
    // then you want to clean up this connection to your server in here,
    // when your wiget is removed, so that you don't have that ongoing
    // connection in memory even though you have no widget anymore,
    // otherwise it will lead to strange bugs and also to  memory leaks.
    // So cleaning up listeners or live connections, that is something 
    // you would often do in dispose().
    print('dispose()');
    super.dispose();
  }

  // method to show date picker
  void _presentDatePicker() {
    print('_presentDatePicker got hit!');
    // Just like showModelBottomSheet() , showDatePicker() which
    // Flutter gives us automatically,
    //initialDate: is the date which is automatically selected when
    // this picker open.
    //firstDate: the starting date from which a user can select a valid date
    // lastDate: the last date before which a user can select a date

    // ********FUTURE***************
    // future is a class built into dart, not in flutter but in dart.
    // and its very important class, Futures are classes that allow
    // us to create objects which will gives us a value in future.
    // So you use a future for example also for HTTP requests where
    // you need to wait for a response to come back from the server,
    // Here we have to wait for the user to pick a value.
    // showDatePicker() immediately when we call it returns a Future but
    // it can't immediately gives us the date ther user picked.
    // we don't know when the user is going to choose a date and click.
    // so we get back that future which will then trigger once ther user
    // picked a date
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        // // then simply allow us to provide a function which is executed
        // once the future resolves to a value, so once the user choose a date
        // So here we can pass in an anonymous function which will be tiggered
        // once the user choose a date

        // This function will we called once the user choose a date
        //

        print('showDatePicker is hit!');
        if (pickedDate == null) {
          // if the user pressed cancel, then just return
          return;
        }
        // now we use that date in our app
        setState(() {
          _selectDate = pickedDate;
        });
      },
    );
    // PLEASE NOTE: code execution in you app will not pause and wait for
    // this to happen, the cool thing about Future is that the func() we
    // pass in here is stored in memory and the other code after showDatePicker
    // will execute immediately and will not wait for this future to resolve
    //
  }

  void _saveTransaction() {
    // perform some validation
    final enteredTitle = _titleController.text;
    final amount = _amountController.text;

    final enteredAmount = (amount.isEmpty) ? 0 : double.parse(amount);

    if (enteredTitle.isEmpty || enteredAmount <= 0 && _selectDate == null) {
      // if we're able to make into the if block , we not try to add a
      // new transaction
      return;
    }

    //Problem: addTx() is defined in the NewTransaction class not in the
    // NewTransactionState class. And technically these are two different
    // classes.
    // Thankfully, Flutter establishes a connection and gives us a special
    // property inside our <State> class(widget)
    //widget is a special property inside of our state class
    // Note: with the help of <widget.(property_name) you can access the
    // properties and methods of your <Widget> class inside of your <State> class

// with widget.addTx() i can access the addtx() property even though i am
// in a different class.
// the widget property is only available in <state> class and
// it gives you access to connected widget
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );

// it's built into Flutter and it can do a lot of awesome stuff here.
// We simply use its <pop()> method to basically close the topmost screen
// that is displayed, and that is the model sheet if it's opened.
// so that closes that model sheet by popping it off

// just like <widget>, the <context> is a special property which is
// available with our <state> class here, even tough we never defined a
// property named <context>, it's made available because
// we extended <State>
// <widget> gives you access to the class itself, to its properties and soon.
// <context> gives you access to the Context related to the widget
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // title textField
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _saveTransaction(),
                ),
                // amount textField
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  // on clicking on the <done> button in the keyborad
                  // using <onSubmitted:> property
                  // "_" is convention to signal that
                  // I get an argument but I don't care about it
                  // I have to accept it but I don't plan on using it,
    
                  onSubmitted: (_) => _saveTransaction(),
    
                  //onChanged: (val) => amountInput = val,
                ),
    
                //*************************************** */
                // Flutter has its own built-in date picker widget
                // open ups as an overly on the scree.
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(_selectDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date:${DateFormat.yMMMd().format(_selectDate)}')),
                      TextButton(
                        onPressed: () {
                          print('show the datePicker');
                          _presentDatePicker();
                        },
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
    
                ElevatedButton(
                  onPressed: _saveTransaction,
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).textTheme.labelLarge.color,
                  ),
                  child: const Text(
                    'Add Transaction',
                  ),
                )
              ]),
      ),
    );
  }
}

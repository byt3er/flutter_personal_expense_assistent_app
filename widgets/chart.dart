// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  //const Chart({Key key}) : super(key: key);

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  // define <getter> to generate bars dynamically
  List<Map<String, Object>> get groupedTansactionValues {
    return List.generate(7, (index)  {
      // this anonymous function is called for every element
      // so it executes this function for every generated list element with
      // index being 0, 1, 2, 3, 4, 5, 6,
      //// because the index is always one lower than lenght.
      
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++){
        if(recentTransactions[i].date.day == weekDay.day && 
        recentTransactions[i].date.month == weekDay.month &&
        recentTransactions[i].date.year == weekDay.year ) {
            totalSum += recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);

      //DateFormat.E(weekDay) gives us the shortcut for the weekday,
      // so M for Monday, T for Tuesday and so on,
      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1) ,
        'amount': totalSum
      };
      // .reserved gives us iterables so we need to convert it back to list
    }).reversed.toList();
  }
  // calculate total speding in percentage
  double get totalSpending {
    //the sum of the total sums of each day gives us the total sum of 
    // the entire week

    // .fold() allows us to change a list to another type with 
    // a certain logic we define in the function we pass to .fold()
    return groupedTansactionValues.fold(0.0, (sum, item) {
      // we have to return a new sum which will then be passed 
      // as an input to this function for the next element in line in
      // this list.
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTansactionValues.map((data) {
              //return Text('${data['day']}: ${data['amount']}')
              return Flexible(
                
                fit: FlexFit.tight,
                child: ChartBar(
                  data['Day'], 
                  data['amount'],
                  //data['amount'] / totalSpending gives us the ratio of how
                  // much of our total week spending did we spend on this day.
                   totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList()
          ),
        ),
    );
  }
}

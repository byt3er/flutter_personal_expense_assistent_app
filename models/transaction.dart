import 'package:flutter/foundation.dart';
// this will be a normal class and it will not
//extend <stateless> widget because transaction class
// here will just be a blueprint for a normal Dart
// object which I want to use in my Dart code.
class Transaction {
  // define how a transaction should look like
  final String id;
  final String title;
  final double amount;
  // Datetime is a type that's build into Dart
  // it's essentially based on a predefined class
  // Dart ships with, it's not like primitive, like
  // String, int or Double or boolean
  // it's a bit more complex object
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}

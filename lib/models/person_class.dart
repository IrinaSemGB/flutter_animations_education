import 'package:flutter/cupertino.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  Person({required this.name, required this.age, required this.emoji});
}
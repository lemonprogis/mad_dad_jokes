import 'package:flutter/material.dart';

class Joke with ChangeNotifier {
  final String q;
  final String a;

  Joke({required this.q, required this.a});
}

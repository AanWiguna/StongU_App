import 'package:flutter/material.dart';
import 'package:strong_u/loading.dart';

void main() {
  runApp(StrongU());
}

class StrongU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}

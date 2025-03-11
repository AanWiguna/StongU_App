import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment(0.0, -1.2),
        child: Container(
          width: 500,
          height: 270,
          decoration: BoxDecoration(
            color: Color(0xFF0392FB),
            borderRadius: BorderRadius.circular(64),
          ),
        ),
      ),
    );
  }
}

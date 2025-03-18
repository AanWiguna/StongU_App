import 'package:flutter/material.dart';

class ProgramTaken extends StatelessWidget {
  const ProgramTaken({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Program Taken"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          "Ini Halaman Program Taken",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

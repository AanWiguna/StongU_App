import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:strong_u/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StrongU());
}

class StrongU extends StatelessWidget {
  const StrongU({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}

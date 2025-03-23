import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(fontFamily: "Futura")),
        backgroundColor: Color(0xFF0392FB),
      ),
      body: Center(
        child: Text(
          "Halaman Pembayaran",
          style: TextStyle(fontSize: 20, fontFamily: "Futura"),
        ),
      ),
    );
  }
}

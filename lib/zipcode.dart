import 'package:flutter/material.dart';
import 'package:strong_u/birthday.dart';

class Zipcode extends StatelessWidget {
  final TextEditingController _zipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Gambar background
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Zipcode.png"),
          ),
          // Titik-titik dekoratif
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_zipcode.png"),
            ),
          ),
          // Judul
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 475, left: 10, right: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text.rich(
                  TextSpan(
                    text: "Enter Your ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura",
                    ),
                    children: [
                      TextSpan(
                        text: "Zipcode",
                        style: TextStyle(color: Color(0xFF0392FB)),
                      ),
                      TextSpan(text: "!"),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Tombol Back
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Input ZIP Code
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 250),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Color(0xFF50BDF5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _zipcodeController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                    decoration: InputDecoration(
                      hintText: "ZIP code",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Tombol Next
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 700),
              child: ElevatedButton(
                onPressed: () {
                  String zipCode = _zipcodeController.text.trim();
                  if (zipCode.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter your ZIP code!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Birthday()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Next!          ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: "Futura",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

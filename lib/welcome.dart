import 'package:flutter/material.dart';
import 'package:strong_u/login.dart';
import 'package:strong_u/signUp.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset("picture/Welcome.png"),
          ),

          //judul
          //posisi judul
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 475),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text.rich(
                  TextSpan(
                    text: "Welcome to ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura",
                    ),
                    children: [
                      TextSpan(
                        text: "StrongU",
                        style: TextStyle(
                          color: Color(0xFF0392FB),
                        ),
                      ),
                      TextSpan(
                        text: "!",
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 360),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "            Login            ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 500),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Color(0xFF0392FB),
                        width: 3,
                      )),
                ),
                child: Text(
                  "          Sign Up          ",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF0392FB),
                      fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:strong_u/zipcode.dart';

class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar background
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset("picture/opening.png"),
          ),

          // Titik-titik
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_opening.png"),
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
                    text: "Meet with ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura",
                    ),
                    children: [
                      TextSpan(
                        text: "Professional",
                        style: TextStyle(color: Color(0xFF0392FB)),
                      ),
                      TextSpan(text: " Personal Trainer"),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Subjudul
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 565, left: 35, right: 35),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: Text(
                  "Find the Perfect Personal Trainer to Transform Your Fitness Journey Today!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontFamily: "montserrat",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Tombol next
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 700),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Zipcode()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Start!          ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

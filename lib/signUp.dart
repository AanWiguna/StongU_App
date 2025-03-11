import 'package:flutter/material.dart';
import 'package:strong_u/login.dart';
import 'package:strong_u/opening.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _UsernameController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PhoneController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
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
            child: Image.asset("picture/SignUp.png"),
          ),

          //judul
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 45, top: 265),
              child: Text(
                "Sign Up",
                style: TextStyle(fontFamily: "futura", fontSize: 36),
              ),
            ),
          ),

          //subjudul
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 45, top: 310),
              child: Text(
                "Please create account to continue",
                style: TextStyle(fontFamily: "montserrat", fontSize: 18),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 370),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF0392FB),
                  width: 2.0,
                ),
              ),
              child: TextField(
                controller: _UsernameController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Color(0xFF0392FB), fontFamily: "montserrat"),
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Color(0xFF0392FB)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 440),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF0392FB),
                  width: 2.0,
                ),
              ),
              child: TextField(
                controller: _EmailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: Color(0xFF0392FB), fontFamily: "montserrat"),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Color(0xFF0392FB)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 510),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF0392FB),
                  width: 2.0,
                ),
              ),
              child: TextField(
                controller: _PhoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    color: Color(0xFF0392FB), fontFamily: "montserrat"),
                decoration: InputDecoration(
                  hintText: "Phone number",
                  hintStyle: TextStyle(color: Color(0xFF0392FB)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 580),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF0392FB),
                  width: 2.0,
                ),
              ),
              child: TextField(
                controller: _PasswordController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Color(0xFF0392FB), fontFamily: "montserrat"),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Color(0xFF0392FB)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 85, top: 735),
              child: Text(
                "Already have an account?",
                style: TextStyle(fontFamily: "montserrat", fontSize: 12),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 255, top: 735),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "futura",
                    fontSize: 13,
                    color: Color(0xFF0392FB),
                  ),
                ),
              ),
            ),
          ),

          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 490),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  String Username = _UsernameController.text.trim();
                  String Password = _PasswordController.text.trim();
                  String Email = _EmailController.text.trim();
                  String Phone = _PhoneController.text.trim();
                  if (Username.isEmpty ||
                      Password.isEmpty ||
                      Email.isEmpty ||
                      Phone.isEmpty) {
                    // Jika input kosong, tampilkan SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter your username, email, phone number & password!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Jika sudah terisi, navigasi ke halaman berikutnya
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpeningPage()),
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
                  "          Sign Up          ",
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

import 'package:flutter/material.dart';
import 'package:strong_u/home.dart';
import 'package:strong_u/signUp.dart';

class Login extends StatelessWidget {
  final TextEditingController _UsernameController = TextEditingController();
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
            alignment: Alignment.topCenter,
            child: Image.asset("picture/Login.png"),
          ),
          //judul
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 45, top: 485),
              child: Text(
                "Login",
                style: TextStyle(fontFamily: "futura", fontSize: 36),
              ),
            ),
          ),

          //subjudul
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 45, top: 530),
              child: Text(
                "Please sign in to continue",
                style: TextStyle(fontFamily: "montserrat", fontSize: 18),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 90, top: 810),
              child: Text(
                "Don't have an account?",
                style: TextStyle(fontFamily: "montserrat", fontSize: 12),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 340),
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
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 470),
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
              padding: EdgeInsets.only(left: 248, top: 810),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text(
                  "Sign up",
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
              margin: EdgeInsets.only(top: 640),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  String Username = _UsernameController.text.trim();
                  String Password = _PasswordController.text.trim();
                  if (Username.isEmpty || Password.isEmpty) {
                    // Jika input kosong, tampilkan SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter your username & password!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Jika sudah terisi, navigasi ke halaman berikutnya
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
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
                  "            Login            ",
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

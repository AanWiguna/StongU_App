import 'package:flutter/material.dart';

void main() {
  runApp(StrongU());
}

class StrongU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OpeningPage(),
    );
  }
}

//opening page
class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/opening.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_opening.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Meet with ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Professional",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: " Personal Trainer",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //sub judul
          //posisi
          Positioned(
            left: 35,
            top: 565,
            //biar ga lewat hp
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: Text(
                "Find the Perfect Personal Trainer to Transform Your Fitness Journey Today!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontFamily: "montserrat"),
                //rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
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
          )
        ],
      ),
    );
  }
}

class Zipcode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Zipcode.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_zipcode.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Enter Your ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Zipcode",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Birthday()),
                  );
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
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Birthday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/birthday.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_birthday.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Choose Your ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Birthday",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SesssionStart()),
                  );
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
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SesssionStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/SessionStart.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_SessionStart.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Choose Your ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Session",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SesssionDay()),
                  );
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
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SesssionDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/SessionDay.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_SessionDay.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Choose Your ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Session Day",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Goal()),
                  );
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
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Goal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Goal.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_Goal.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Set Your ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Goals",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Begin!          ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Welcome.png"),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Welcome to ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
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
                //tulisan rata tengah
                textAlign: TextAlign.center,
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

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Login.png"),
          ),
          //judul
          Positioned(
            left: 45,
            top: 485,
            child: Text(
              "Login",
              style: TextStyle(fontFamily: "futura", fontSize: 36),
            ),
          ),
          //subjudul
          Positioned(
            left: 45,
            top: 530,
            child: Text(
              "Please sign in to continue",
              style: TextStyle(fontFamily: "montserrat", fontSize: 18),
            ),
          ),
          Positioned(
            left: 90,
            top: 810,
            child: Text(
              "Don't have an account?",
              style: TextStyle(fontFamily: "montserrat", fontSize: 12),
            ),
          ),
          Positioned(
            left: 248,
            top: 810,
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
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 640),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
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
        ],
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/SignUp.png"),
          ),
          //judul
          Positioned(
            left: 45,
            top: 265,
            child: Text(
              "Sign Up",
              style: TextStyle(fontFamily: "futura", fontSize: 36),
            ),
          ),
          //subjudul
          Positioned(
            left: 45,
            top: 310,
            child: Text(
              "Please create account to continue",
              style: TextStyle(fontFamily: "montserrat", fontSize: 18),
            ),
          ),
          Positioned(
            left: 85,
            top: 735,
            child: Text(
              "Already have an account?",
              style: TextStyle(fontFamily: "montserrat", fontSize: 12),
            ),
          ),
          Positioned(
            left: 255,
            top: 735,
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
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 490),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 100, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text(
              "PERANG BARU DIMULAI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpeningPage()),
                );
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

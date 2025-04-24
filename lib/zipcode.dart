import 'package:flutter/material.dart';
import 'package:strong_u/birthday.dart';
import 'package:strong_u/page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Zipcode extends StatefulWidget {
  const Zipcode({super.key});

  @override
  State<Zipcode> createState() => _ZipcodeState();
}

class _ZipcodeState extends State<Zipcode> {
  final TextEditingController _zipcodeController = TextEditingController();

  void _addZipcode(String userId) async {
    try {
      String zipcode = _zipcodeController.text;

      // Update Firestore document to add zipcode
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'zipcode': zipcode,
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Birthday()),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _validateAndProceed() {
    String zip = _zipcodeController.text.trim();
    if (zip.isEmpty) {
      _showSnackbar("Please enter your ZIP code!");
    } else if (zip.length < 5 || zip.length > 6) {
      _showSnackbar("ZIP code must be 5 or 6 digits!");
    } else {
      // Get the current user's ID
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        _addZipcode(userId); // Call the function to add/update zipcode
      } else {
        _showSnackbar("User  not logged in!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0392FB), Color(0xFF025795)],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.72,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
            ),
          ),

          // Judul
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 475, left: 10, right: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text.rich(
                  TextSpan(
                    text: "Enter Your ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura",
                    ),
                    children: [
                      const TextSpan(
                        text: "Zipcode",
                        style: TextStyle(color: Color(0xFF0392FB)),
                      ),
                      const TextSpan(text: "!"),
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
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255), size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Form Input ZIP Code
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xFF50BDF5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _zipcodeController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Futura",
                    ),
                    decoration: const InputDecoration(
                      hintText: "ZIP code",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Indikator Halaman
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: PageIndicator(currentIndex: 1, totalPages: 7),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Image.asset(
                "picture/Zipcode.png",
                width: 350,
                height: 350,
              ),
            ),
          ),
          // Tombol Next
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Next!",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: "Futura",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

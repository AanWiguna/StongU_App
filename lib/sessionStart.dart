import 'package:flutter/material.dart';
import 'package:strong_u/page_indicator.dart';
import 'package:strong_u/sessionDay.dart';

class SesssionStart extends StatefulWidget {
  const SesssionStart({super.key});

  @override
  _SesssionStartState createState() => _SesssionStartState();
}

class _SesssionStartState extends State<SesssionStart> {
  // Menyimpan status pemilihan tombol
  Map<String, bool> selectedSessions = {
    "Morning": false,
    "Noon": false,
    "Night": false,
  };

  bool isNextEnabled = false;

  void _updateNextButtonState() {
    setState(() {
      isNextEnabled = selectedSessions.values.any((value) => value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
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
              padding: const EdgeInsets.only(top: 475),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text.rich(
                  TextSpan(
                    text: "Choose Your ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura",
                    ),
                    children: [
                      TextSpan(
                        text: "Session",
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
          // Tombol sesi (multi-select)
          Align(
            alignment: Alignment(0.0, 0.45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSessionButton("Morning", "06.00 - 12.00"),
                _buildSessionButton("Noon", "12.00 - 18.00"),
                _buildSessionButton("Night", "18.00 - 22.00"),
              ],
            ),
          ),
          // Indikator Halaman
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: PageIndicator(currentIndex: 3, totalPages: 7),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Image.asset(
                "picture/SessionStart.png",
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
                onPressed: () {
                  if (isNextEnabled) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SesssionDay()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please select at least one session!",
                          style: TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isNextEnabled ? const Color(0xFF0392FB) : Colors.grey,
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

  // Function untuk membangun tombol sesi
  Widget _buildSessionButton(String session, String time) {
    bool isSelected = selectedSessions[session] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              selectedSessions[session] = !isSelected;
            });
            _updateNextButtonState();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Color(0xFF0392FB) : Colors.white,
            side: BorderSide(color: Color(0xFF0392FB), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                session,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.white : Color(0xFF0392FB),
                  fontFamily: "futura",
                ),
              ),
              SizedBox(),
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Color(0xFF0392FB),
                  fontFamily: "montserrat",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

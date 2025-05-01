import 'package:flutter/material.dart';
import 'package:strong_u/level.dart';
import 'package:strong_u/page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SesssionDay extends StatefulWidget {
  const SesssionDay({super.key});

  @override
  _SesssionDayState createState() => _SesssionDayState();
}

class _SesssionDayState extends State<SesssionDay> {
  Map<String, bool> selectedDays = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  bool isNextEnabled = false;

  void _updateNextButtonState() {
    setState(() {
      isNextEnabled = selectedDays.values.any((value) => value);
    });
  }

  Future<void> _saveDaysAndNext() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        _showSnackbar("User not logged in!");
        return;
      }

      List<String> selected = selectedDays.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'preferred_days': selected,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LevelSelection()),
      );
    } catch (e) {
      _showSnackbar("Error saving days: $e");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: PageIndicator(currentIndex: 4, totalPages: 7),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 475, left: 10, right: 10),
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
                      text: "Session Day",
                      style: TextStyle(color: Color(0xFF0392FB)),
                    ),
                    TextSpan(text: "!"),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.62),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayButton("Monday"),
                    SizedBox(width: 10),
                    _buildDayButton("Tuesday"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayButton("Wednesday"),
                    SizedBox(width: 10),
                    _buildDayButton("Thursday"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayButton("Friday"),
                    SizedBox(width: 10),
                    _buildDayButton("Saturday"),
                  ],
                ),
                _buildDayButton("Sunday"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Image.asset(
                "picture/SessionDay.png",
                width: 350,
                height: 350,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  if (isNextEnabled) {
                    _saveDaysAndNext();
                  } else {
                    _showSnackbar("Please select at least one day!");
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

  Widget _buildDayButton(String day) {
    bool isSelected = selectedDays[day] ?? false;

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 160,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDays[day] = !isSelected;
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
        child: Text(
          day,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.white : Color(0xFF0392FB),
            fontFamily: "futura",
          ),
        ),
      ),
    );
  }
}

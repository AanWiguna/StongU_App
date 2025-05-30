import 'package:flutter/material.dart';
import 'package:strong_u/page_indicator.dart';
import 'package:strong_u/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LevelSelection extends StatefulWidget {
  const LevelSelection({super.key});

  @override
  _LevelSelectionState createState() => _LevelSelectionState();
}

class _LevelSelectionState extends State<LevelSelection> {
  String? _selectedLevel;
  bool isNextEnabled = false;

  void _updateNextButtonState() {
    setState(() {
      isNextEnabled = _selectedLevel != null;
    });
  }

  Future<void> _saveLevelAndNext() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        _showSnackbar("User not logged in!");
        return;
      }

      if (_selectedLevel != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'level':
              _selectedLevel, // Store as a string to match profile page format
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Goal()),
        );
      } else {
        _showSnackbar("Please select a level!");
      }
    } catch (e) {
      _showSnackbar("Error saving level: $e");
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
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0392FB), Color(0xFF025795)],
              ),
            ),
          ),

          // Back button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // White panel
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

          // Title
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 475),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text.rich(
                  TextSpan(
                    text: "Choose Your ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura",
                    ),
                    children: const [
                      TextSpan(
                        text: "Level",
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

          // Level buttons
          Align(
            alignment: const Alignment(0.0, 0.45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLevelButton("Beginner", "0-1 Year Experience"),
                _buildLevelButton("Intermediate", "1-3 Years Experience"),
                _buildLevelButton("Expert", "3+ Years Experience"),
              ],
            ),
          ),

          // Page Indicator
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 110),
              child: PageIndicator(currentIndex: 5, totalPages: 7),
            ),
          ),

          // Top image
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Image.asset(
                "picture/LevelSelection.png",
                width: 350,
                height: 350,
              ),
            ),
          ),

          // Next button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  if (isNextEnabled) {
                    _saveLevelAndNext();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please select a level!",
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

  // Button builder
  Widget _buildLevelButton(String level, String experience) {
    bool isSelected = _selectedLevel == level;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedLevel = level;
            });
            _updateNextButtonState();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isSelected ? const Color(0xFF0392FB) : Colors.white,
            side: const BorderSide(color: Color(0xFF0392FB), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                level,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.white : const Color(0xFF0392FB),
                  fontFamily: "Futura",
                ),
              ),
              Text(
                experience,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : const Color(0xFF0392FB),
                  fontFamily: "Montserrat",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

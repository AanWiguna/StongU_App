import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Map<String, dynamic>? userData;
  bool isEditing = false;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController zipcodeController;

  List<String> selectedSessions = [];
  List<String> selectedDays = [];
  List<String> selectedGoals = [];
  String? selectedLevel;

  final List<String> sessionOptions = ['Morning', 'Noon', 'Night'];
  final List<String> goalsOptions = [
    'Weight Loss',
    'Weight Gain',
    'Firming & Toning',
    'Flexibility',
    'Increase Muscle Strength',
    'Aerobic Fitness',
    'Endurance Training',
    'Body Building'
  ];
  final List<String> dayOptions = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> levelOptions = ['Beginner', 'Intermediate', 'Expert'];

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    birthdayController = TextEditingController();
    zipcodeController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final docSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (docSnapshot.exists) {
          setState(() {
            userData = docSnapshot.data();
            emailController.text = userData?['email'] ?? '';
            phoneController.text = userData?['phone'] ?? '';
            birthdayController.text = userData?['birthday'] ?? '';
            zipcodeController.text = userData?['zipcode'] ?? '';
            selectedSessions =
                List<String>.from(userData?['preferred_sessions'] ?? []);
            selectedDays = List<String>.from(userData?['preferred_days'] ?? []);
            selectedGoals = List<String>.from(userData?['goals'] ?? []);
            selectedLevel = userData?['level'] ?? '';
          });
        }
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<void> _saveProfile() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'email': emailController.text,
          'phone': phoneController.text,
          'birthday': birthdayController.text,
          'zipcode': zipcodeController.text,
          'preferred_sessions': selectedSessions,
          'preferred_days': selectedDays,
          'goals': selectedGoals,
          'level': selectedLevel,
        });
        print("Profile updated successfully!");
      }
    } catch (e) {
      print("Error saving profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF0392FB), Color(0xFF50BDF5)],
                    ),
                  ),
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment
                                    .center, // Center the profile picture
                                child: Stack(
                                  children: [
                                    const CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('picture/profile.png'),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 15,
                                        child: const Icon(Icons.camera_alt,
                                            color: Colors.white, size: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment:
                                    Alignment.center, // Center the username
                                child: Text(
                                  userData?['username'] ?? 'No Username',
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: 'Futura'),
                                ),
                              ),
                              const SizedBox(height: 10),
                              buildEditableField('Email', emailController),
                              buildEditableField(
                                  'Phone Number', phoneController),
                              buildEditableField(
                                  'Birthday', birthdayController),
                              buildEditableField('Zipcode', zipcodeController),
                              buildSelectableField('Session Time',
                                  selectedSessions, sessionOptions),
                              buildSelectableField(
                                  'Session Day', selectedDays, dayOptions),
                              buildSingleSelectableField(
                                  'Level', selectedLevel, levelOptions,
                                  (newValue) {
                                setState(() {
                                  selectedLevel = newValue;
                                });
                              }),
                              buildSelectableField(
                                  'Goals', selectedGoals, goalsOptions),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  if (isEditing) {
                                    await _saveProfile();
                                  }
                                  setState(() {
                                    isEditing = !isEditing;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                    isEditing ? 'Save Profile' : 'Edit Profile',
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF0392FB)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildEditableField(String label, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontFamily: 'Futura'),
            ),
          ),
          TextField(
            controller: controller,
            readOnly: !isEditing,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectableField(
      String label, List<String> selectedValues, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontFamily: 'Futura'),
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            alignment: WrapAlignment.start,
            children: options.map((option) {
              final isSelected = selectedValues.contains(option);
              return GestureDetector(
                onTap: isEditing
                    ? () {
                        setState(() {
                          if (isSelected) {
                            selectedValues.remove(option);
                          } else {
                            selectedValues.add(option);
                          }
                        });
                      }
                    : null,
                child: Container(
                  margin: const EdgeInsets.only(right: 10, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.blue,
                      fontFamily: 'Futura',
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildSingleSelectableField(String label, String? selectedValue,
      List<String> options, void Function(String) onSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontFamily: 'Futura'),
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            alignment: WrapAlignment.start,
            children: options.map((option) {
              final isSelected = option == selectedValue;
              return GestureDetector(
                onTap: isEditing ? () => onSelected(option) : null,
                child: Container(
                  margin: const EdgeInsets.only(right: 10, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.blue,
                      fontFamily: 'Futura',
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

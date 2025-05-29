import 'package:flutter/material.dart';
import 'package:strong_u/MyProfile.dart';
import 'package:strong_u/SettingPage.dart';
import 'package:strong_u/home.dart';
import 'package:strong_u/login.dart';
import 'package:strong_u/programtaken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  Map<String, dynamic>? userData;

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Reset auto login
    await prefs.setBool('autoLogin', false);

    // Sign out dari Firebase
    await FirebaseAuth.instance.signOut();

    // Navigasi kembali ke halaman Login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
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
          });
        }
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                buildBottomNavBar(context),
                buildHeader(context),
                buildMenu(context),
              ],
            ),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, -4),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 55, bottom: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgramTaken()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child:
                    Icon(Icons.calendar_today, color: Colors.black, size: 30),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 55, bottom: 20),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(Icons.person_2_outlined,
                    color: Color(0xFF0392FB), size: 45),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(Icons.home, color: Colors.black, size: 45),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xFF0392FB),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("picture/profile.png"),
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userData?['username'] ?? 'No Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "futura",
                  ),
                ),
                Text(
                  userData?['email'] ?? 'No Email',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Text(
                  userData?['phone'] ?? 'No Phone',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Color(0xFF0392FB),
                        fontSize: 14,
                        fontFamily: "futura"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 30, top: 220, right: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildMenuButton(context, "My Profile", Icons.person, MyProfile()),
            SizedBox(height: 20),
            buildMenuButton(context, "Settings", Icons.settings, SettingPage()),
            SizedBox(height: 400),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.logout, color: Colors.white),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(
      BuildContext context, String title, IconData icon, Widget nextPage) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Color(0xFF0392FB)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(icon, color: Color(0xFF0392FB)),
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF0392FB),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

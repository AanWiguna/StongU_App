import 'package:flutter/material.dart';
import 'package:strong_u/MyProfile.dart';
import 'package:strong_u/PTprofile.dart';
import 'package:strong_u/SettingPage.dart';
import 'package:strong_u/chatList.dart';
import 'package:strong_u/programtaken.dart';
import 'package:strong_u/user_profile.dart';
import 'package:strong_u/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "";
  List<Map<String, dynamic>> ptList = [];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchPTData();
  }

  Future<void> _fetchUserName() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (doc.exists) {
          setState(() {
            userName = doc.data()?['username'] ?? 'No Name';
          });
        }
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  Future<void> _fetchPTData() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('PT').get();
      setState(() {
        ptList = snapshot.docs.map((doc) {
          return {
            'name': doc['Nama'],
            'price': "${doc['Harga']}K",
            'rating': (doc['Rating'] as num).toDouble(),
            'location': doc['Lokasi'],
            'exp': doc['Exp'],
            'description': doc['Deskripsi'],
            'image': "picture/PT${doc.id}.png",
          };
        }).toList();
      });
    } catch (e) {
      print("Error fetching PT data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xFF0392FB),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("picture/profile.png"),
                  ),
                  SizedBox(width: 10),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.chat),
                    title: Text('Chat'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Chatlist()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Program Taken'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProgramTaken()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('My Profile'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyProfile()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('FAQ'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About App'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // HEADER
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 190,
              padding: EdgeInsets.only(left: 40, right: 40, top: 50),
              decoration: BoxDecoration(
                color: Color(0xFF0392FB),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ROW MENU + PROFIL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // FOTO PROFIL
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("picture/profile.png"),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 9),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Welcome Back,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                userName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "futura",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // MENU BUTTON
                      Builder(
                        builder: (context) {
                          return Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.menu, color: Colors.white),
                              iconSize: 22,
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // SEARCH BAR + CHAT BUTTON
                  Row(
                    children: [
                      // SEARCH BAR
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: "Search PT",
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),
                      // CHAT BUTTON
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.chat, color: Colors.white),
                          iconSize: 22,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chatlist()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // UPCOMING PROGRAMS SECTION
          Padding(
            padding: EdgeInsets.only(top: 200, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UPCOMING PROGRAMS TITLE
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upcoming Programs",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "futura",
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // SCROLLABLE CONTAINER
                Container(
                  height: 120,
                  clipBehavior: Clip.none,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(1, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 10),
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            color: Color(0xFF0392FB),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Gambar PT
                              Positioned.fill(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 1),
                                  child: Image.asset(
                                    "picture/PThalfed.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Efek gradasi
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color(0xFF0267C1).withOpacity(0.5),
                                        Color(0xFF0392FB).withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 8),
                                        constraints: BoxConstraints(
                                            minWidth: 60, maxWidth: 100),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "09.00-10.00",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                            Text(
                                              "Monday",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Futura",
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Audid",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Futura",
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                            Text(
                                              "Gym",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Futura",
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // PT RECOMMENDATION
          Padding(
            padding: EdgeInsets.only(top: 370, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PT Recommendation",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "futura",
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: ptList.length,
                    itemBuilder: (context, index) {
                      final pt = ptList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PTProfile(
                                name: pt['name'],
                                price: pt['price'],
                                rating: pt['rating'],
                                image: pt['image'],
                                location: pt['location'],
                                exp: pt['exp'],
                                description: pt['description'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF0392FB),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 1,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Image.asset(
                                    pt['image'] ?? "picture/PT1.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color(0xFF0267C1).withOpacity(0.75),
                                        Color(0xFF0392FB).withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.0, 0.5),
                                child: Text(
                                  pt['name'] ?? "NO NAME",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Futura",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        constraints: BoxConstraints(
                                            minWidth: 60, maxWidth: 100),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Start From",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                            Text(
                                              pt['price'] ?? "N/A",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Futura",
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 9),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 16,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              pt['rating']?.toString() ?? "0",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Futura",
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // NAVBAR BAWAH
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

          // ICON KIRI BAWAH (KALENDAR)
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
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(Icons.calendar_today, color: Colors.black, size: 30),
                ),
              ),
            ),
          ),

          // ICON KANAN BAWAH (PROFILE)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 55, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileUser()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_2_outlined,
                      color: Colors.black, size: 45),
                ),
              ),
            ),
          ),

          // ICON TENGAH (HOME)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.home, color: Color(0xFF0392FB), size: 45),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

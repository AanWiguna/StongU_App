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
  List<Map<String, dynamic>> filteredPTList = []; // For search results
  Set<String> savedPTs = {}; // Track saved PTs
  TextEditingController searchController =
      TextEditingController(); // Search controller
  String searchQuery = ""; // Current search query

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchPTData();
    _fetchSavedPTs();

    // Listen to search input changes
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Handle search input changes
  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.toLowerCase();
      _filterPTList();
    });
  }

  // Filter PT list based on search query
  void _filterPTList() {
    if (searchQuery.isEmpty) {
      filteredPTList = List.from(ptList);
    } else {
      filteredPTList = ptList.where((pt) {
        final name = pt['name'].toString().toLowerCase();
        final location = pt['location'].toString().toLowerCase();
        final description = pt['description'].toString().toLowerCase();

        return name.contains(searchQuery) ||
            location.contains(searchQuery) ||
            description.contains(searchQuery);
      }).toList();
    }
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
            'id': doc.id,
            'name': doc['Nama'],
            'price': "${doc['Harga']}K",
            'rating': (doc['Rating'] as num).toDouble(),
            'location': doc['Lokasi'],
            'exp': doc['Exp'],
            'description': doc['Deskripsi'],
            'image': "picture/PT${doc.id}.png",
          };
        }).toList();

        // Initialize filtered list
        filteredPTList = List.from(ptList);
      });
    } catch (e) {
      print("Error fetching PT data: $e");
    }
  }

  Future<void> _fetchSavedPTs() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedPTs')
            .get();

        setState(() {
          savedPTs = doc.docs.map((doc) => doc.id).toSet();
        });
      }
    } catch (e) {
      print("Error fetching saved PTs: $e");
    }
  }

  Future<void> _savePT(Map<String, dynamic> pt) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        // Add to savedPTs subcollection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedPTs')
            .doc(pt['id'])
            .set({
          'name': pt['name'],
          'price': pt['price'],
          'rating': pt['rating'],
          'location': pt['location'],
          'exp': pt['exp'],
          'description': pt['description'],
          'image': pt['image'],
          'savedAt': FieldValue.serverTimestamp(),
        });

        setState(() {
          savedPTs.add(pt['id']);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${pt['name']} saved successfully!'),
            backgroundColor: Color(0xFF0392FB),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Error saving PT: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving PT. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _removeSavedPT(String ptId, String ptName) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        // Remove from savedPTs subcollection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedPTs')
            .doc(ptId)
            .delete();

        setState(() {
          savedPTs.remove(ptId);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$ptName removed from saved!'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Error removing saved PT: $e");
    }
  }

  // Clear search
  void _clearSearch() {
    searchController.clear();
    setState(() {
      searchQuery = "";
      filteredPTList = List.from(ptList);
    });
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
                            controller: searchController,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: "Search PT",
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear,
                                          color: Colors.white, size: 20),
                                      onPressed: _clearSearch,
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 9),
                            ),
                            onChanged: (value) {
                              // This triggers _onSearchChanged via the listener
                            },
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

          // PT RECOMMENDATION
          Padding(
            padding: EdgeInsets.only(top: 210, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      searchQuery.isEmpty
                          ? "PT Recommendation"
                          : "Search Results (${filteredPTList.length})",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "futura",
                        color: Colors.black,
                      ),
                    ),
                    if (searchQuery.isNotEmpty)
                      TextButton(
                        onPressed: _clearSearch,
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            color: Color(0xFF0392FB),
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),

                // Show message when no results found
                if (filteredPTList.isEmpty && searchQuery.isNotEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No PT found for '$searchQuery'",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Try searching with different keywords",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: filteredPTList.length,
                      itemBuilder: (context, index) {
                        final pt = filteredPTList[index];
                        final isSaved = savedPTs.contains(pt['id']);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PTProfile(
                                  docId: pt['id'],
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
                                // Save Button
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (isSaved) {
                                        _removeSavedPT(pt['id'], pt['name']);
                                      } else {
                                        _savePT(pt);
                                      }
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isSaved
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color: isSaved
                                            ? Color(0xFF0392FB)
                                            : Colors.grey[600],
                                        size: 20,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

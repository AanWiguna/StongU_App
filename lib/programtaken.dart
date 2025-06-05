import 'package:flutter/material.dart';
import 'package:strong_u/MyProfile.dart';
import 'package:strong_u/PTprofile.dart';
import 'package:strong_u/SettingPage.dart';
import 'package:strong_u/chatList.dart';
import 'package:strong_u/home.dart';
import 'package:strong_u/user_profile.dart';
import 'package:strong_u/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgramTaken extends StatefulWidget {
  const ProgramTaken({super.key});

  @override
  _ProgramTakenState createState() => _ProgramTakenState();
}

class _ProgramTakenState extends State<ProgramTaken> {
  // State variables
  String userName = "";
  List<Map<String, dynamic>> savedPrograms = [];
  List<Map<String, dynamic>> activePrograms = [];
  List<Map<String, dynamic>> filteredSavedPrograms = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  // Constants
  static const Color primaryColor = Color(0xFF0392FB);
  static const Color secondaryColor = Color(0xFF0267C1);

  @override
  void initState() {
    super.initState();
    _initializeData();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  // Search functionality
  void _onSearchChanged() {
    filterPrograms(searchController.text);
  }

  void filterPrograms(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredSavedPrograms = List.from(savedPrograms);
      });
    } else {
      List<Map<String, dynamic>> filteredList = savedPrograms
          .where((program) =>
              program['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        filteredSavedPrograms = filteredList;
      });
    }
  }

  // Initialize all data
  Future<void> _initializeData() async {
    await Future.wait([
      _fetchUserName(),
      _fetchSavedPrograms(),
      _fetchActivePrograms(),
    ]);
  }

  // Fetch user name from Firestore
  Future<void> _fetchUserName() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (doc.exists && mounted) {
          setState(() {
            userName = doc.data()?['username'] ?? 'No Name';
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching user name: $e");
    }
  }

  // Fetch saved programs from Firestore
  Future<void> _fetchSavedPrograms() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedPTs')
            .get();

        if (mounted) {
          setState(() {
            savedPrograms = snapshot.docs
                .map((doc) => {
                      'id': doc.id,
                      'name': doc.data()['name'] ?? 'Unknown',
                      'price': doc.data()['price'] ?? 'N/A',
                      'rating': doc.data()['rating'] ?? 0.0,
                      'location': doc.data()['location'] ?? 'Unknown',
                      'exp': doc.data()['exp'] ?? 'N/A',
                      'description': doc.data()['description'] ?? '',
                      'image': doc.data()['image'] ?? 'picture/PT1.png',
                      'savedAt': doc.data()['savedAt'],
                    })
                .toList();
            filteredSavedPrograms = List.from(savedPrograms);
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching saved programs: $e");
    }
  }

  // Fetch active programs from Firestore
  Future<void> _fetchActivePrograms() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('activePrograms')
            .get();

        if (mounted) {
          setState(() {
            activePrograms = snapshot.docs
                .map((doc) => {
                      'id': doc.id,
                      'ptId': doc.data()['ptId'] ?? '',
                      'ptName': doc.data()['ptName'] ?? 'Unknown PT',
                      'startDate': doc.data()['startDate'],
                      'endDate': doc.data()['endDate'],
                      'sessionsTotal': doc.data()['sessionsTotal'] ?? 0,
                      'sessionsCompleted': doc.data()['sessionsCompleted'] ?? 0,
                      'status': doc.data()['status'] ?? 'active',
                      'schedule': doc.data()['schedule'] ?? 'Not Set',
                      'image': doc.data()['image'] ?? 'picture/PThalfed.png',
                    })
                .toList();
            isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching active programs: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Remove saved program
  Future<void> _removeSavedProgram(String programId, String programName) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedPTs')
            .doc(programId)
            .delete();

        if (mounted) {
          setState(() {
            savedPrograms.removeWhere((program) => program['id'] == programId);
            filteredSavedPrograms
                .removeWhere((program) => program['id'] == programId);
          });

          _showSnackBar(
              '$programName removed from saved programs!', Colors.orange);
        }
      }
    } catch (e) {
      debugPrint("Error removing saved program: $e");
    }
  }

  // Start a program
  Future<void> _startProgram(Map<String, dynamic> program) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('activePrograms')
            .add({
          'ptId': program['id'],
          'ptName': program['name'],
          'startDate': FieldValue.serverTimestamp(),
          'endDate': null,
          'sessionsTotal': 12,
          'sessionsCompleted': 0,
          'status': 'active',
          'schedule': 'To be scheduled',
          'image': program['image'],
        });

        await _fetchActivePrograms();
        _showSnackBar('Program with ${program['name']} started!', Colors.green);
      }
    } catch (e) {
      debugPrint("Error starting program: $e");
      _showSnackBar('Error starting program. Please try again.', Colors.red);
    }
  }

  // Show snackbar helper
  void _showSnackBar(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Navigation helper
  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildDrawer(),
      body: Stack(
        children: [
          _buildHeader(),
          _buildActivePrograms(),
          _buildSavedPrograms(),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  // Build drawer widget
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(),
          const Divider(color: Colors.grey),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _buildDrawerItems(),
            ),
          ),
        ],
      ),
    );
  }

  // Build drawer header
  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: primaryColor,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("picture/profile.png"),
          ),
          const SizedBox(width: 10),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Build drawer items
  List<Widget> _buildDrawerItems() {
    final items = [
      {'icon': Icons.home, 'title': 'Home', 'page': Home()},
      {'icon': Icons.chat, 'title': 'Chat', 'page': Chatlist()},
      {
        'icon': Icons.calendar_today,
        'title': 'Program Taken',
        'page': ProgramTaken()
      },
      {'icon': Icons.person, 'title': 'My Profile', 'page': MyProfile()},
      {'icon': Icons.settings, 'title': 'Settings', 'page': SettingPage()},
      {'icon': Icons.help, 'title': 'FAQ', 'page': SettingPage()},
      {'icon': Icons.info, 'title': 'About App', 'page': SettingPage()},
      {'icon': Icons.logout, 'title': 'Logout', 'page': Login()},
    ];

    return items
        .map((item) => ListTile(
              leading: Icon(item['icon'] as IconData),
              title: Text(item['title'] as String),
              onTap: () => _navigateTo(item['page'] as Widget),
            ))
        .toList();
  }

  // Build header section
  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: 190,
        padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(),
            const SizedBox(height: 10),
            _buildSearchRow(),
          ],
        ),
      ),
    );
  }

  // Build header row with profile and menu
  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProfileSection(),
        _buildMenuButton(),
      ],
    );
  }

  // Build profile section
  Widget _buildProfileSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("picture/profile.png"),
          backgroundColor: Colors.white,
        ),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome Back,",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Build menu button
  Widget _buildMenuButton() {
    return Builder(
      builder: (context) => Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          iconSize: 22,
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      ),
    );
  }

  // Build search row - UPDATED WITH FUNCTIONAL SEARCH
  Widget _buildSearchRow() {
    return Row(
      children: [
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
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Search Programs",
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white),
                        onPressed: () {
                          searchController.clear();
                          filterPrograms('');
                        },
                      )
                    : null,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                filterPrograms(value);
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        _buildChatButton(),
      ],
    );
  }

  // Build chat button
  Widget _buildChatButton() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: const Icon(Icons.chat, color: Colors.white),
        iconSize: 22,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chatlist()),
        ),
      ),
    );
  }

  // Build active programs section
  Widget _buildActivePrograms() {
    return Padding(
      padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Active Programs",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "futura",
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: _buildActiveProgramsList(),
          ),
        ],
      ),
    );
  }

  // Build active programs list
  Widget _buildActiveProgramsList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (activePrograms.isEmpty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            "No active programs yet",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: activePrograms.length,
      itemBuilder: (context, index) =>
          _buildActiveProgramCard(activePrograms[index]),
    );
  }

  // Build active program card
  Widget _buildActiveProgramCard(Map<String, dynamic> program) {
    final remaining = program['sessionsTotal'] - program['sessionsCompleted'];

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: Container(
          width: 170,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              _buildProgramImage(program['image']),
              _buildGradientOverlay(),
              _buildProgramInfo(remaining, program['ptName']),
            ],
          ),
        ),
      ),
    );
  }

  // Build saved programs section
  Widget _buildSavedPrograms() {
    return Padding(
      padding: const EdgeInsets.only(top: 350, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Saved Programs",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "futura",
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildSavedProgramsGrid()),
        ],
      ),
    );
  }

  // Build saved programs grid - UPDATED TO USE FILTERED LIST
  Widget _buildSavedProgramsGrid() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredSavedPrograms.isEmpty) {
      return _buildEmptyState(searchController.text.isNotEmpty);
    }

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      itemCount: filteredSavedPrograms.length,
      itemBuilder: (context, index) =>
          _buildSavedProgramCard(filteredSavedPrograms[index]),
    );
  }

  // Build empty state - UPDATED TO SHOW DIFFERENT MESSAGE FOR SEARCH
  Widget _buildEmptyState(bool isSearch) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearch ? Icons.search_off : Icons.bookmark_border,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            isSearch ? "No programs found" : "No saved programs yet",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isSearch
                ? "Try a different search term"
                : "Save programs from home to see them here",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Build saved program card
  Widget _buildSavedProgramCard(Map<String, dynamic> program) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PTProfile(
            docId: program['id'],
            name: program['name'],
            price: program['price'],
            rating: program['rating'],
            image: program['image'],
            location: program['location'],
            exp: program['exp'],
            description: program['description'],
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            _buildProgramImage(program['image']),
            _buildGradientOverlay(),
            _buildRemoveButton(program),
            _buildProgramName(program['name']),
            _buildProgramDetails(program),
          ],
        ),
      ),
    );
  }

  // Build program image
  Widget _buildProgramImage(String imagePath) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.7,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Transform.scale(
                scale: 1.5,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build gradient overlay
  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              secondaryColor.withOpacity(0.75),
              primaryColor.withOpacity(0.0),
            ],
          ),
        ),
      ),
    );
  }

  // Build remove button
  Widget _buildRemoveButton(Map<String, dynamic> program) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: () => _removeSavedProgram(program['id'], program['name']),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  // Build program name
  Widget _buildProgramName(String name) {
    return Align(
      alignment: const Alignment(0.0, 0.5),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: "Futura",
          color: Colors.white,
        ),
      ),
    );
  }

  // Build program details
  Widget _buildProgramDetails(Map<String, dynamic> program) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPriceContainer(program['price']),
            const SizedBox(width: 8),
            _buildRatingContainer(program['rating']),
          ],
        ),
      ),
    );
  }

  // Build price container
  Widget _buildPriceContainer(String price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      constraints: const BoxConstraints(minWidth: 60, maxWidth: 100),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Start From",
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: primaryColor,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "Futura",
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Build rating container
  Widget _buildRatingContainer(dynamic rating) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 16,
          ),
          const SizedBox(width: 2),
          Text(
            rating.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "Futura",
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Build program info for active programs
  Widget _buildProgramInfo(int remaining, String ptName) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              constraints: const BoxConstraints(minWidth: 60, maxWidth: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Remaining",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    remaining.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Futura",
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 7),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                ptName,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Futura",
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavBar() {
    return Stack(
      children: [
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
                  offset: const Offset(0, -4),
                ),
              ],
            ),
          ),
        ),

        // ICON KIRI BAWAH (KALENDAR) - Current page, highlighted
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 55, bottom: 20),
            child: GestureDetector(
              onTap: () {
                // Already on ProgramTaken page, no navigation needed
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: primaryColor, // Highlighted as current page
                  size: 30,
                ),
              ),
            ),
          ),
        ),

        // ICON KANAN BAWAH (PROFILE)
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 55, bottom: 20),
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_2_outlined,
                  color: Colors.black,
                  size: 45,
                ),
              ),
            ),
          ),
        ),

        // ICON TENGAH (HOME)
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 45,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

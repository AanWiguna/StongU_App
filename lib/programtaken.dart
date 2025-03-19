import 'package:flutter/material.dart';
import 'package:strong_u/home.dart';

class ProgramTaken extends StatelessWidget {
  const ProgramTaken({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                "Robert King",
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
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          iconSize: 22,
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
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

                      SizedBox(
                          width: 10), // Jarak antara search bar dan tombol chat

                      // CHAT BUTTON (Di Bawah Menu)
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
                                  builder: (context) => ProgramTaken()),
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
            padding: EdgeInsets.only(top: 370, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Programs Saved",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "futura",
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // SCROLLABLE GRID CONTAINER
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
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
                                  "picture/PT.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Gradasi
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
                                "BOBBY",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Futura",
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // Container keterangan PT
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      constraints: BoxConstraints(
                                          minWidth: 60, maxWidth: 100),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
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
                                            "200K",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Futura",
                                              color: Color(0xFF0392FB),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Surabaya",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Futura",
                                          color: Color(0xFF0392FB),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                  child: Icon(Icons.calendar_today,
                      color: Color(0xFF0392FB), size: 30),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.home, color: Colors.black, size: 45),
                ),
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
                    "Programs Taken",
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
                    children: List.generate(5, (index) {
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
                                        Color(0xFF0267C1)
                                            .withOpacity(0.5), // Biru gelap
                                        Color(0xFF0392FB)
                                            .withOpacity(0.0), // Transparan
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
                                            vertical: 6, horizontal: 12),
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
                                              "Remaining",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                            Text(
                                              "4",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Futura",
                                                color: Color(0xFF0392FB),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 4),

                                      // Container "Surabaya"
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Bobby",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Futura",
                                            color: Color(0xFF0392FB),
                                          ),
                                        ),
                                      ),
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
        ],
      ),
    );
  }
}

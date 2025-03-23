import 'package:flutter/material.dart';
import 'package:strong_u/PaymentPage.dart';
import 'package:strong_u/chatPT.dart';

class PTProfile extends StatefulWidget {
  @override
  _PTProfileState createState() => _PTProfileState();
}

class _PTProfileState extends State<PTProfile> {
  int? selectedPlan; // Variable to keep track of the selected session plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Chat button
          Padding(
            padding: EdgeInsets.only(top: 50, right: 40),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF0392FB), width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.chat, color: Color(0xFF0392FB)),
                  iconSize: 22,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPT()),
                    );
                  },
                ),
              ),
            ),
          ),
          // Back button
          Padding(
            padding: EdgeInsets.only(top: 50, left: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Foto PT dan Informasi
          Padding(
            padding: EdgeInsets.only(top: 110),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  // Foto PT
                  Container(
                    width: 330,
                    height: 200,
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
                            padding: EdgeInsets.only(top: 5),
                            child: Image.asset(
                              "picture/PThalfed.png",
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
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "BOBBY",
                              style: TextStyle(
                                fontSize: 34,
                                fontFamily: "Futura",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lokasi
                      Container(
                        width: 110,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0392FB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 18),
                            SizedBox(width: 5),
                            Text(
                              "Surabaya",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Futura",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      // Pengalaman
                      Container(
                        width: 110,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0392FB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time,
                                color: Colors.white, size: 18),
                            SizedBox(width: 5),
                            Text(
                              "3 years",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Futura",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      // Rating
                      Container(
                        width: 90,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0392FB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 18),
                            SizedBox(width: 5),
                            Text(
                              "4.8/5",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Futura",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Deskripsi PT
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFF0392FB), width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Saya adalah seorang personal trainer profesional dengan spesialisasi dalam weight gain dan body building. Program saya dirancang secara personal untuk memastikan progres yang optimal, mencakup pola latihan yang efektif, nutrisi yang tepat, serta strategi pemulihan yang maksimal.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Package
                      Container(
                        width: 110,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF0392FB),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Session Package",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Specialization
                      Container(
                        width: 110,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFF0392FB)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Specialization",
                            style: TextStyle(
                                color: Color(0xFF0392FB), fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Review
                      Container(
                        width: 110,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFF0392FB)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Review",
                            style: TextStyle(
                                color: Color(0xFF0392FB), fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Session Plan Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Session Plan",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "futura",
                          ),
                        ),
                        SizedBox(height: 5),
                        Column(
                          children: [
                            sessionPlanCard(4, 250000, 1000000, 1),
                            sessionPlanCard(8, 220000, 1760000, 2),
                            sessionPlanCard(12, 200000, 2400000, 3),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0392FB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPage()),
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Futura",
                          ),
                        ),
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
  }

  Widget sessionPlanCard(
      int sessions, int pricePerSession, int subTotal, int planIndex) {
    bool isSelected = selectedPlan == planIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = planIndex;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF0392FB) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xFF0392FB), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$sessions Sessions",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "futura",
                    color: isSelected ? Colors.white : Color(0xFF0392FB),
                  ),
                ),
                Text(
                  "Rp ${pricePerSession.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} /Session",
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.white : Color(0xFF0392FB),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Sub Total",
                  style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Color(0xFF0392FB)),
                ),
                Text(
                  "Rp ${subTotal.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "futura",
                    color: isSelected ? Colors.white : Color(0xFF0392FB),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

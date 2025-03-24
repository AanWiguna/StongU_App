import 'package:flutter/material.dart';
import 'package:strong_u/PaymentPage.dart';
import 'package:strong_u/chatPT.dart';

class PTProfile extends StatefulWidget {
  @override
  _PTProfileState createState() => _PTProfileState();
}

class _PTProfileState extends State<PTProfile> {
  int? selectedPlan; // Variable to keep track of the selected session plan
  bool isSpecializationSelected =
      false; // Variable to track specialization selection
  bool isReviewSelected = false; // Variable to track review selection

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
            child: SingleChildScrollView(
              // Make the content scrollable
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
                        color: Color(0xFF0392FB),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Saya adalah seorang personal trainer profesional dengan spesialisasi dalam weight gain dan body building. Program saya dirancang secara personal untuk memastikan progres yang optimal, mencakup pola latihan yang efektif, nutrisi yang tepat, serta strategi pemulihan yang maksimal.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSpecializationSelected = false;
                              isReviewSelected = false;
                            });
                          },
                          child: Container(
                            width: 110,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  !isSpecializationSelected && !isReviewSelected
                                      ? Color(0xFF0392FB)
                                      : Colors.white,
                              border: Border.all(color: Color(0xFF0392FB)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Session Package",
                                style: TextStyle(
                                  color: !isSpecializationSelected &&
                                          !isReviewSelected
                                      ? Colors.white
                                      : Color(0xFF0392FB),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Specialization
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSpecializationSelected = true;
                              isReviewSelected = false;
                            });
                          },
                          child: Container(
                            width: 110,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSpecializationSelected
                                  ? Color(0xFF0392FB)
                                  : Colors.white,
                              border: Border.all(color: Color(0xFF0392FB)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Specialization",
                                style: TextStyle(
                                  color: isSpecializationSelected
                                      ? Colors.white
                                      : Color(0xFF0392FB),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Review
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isReviewSelected = true;
                              isSpecializationSelected = false;
                            });
                          },
                          child: Container(
                            width: 110,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isReviewSelected
                                  ? Color(0xFF0392FB)
                                  : Colors.white,
                              border: Border.all(color: Color(0xFF0392FB)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Review",
                                style: TextStyle(
                                  color: isReviewSelected
                                      ? Colors.white
                                      : Color(0xFF0392FB),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Session Plan Section
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: 300, // Set a fixed height for the ListView
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isSpecializationSelected
                                ? "Specialization & Certification"
                                : isReviewSelected
                                    ? "User Reviews"
                                    : "Select Session Plan",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "futura",
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: isSpecializationSelected
                                ? SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        specializationCard(
                                          "Weight Gain",
                                          "Program Weight Gain adalah program yang dirancang khusus untuk membantu individu yang ingin menambah berat badan dengan cara yang sehat dan efektif. Program ini tidak hanya berfokus pada peningkatan berat badan semata, tetapi juga pada peningkatan massa otot dan kekuatan tubuh secara keseluruhan.",
                                        ),
                                        SizedBox(height: 10),
                                        specializationCard(
                                          "Body Building",
                                          "Program Body Building adalah program pelatihan yang dirancang untuk membentuk tubuh yang bertenaga, simetris, dan proporsional melalui kombinasi latihan kekuatan, pola makan yang tepat, serta pemulihan yang optimal. Fokus utama program ini adalah meningkatkan massa otot, mengurangi lemak tubuh, serta meningkatkan estetika dan definisi otot.",
                                        ),
                                        SizedBox(
                                            height:
                                                20), // Jarak sebelum sertifikat
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Image.asset(
                                            "picture/Sertifikat.jpeg",
                                            fit: BoxFit
                                                .contain, // Pastikan gambar tidak terpotong
                                            width: double
                                                .infinity, // Sesuaikan lebar dengan layar
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : isReviewSelected
                                    ? reviewsList()
                                    : ListView.builder(
                                        itemCount: 4, // Number of session plans
                                        itemBuilder: (context, index) {
                                          switch (index) {
                                            case 0:
                                              return sessionPlanCard(
                                                  4, 250000, 1000000, 1);
                                            case 1:
                                              return sessionPlanCard(
                                                  8, 220000, 1760000, 2);
                                            case 2:
                                              return sessionPlanCard(
                                                  12, 200000, 2400000, 3);
                                            case 3:
                                              return sessionPlanCard(
                                                  16, 180000, 2880000, 4);
                                            default:
                                              return SizedBox.shrink();
                                          }
                                        },
                                      ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
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

  Widget specializationCard(String title, String description) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontFamily: "futura",
              color: Colors.white,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> reviews = [
  {
    "user": "Aan",
    "comment": "Trainer profesional, ramah, dan keren.",
    "rating": 5,
  },
  {
    "user": "Wisnu",
    "comment": "Sangat membantu dalam bulking.",
    "rating": 4,
  },
  {
    "user": "Nathan",
    "comment": "Profesional dan baik",
    "rating": 5,
  },
  {
    "user": "Dinda",
    "comment": "Dia ganteng",
    "rating": 5,
  },
  {
    "user": "Abi",
    "comment": "Sangat membantu dalam menjaga motivasi",
    "rating": 5,
  },
];

Widget reviewsList() {
  return Container(
    height: 270,
    child: ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          color: Color(0xFF0392FB),
          child: ListTile(
            title: Text(
              reviews[index]["user"]!,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Futura",
              ),
            ),
            subtitle: Text(
              reviews[index]["comment"]!,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  reviews[index]["rating"].toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Row(
                  children: List.generate(
                    reviews[index]["rating"],
                    (starIndex) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:strong_u/PaymentPage.dart';
import 'package:strong_u/chatPT.dart';
import 'package:strong_u/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PTProfile extends StatefulWidget {
  final String docId;
  final String name;
  final String price;
  final double rating;
  final String image;
  final String location;
  final int exp;
  final String description;

  PTProfile({
    required this.docId,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
    required this.location,
    required this.exp,
    required this.description,
  });

  @override
  _PTProfileState createState() => _PTProfileState();
}

class _PTProfileState extends State<PTProfile> {
  int? selectedPlan;
  bool isSpecializationSelected = false;
  bool isReviewSelected = false;
  List<int> packages = [];
  List<int> prices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    try {
      // Fetch the document for the current PT using their name or ID
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('PT')
          .doc(widget.docId)
          .get();

      // Initialize lists to hold packages and prices
      List<int> allPackages = [];
      List<int> allPrices = [];

      // Check if the document exists
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        // Check if Paket and HargaPaket are present and not null
        if (data['Paket'] is List) {
          allPackages.addAll(List<int>.from(data['Paket']));
        }
        if (data['HargaPaket'] is List) {
          allPrices.addAll(List<int>.from(data['HargaPaket']));
        }

        // Update the state with the collected packages and prices
        setState(() {
          packages = allPackages;
          prices = allPrices;
          isLoading = false;
        });
      } else {
        // Fallback data if no document found
        setState(() {
          packages = [4, 8, 12, 16];
          prices = [250000, 220000, 200000, 180000];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching packages: $e');
      // Fallback data if an error occurs
      setState(() {
        packages = [4, 8, 12, 16];
        prices = [250000, 220000, 200000, 180000];
        isLoading = false;
      });
    }
  }

  int getTotalPrice(int index) {
    if (index < packages.length && index < prices.length) {
      return packages[index] * prices[index];
    }
    return 0;
  }

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
                    // Replace the existing onPressed with this:
                    final chatService = ChatService();
                    chatService.createNewChat(
                        widget.docId, widget.name, widget.image);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPT(
                          ptId: widget.docId,
                          ptName: widget.name,
                          ptImage: widget.image,
                        ),
                      ),
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
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: 0.5,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Transform.scale(
                                    scale: 1.7,
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      widget.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
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
                                widget.name.toUpperCase(),
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
                              Flexible(
                                child: Text(
                                  widget.location,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Futura",
                                  ),
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
                                "${widget.exp} years",
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
                                "${widget.rating.toStringAsFixed(1)}/5",
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
                        widget.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: 300,
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
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Image.asset(
                                            "picture/Sertifikat.jpeg",
                                            fit: BoxFit.contain,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : isReviewSelected
                                    ? reviewsList()
                                    : isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xFF0392FB),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount: packages.length,
                                            itemBuilder: (context, index) {
                                              return sessionPlanCard(
                                                packages[index],
                                                prices[index],
                                                getTotalPrice(index),
                                                index + 1,
                                              );
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
                          onPressed: selectedPlan != null && !isLoading
                              ? () {
                                  int selectedIndex = selectedPlan! - 1;
                                  if (selectedIndex < packages.length &&
                                      selectedIndex < prices.length) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPage(
                                          ptName: widget.name,
                                          ptImage: widget.image,
                                          selectedPlan: selectedPlan!,
                                          planPrice:
                                              getTotalPrice(selectedIndex),
                                          ptId: widget.docId,
                                          sessions: packages[
                                              selectedIndex], // Tambahkan ini
                                          pricePerSession: prices[
                                              selectedIndex], // Tambahkan ini
                                        ),
                                      ),
                                    );
                                  }
                                }
                              : null,
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentPage extends StatefulWidget {
  final String ptName;
  final String ptImage;
  final int selectedPlan;
  final int planPrice;
  final String ptId;
  final int sessions; // Add sessions parameter
  final int pricePerSession; // Add price per session parameter

  PaymentPage({
    required this.ptName,
    required this.ptImage,
    required this.selectedPlan,
    required this.planPrice,
    required this.ptId,
    required this.sessions, // Add this
    required this.pricePerSession, // Add this
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedPaymentMethod = 0;
  bool isProcessing = false;
  bool showQRPayment = false;
  String selectedPaymentName = '';

  final List<Map<String, String>> paymentMethods = [
    {"image": "picture/QRIS.png", "name": "QRIS"},
    {"image": "picture/BCA.jpg", "name": "BCA Mobile"},
    {"image": "picture/BNI.png", "name": "BNI Mobile"},
    {"image": "picture/BRI.png", "name": "BRImo"},
    {"image": "picture/DANA.png", "name": "DANA"},
    {"image": "picture/OVO.png", "name": "OVO"},
    {"image": "picture/ShopeePay.png", "name": "ShopeePay"},
    {"image": "picture/linkaja.png", "name": "LinkAja"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showQRPayment ? _buildQRPaymentScreen() : _buildPaymentScreen(),
    );
  }

  Widget _buildPaymentScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Payment",
            style: TextStyle(fontSize: 28, fontFamily: "futura"),
          ),
          SizedBox(height: 20),
          _buildPaymentMethods(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Detail",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Futura",
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildTrainerCard(),
          SizedBox(height: 20),
          _buildSessionPlanCard(),
          SizedBox(height: 20),
          _buildConfirmButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildQRPaymentScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 50, left: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    showQRPayment = false;
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Scan QR Code",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Futura",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Pay with $selectedPaymentName",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_2,
                          size: 150,
                          color: Colors.black,
                        ),
                        Text(
                          "QR Code",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Color(0xFF0392FB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Rp ${widget.planPrice.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: "Futura",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: isProcessing ? null : _completePayment,
                    child: isProcessing
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Payment Completed",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "futura",
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Please complete the payment within 15 minutes",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Method", style: TextStyle(fontSize: 20, fontFamily: "futura")),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(paymentMethods.length, (index) {
              final isSelected = selectedPaymentMethod == index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = index + 1;
                    selectedPaymentName = paymentMethods[index]["name"]!;
                  });
                },
                child: Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child:
                        Image.asset(paymentMethods[index]["image"]!, width: 50),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainerCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xFF0392FB),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
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
                        widget.ptImage,
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
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  widget.ptName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: "Futura",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionPlanCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 45),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF0392FB),
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
                "${widget.sessions} Sessions",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Futura",
                  color: Colors.white,
                ),
              ),
              Text(
                "Rp ${widget.pricePerSession.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} /Session",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Sub Total",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
              Text(
                "Rp ${widget.planPrice.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Futura",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0392FB),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: Size(double.infinity, 50),
        ),
        onPressed: (selectedPaymentMethod == 0)
            ? null
            : () {
                setState(() {
                  showQRPayment = true;
                });
              },
        child: Text("Confirm Payment",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: "futura")),
      ),
    );
  }

  // Function to complete payment and create active program
  Future<void> _completePayment() async {
    setState(() {
      isProcessing = true;
    });

    try {
      // Create active program
      await _createActiveProgram();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment successful! Program activated.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate back to home
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  // Function to create active program after successful payment
  Future<void> _createActiveProgram() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('activePrograms')
            .add({
          'ptId': widget.ptId,
          'ptName': widget.ptName,
          'startDate': FieldValue.serverTimestamp(),
          'endDate': null,
          'sessionsTotal': widget.sessions,
          'sessionsCompleted': 0,
          'status': 'active',
          'schedule': 'To be scheduled',
          'image': widget.ptImage,
          'planPrice': widget.planPrice,
          'selectedPlan': widget.selectedPlan,
          'pricePerSession': widget.pricePerSession,
          'paymentMethod': selectedPaymentName,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Optionally remove from saved programs if it exists
        await _removeFromSavedPrograms();
      }
    } catch (e) {
      debugPrint("Error creating active program: $e");
      throw e;
    }
  }

  // Function to remove from saved programs after payment
  Future<void> _removeFromSavedPrograms() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('savedPTs')
            .where('id', isEqualTo: widget.ptId)
            .get();

        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      }
    } catch (e) {
      debugPrint("Error removing from saved programs: $e");
    }
  }
}

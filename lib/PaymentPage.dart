import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedPlan = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            sessionPlanCard(8, 220000, 1760000, 1),
            SizedBox(height: 20),
            _buildConfirmButton(),
          ],
        ),
      ),
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
            children: [
              _buildPaymentMethod("picture/QRIS.png"),
              _buildPaymentMethod("picture/BCA.jpg"),
              _buildPaymentMethod("picture/BNI.png"),
              _buildPaymentMethod("picture/BRI.png"),
              _buildPaymentMethod("picture/DANA.png"),
              _buildPaymentMethod("picture/OVO.png"),
              _buildPaymentMethod("picture/ShopeePay.png"),
              _buildPaymentMethod("picture/linkaja.png"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String imagePath) {
    return Container(
      width: 70,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Image.asset(imagePath, width: 50),
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
        margin: EdgeInsets.symmetric(horizontal: 45),
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
                    fontFamily: "Futura",
                    color: isSelected ? Colors.white : Color(0xFF0392FB),
                  ),
                ),
                Text(
                  "Rp ${pricePerSession ~/ 1000}.000 /Session",
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
                Text("Sub Total",
                    style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : Color(0xFF0392FB))),
                Text(
                  "Rp ${subTotal ~/ 1000}.000",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Futura",
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
        onPressed: () {},
        child: Text("Confirm",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: "futura")),
      ),
    );
  }
}

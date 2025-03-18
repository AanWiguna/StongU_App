import 'package:flutter/material.dart';
import 'package:strong_u/page_indicator.dart';
import 'package:strong_u/sessionStart.dart';

//stateful widget supaya bisa berubah
class Birthday extends StatefulWidget {
  const Birthday({super.key});

  @override
  _BirthdayState createState() => _BirthdayState();
}

//state class hari, bulan, tahun (null)
class _BirthdayState extends State<Birthday> {
  //variabel
  String? selectedDate;
  String? selectedMonth;
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0392FB), Color(0xFF025795)],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.72,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
            ),
          ),
          // Tombol Back (pojok kiri atas)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Judul
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 475, left: 10, right: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text.rich(
                  TextSpan(
                    text: "Choose Your ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura",
                    ),
                    children: [
                      TextSpan(
                        text: "Birthday",
                        style: TextStyle(
                          color: Color(0xFF0392FB),
                        ),
                      ),
                      TextSpan(text: "!"),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Tombol Tanggal, Bulan, Tahun
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 530, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton("Date", selectedDate, () {
                    _showSelectionModal(context, "Select Date",
                        List.generate(31, (i) => "${i + 1}"), (val) {
                      setState(() {
                        selectedDate = val;
                      });
                    });
                  }),
                  _buildOptionButton("Month", selectedMonth, () {
                    _showSelectionModal(context, "Select Month", [
                      "January",
                      "February",
                      "March",
                      "April",
                      "May",
                      "June",
                      "July",
                      "August",
                      "September",
                      "October",
                      "November",
                      "December"
                    ], (val) {
                      setState(() {
                        selectedMonth = val;
                      });
                    });
                  }),
                  _buildOptionButton("Year", selectedYear, () {
                    _showSelectionModal(context, "Select Year",
                        List.generate(126, (i) => "${2025 - i}"), (val) {
                      setState(() {
                        selectedYear = val;
                      });
                    });
                  }),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Image.asset(
                "picture/Birthday.png",
                width: 350,
                height: 350,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: PageIndicator(currentIndex: 2, totalPages: 7),
            ),
          ),
          // Tombol Next
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate != null &&
                      selectedMonth != null &&
                      selectedYear != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SesssionStart()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter your birthday!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Next!",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: "Futura",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//atur widget input hari, bulan, tahun
  Widget _buildOptionButton(
      String label, String? selectedValue, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF50BDF5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        selectedValue ?? label,
        style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontFamily: "futura"),
      ),
    );
  }

//menampilkan opsi
  void _showSelectionModal(BuildContext context, String title,
      List<String> options, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(options[index], textAlign: TextAlign.center),
                      onTap: () {
                        onSelect(options[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

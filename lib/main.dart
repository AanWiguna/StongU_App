import 'package:flutter/material.dart';

void main() {
  runApp(StrongU());
}

class StrongU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OpeningPage(),
    );
  }
}

//opening page
class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/opening.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_opening.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Meet with ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Professional",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: " Personal Trainer",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //sub judul
          //posisi
          Positioned(
            left: 35,
            top: 565,
            //biar ga lewat hp
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: Text(
                "Find the Perfect Personal Trainer to Transform Your Fitness Journey Today!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontFamily: "montserrat"),
                //rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Zipcode()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Start!          ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Zipcode extends StatelessWidget {
  //menambah fitur input teks
  final TextEditingController _zipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Zipcode.png"),
          ),
          //titik-titik
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_zipcode.png"),
            ),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Enter Your ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "Zipcode",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Tombol Back
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
            ),
          ),
          // Input ZIP Code
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 250),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFF50BDF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _zipcodeController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white, fontFamily: "futura"),
                decoration: InputDecoration(
                  hintText: "Enter ZIP code",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 700),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  String zipCode = _zipcodeController.text.trim();
                  if (zipCode.isEmpty) {
                    // Jika input kosong, tampilkan SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter a ZIP code!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Jika sudah terisi, navigasi ke halaman berikutnya
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Birthday()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Next!          ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//stateful widget supaya bisa berubah
class Birthday extends StatefulWidget {
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
          // Gambar background
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/birthday.png"),
          ),
          // Tombol Back (pojok kiri atas)
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Titik-titik
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 600),
              child: Image.asset("picture/titik_birthday.png"),
            ),
          ),
          // Judul
          Positioned(
            left: 10,
            top: 475,
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
          // Tombol Tanggal, Bulan, Tahun
          Positioned(
            top: 530,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //opsi
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
          // Tombol Next
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 700),
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
                      SnackBar(
                        content: Text("Please select your birthday!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Next!          ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "Futura"),
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
        return Container(
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

class SesssionStart extends StatefulWidget {
  @override
  _SesssionStartState createState() => _SesssionStartState();
}

class _SesssionStartState extends State<SesssionStart> {
  // Menyimpan status pemilihan tombol
  Map<String, bool> selectedSessions = {
    "Morning": false,
    "Noon": false,
    "Night": false,
  };

  bool isNextEnabled = false; // Tambahkan state untuk tombol Next

  void _updateNextButtonState() {
    setState(() {
      isNextEnabled = selectedSessions.values.any((value) => value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar background
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/SessionStart.png"),
          ),
          // Tombol Back
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Titik-titik
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 690),
              child: Image.asset("picture/titik_SessionStart.png"),
            ),
          ),
          // Judul
          Positioned(
            left: 10,
            top: 475,
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
                      text: "Session",
                      style: TextStyle(color: Color(0xFF0392FB)),
                    ),
                    TextSpan(text: "!"),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Tombol sesi (multi-select)
          Align(
            alignment: Alignment(0.0, 0.45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSessionButton("Morning", "06.00 - 12.00"),
                _buildSessionButton("Noon", "12.00 - 18.00"),
                _buildSessionButton("Night", "18.00 - 22.00"),
              ],
            ),
          ),
          // Tombol Next
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  if (isNextEnabled) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SesssionDay()),
                    );
                  } else {
                    // Tampilkan notifikasi kalau tidak ada yang dipilih
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please select at least one session!",
                          style: TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                //setting belum pilih
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isNextEnabled ? Color(0xFF0392FB) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Next!          ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: "Futura",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function untuk membangun tombol sesi
  Widget _buildSessionButton(String session, String time) {
    bool isSelected = selectedSessions[session] ?? false;

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedSessions[session] = !isSelected;
          });
          _updateNextButtonState(); // Update status tombol Next
        },
        // Ubah warna tombol sesuai statusnya
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Color(0xFF0392FB) : Colors.white,
          side: BorderSide(color: Color(0xFF0392FB), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Ubah warna teks sesuai statusnya
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              session,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.white : Color(0xFF0392FB),
                fontFamily: "futura",
              ),
            ),
            SizedBox(),
            Text(
              time,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Color(0xFF0392FB),
                fontFamily: "montserrat",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SesssionDay extends StatefulWidget {
  @override
  _SesssionDayState createState() => _SesssionDayState();
}

class _SesssionDayState extends State<SesssionDay> {
  // Menyimpan status pemilihan tombol
  Map<String, bool> selectedDays = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  bool isNextEnabled = false; // Tambahkan state untuk tombol Next

  void _updateNextButtonState() {
    setState(() {
      isNextEnabled = selectedDays.values.any((value) => value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar background
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/SessionDay.png"),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 690),
              child: Image.asset("picture/titik_SessionDay.png"),
            ),
          ),
          Positioned(
            left: 10,
            top: 475,
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
                      text: "Session Day",
                      style: TextStyle(color: Color(0xFF0392FB)),
                    ),
                    TextSpan(text: "!"),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.62),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayButton("Monday"),
                    SizedBox(width: 10),
                    _buildDayButton("Tuesday"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayButton("Wednesday"),
                    SizedBox(width: 10),
                    _buildDayButton("Thursday"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayButton("Friday"),
                    SizedBox(width: 10),
                    _buildDayButton("Saturday"),
                  ],
                ),
                _buildDayButton("Sunday"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  if (isNextEnabled) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Goal()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please select at least one day!",
                          style: TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isNextEnabled ? Color(0xFF0392FB) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Next!          ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: "Futura",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton(String day) {
    bool isSelected = selectedDays[day] ?? false;

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 160,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDays[day] = !isSelected;
          });
          _updateNextButtonState();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Color(0xFF0392FB) : Colors.white,
          side: BorderSide(color: Color(0xFF0392FB), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          day,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.white : Color(0xFF0392FB),
            fontFamily: "futura",
          ),
        ),
      ),
    );
  }
}

class Goal extends StatefulWidget {
  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  Map<String, bool> selectedGoals = {
    "Weight Loss": false,
    "Weight Gain": false,
    "Firming & Toning": false,
    "Flexibility": false,
    "Increase Muscle Strength": false,
    "Aerobic Fitness": false,
    "Endurance Training": false,
    "Body Building": false,
  };

  bool get isBeginEnabled => selectedGoals.containsValue(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(left: 0, top: 0, child: Image.asset("picture/Goal.png")),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 690),
              child: Image.asset("picture/titik_Goal.png"),
            ),
          ),
          Positioned(
            left: 10,
            top: 475,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: Text.rich(
                TextSpan(
                  text: "Set Your ",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Futura"),
                  children: [
                    TextSpan(
                        text: "Goals",
                        style: TextStyle(color: Color(0xFF0392FB))),
                    TextSpan(text: "!"),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: 520,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10, // Jarak antar tombol dalam satu baris
                runSpacing: 10, // Jarak antar baris tombol
                children: selectedGoals.keys.map((goal) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) -
                        25, // Lebar tiap tombol
                    child: ElevatedButton(
                      onPressed: () {
                        setState(
                            () => selectedGoals[goal] = !selectedGoals[goal]!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedGoals[goal]! ? Colors.blue : Colors.white,
                        side: BorderSide(color: Colors.blue, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(goal,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              color: selectedGoals[goal]!
                                  ? Colors.white
                                  : Colors.blue)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 770),
              child: ElevatedButton(
                onPressed: isBeginEnabled
                    ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Welcome()))
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isBeginEnabled ? Color(0xFF0392FB) : Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Text("          Begin!          ",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: "Futura")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Welcome.png"),
          ),
          //judul
          //posisi judul
          Positioned(
            left: 10,
            top: 475,
            //border biar ga lewat tulisannya
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              //tulisan multi warna
              child: Text.rich(
                TextSpan(
                  text: "Welcome to ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Futura",
                  ),
                  //tulisan berubah warna
                  children: [
                    TextSpan(
                      text: "StrongU",
                      style: TextStyle(
                        color: Color(0xFF0392FB),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                    ),
                  ],
                ),
                //tulisan rata tengah
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 360),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "            Login            ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 500),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Color(0xFF0392FB),
                        width: 3,
                      )),
                ),
                child: Text(
                  "          Sign Up          ",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF0392FB),
                      fontFamily: "futura"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/Login.png"),
          ),
          //judul
          Positioned(
            left: 45,
            top: 485,
            child: Text(
              "Login",
              style: TextStyle(fontFamily: "futura", fontSize: 36),
            ),
          ),
          //subjudul
          Positioned(
            left: 45,
            top: 530,
            child: Text(
              "Please sign in to continue",
              style: TextStyle(fontFamily: "montserrat", fontSize: 18),
            ),
          ),
          Positioned(
            left: 90,
            top: 810,
            child: Text(
              "Don't have an account?",
              style: TextStyle(fontFamily: "montserrat", fontSize: 12),
            ),
          ),
          Positioned(
            left: 248,
            top: 810,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text(
                "Sign up",
                style: TextStyle(
                  fontFamily: "futura",
                  fontSize: 13,
                  color: Color(0xFF0392FB),
                ),
              ),
            ),
          ),
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 640),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "            Login            ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //gambar background
          //posisi gambar
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset("picture/SignUp.png"),
          ),
          //judul
          Positioned(
            left: 45,
            top: 265,
            child: Text(
              "Sign Up",
              style: TextStyle(fontFamily: "futura", fontSize: 36),
            ),
          ),
          //subjudul
          Positioned(
            left: 45,
            top: 310,
            child: Text(
              "Please create account to continue",
              style: TextStyle(fontFamily: "montserrat", fontSize: 18),
            ),
          ),
          Positioned(
            left: 85,
            top: 735,
            child: Text(
              "Already have an account?",
              style: TextStyle(fontFamily: "montserrat", fontSize: 12),
            ),
          ),
          Positioned(
            left: 255,
            top: 735,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(
                  fontFamily: "futura",
                  fontSize: 13,
                  color: Color(0xFF0392FB),
                ),
              ),
            ),
          ),
          //tombol next
          Align(
            alignment: Alignment.center,
            //posisi Y
            child: Container(
              margin: EdgeInsets.only(top: 490),
              //arah transisi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0392FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "          Sign Up          ",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: "futura"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 100, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text(
              "PERANG BARU DIMULAI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpeningPage()),
                );
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

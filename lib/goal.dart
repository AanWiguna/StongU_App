import 'package:flutter/material.dart';
import 'package:strong_u/login.dart';

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
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 690),
              child: Image.asset("picture/titik_Goal.png"),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 475),
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 520, left: 20, right: 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: selectedGoals.keys.map((goal) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 25,
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
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: isBeginEnabled
                    ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()))
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

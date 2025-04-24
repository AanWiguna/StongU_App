import 'package:flutter/material.dart';
import 'package:strong_u/home.dart';
import 'package:strong_u/signUp.dart';

class Login extends StatelessWidget {
  final TextEditingController _UsernameController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0392FB), Color(0xFF025795)],
              ),
            ),
          ),

          // Logo
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Image.asset(
                "picture/Logo.png",
                width: 350,
                height: 350,
              ),
            ),
          ),

          // Form Login
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "futura",
                        ),
                      ),
                      const Text(
                        "Please sign in to continue",
                        style: TextStyle(
                            fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(height: 20),

                      // Input Username
                      TextFormField(
                        controller: _UsernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person,
                              color: Color(0xFF0392FB)),
                          hintText: "Username",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: Color(0xFF0392FB), width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: Color(0xFF025795), width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Input Password
                      TextFormField(
                        controller: _PasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.lock, color: Color(0xFF0392FB)),
                          hintText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: Color(0xFF0392FB), width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: Color(0xFF025795), width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),

                      // Tombol Login
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: const Color(0xFF0392FB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontFamily: "futura"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?",
                              style: TextStyle(fontSize: 14)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0392FB)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

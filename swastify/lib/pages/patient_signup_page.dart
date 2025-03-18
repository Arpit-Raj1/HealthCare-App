import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<PatientSignupPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth > 600 ? 100 : 20;
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign up as a Patient",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Create an account to get started",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Name Field
                    Text(
                      "Name",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Email Field
                    Text(
                      "Email Address",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "abc@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Password Field
                    Text(
                      "Password",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Create a password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Confirm Password Field
                    Text(
                      "Confirm password",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Re-enter password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Terms and Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(color: Colors.black),
                              children: [
                                const TextSpan(
                                  text: "I've read and agree with the ",
                                ),
                                TextSpan(
                                  text: "Terms and Conditions",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF006FFd),
                                  ),
                                ),
                                const TextSpan(text: " and the "),
                                TextSpan(
                                  text: "Privacy Policy.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF006FFd),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF006FFd),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // OR Divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey[300]),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("OR"),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey[300]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Google Sign Up Button
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 40,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFF2F2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          icon: Image.asset(
                            'assets/images/google_logo.png',
                            height: 24,
                          ),
                          onPressed: () {},
                          label: const Text(
                            "Sign up with Google",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

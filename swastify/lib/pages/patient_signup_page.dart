import 'package:flutter/material.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/styles/app_text.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<PatientSignupPage> {
  final bool _isPasswordVisible = false;
  final bool _isConfirmPasswordVisible = false;
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
                    Text("Sign up as a Patient", style: AppText.header1),
                    const SizedBox(height: 5),
                    Text(
                      "Create an account to get started",
                      style: AppText.subtitle2,
                    ),
                    const SizedBox(height: 20),
                    // Name Field
                    AppTextField(hint: 'Name'),

                    const SizedBox(height: 15),

                    AppTextField(hint: 'Email Address'),
                    const SizedBox(height: 15),
                    // Password Field
                    AppPasswordField(hint: 'Create a password'),
                    const SizedBox(height: 15),
                    // Confirm Password Field
                    AppPasswordField(hint: 'Re-enter password'),

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
                              style: AppText.normalText,
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
                        child: const Text("Sign Up", style: AppText.buttonText),
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

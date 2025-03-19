import 'package:flutter/material.dart';
import 'package:swastify/components/action_with_button.dart';
import 'package:swastify/components/app_button.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';

class AppSignup extends StatefulWidget {
  final String role;
  const AppSignup({super.key, required this.role});

  @override
  State<AppSignup> createState() => _AppSignupState();
}

class _AppSignupState extends State<AppSignup> {
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
                      "Sign up as a ${widget.role}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Create an account to get started",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
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
                    if (widget.role == "Doctor") ...[
                      const SizedBox(height: 15),
                      AppTextField(hint: 'NMC/SMC Registration Number'),
                    ],
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
                              style: TextStyle(color: Colors.black),
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
                    AppButton(onPressed: () {}, hintText: "Sign Up"),
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
                    ActionWithButton(
                      fileLoc: "assets/images/google_logo.png",
                      provider: "Google",
                      onPressed: () {},
                      action: "Sign Up",
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

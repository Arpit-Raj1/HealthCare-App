import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:swastify/components/action_with_button.dart';
import 'package:swastify/components/app_button.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/components/app_email_field.dart';
import 'package:swastify/styles/app_text.dart';

class AppSignup extends StatefulWidget {
  final String role;
  const AppSignup({super.key, required this.role});

  @override
  State<AppSignup> createState() => _AppSignupState();
}

class _AppSignupState extends State<AppSignup> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  void _validateForm() {
    if (_emailFormKey.currentState?.validate() ?? false) {
      // Email is valid, proceed with signup
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Email is valid! Proceeding...")));
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email! Please correct it.")),
      );
    }
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "Sign up as a ${widget.role}",
                        style: AppText.header1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Create an account to get started",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      AppTextField(hint: 'Name'),
                      const SizedBox(height: 15),
                      EmailInputField(
                        labelText: "Email Address",
                        controller: _emailController,
                        formKey: _emailFormKey,
                      ),
                      const SizedBox(height: 15),
                      AppPasswordField(hint: 'Create a password'),
                      const SizedBox(height: 15),
                      AppPasswordField(hint: 'Re-enter password'),
                      if (widget.role == "Doctor") ...[
                        const SizedBox(height: 15),
                        AppTextField(hint: 'NMC/SMC Registration Number'),
                      ],
                      const SizedBox(height: 15),
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
                      AppButton(onPressed: _validateForm, hintText: "Sign Up"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

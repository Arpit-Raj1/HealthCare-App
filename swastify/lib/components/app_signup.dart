import 'package:flutter/material.dart';
import 'package:swastify/components/app_button.dart';
import 'package:swastify/components/app_email_field.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/styles/app_text.dart';

class AppSignup extends StatefulWidget {
  final String role;
  const AppSignup({super.key, required this.role});

  @override
  State<AppSignup> createState() => _AppSignupState();
}

class _AppSignupState extends State<AppSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nmcController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Single Form Key

  bool _isChecked = false;

  void _validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form is valid! Proceeding...")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid input! Please correct the errors."),
        ),
      );
    }
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  String? nmcValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter your NMC/SMC number";
    }
    return null;
  }

  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey, // Wrap all fields in a single Form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text("Sign up as a ${widget.role}", style: AppText.header1),
                const SizedBox(height: 5),
                const Text(
                  "Create an account to get started",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  hint: 'Name',
                  controller: _nameController,
                  validator: nameValidator,
                ),
                const SizedBox(height: 15),
                EmailInputField(
                  labelText: "Email Address",
                  controller: _emailController,
                ),
                const SizedBox(height: 15),
                AppPasswordField(
                  hint: 'Create a password',
                  controller: _passwordController,
                ),
                const SizedBox(height: 15),
                AppPasswordField(
                  hint: 'Re-enter password',
                  controller: _confirmPasswordController,
                ),
                if (widget.role == "Doctor") ...[
                  const SizedBox(height: 15),
                  AppTextField(
                    hint: 'NMC/SMC Registration Number',
                    controller: _nmcController,
                    validator: nmcValidator,
                  ),
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
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "I've read and agree with the "),
                            TextSpan(
                              text: "Terms and Conditions",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006FFd),
                              ),
                            ),
                            TextSpan(text: " and the "),
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
    );
  }
}

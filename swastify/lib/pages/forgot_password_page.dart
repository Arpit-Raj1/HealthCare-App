import 'package:flutter/material.dart';
import 'package:swastify/components/app_email_field.dart';
import 'package:swastify/pages/confirmation_page.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text("Forgot Password", style: AppText.header1),
                  SizedBox(height: 8),
                  Text(
                    "Enter email ID to reset your password",
                    style: TextStyle(fontSize: 14, color: AppColors.greyText),
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: _emailFormKey,
                    child: Column(
                      children: [
                        EmailInputField(
                          labelText: "Email Address",
                          controller: _emailController,
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_emailFormKey.currentState?.validate() ??
                                  false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Email is valid! Proceeding...",
                                    ),
                                  ),
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ConfirmationPage(
                                          email: _emailController.text,
                                        ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Invalid email! Please correct it.",
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text("Submit", style: AppText.buttonText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ForgotPasswordPage()),
  );
}

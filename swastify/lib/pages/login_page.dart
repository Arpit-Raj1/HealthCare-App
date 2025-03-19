import 'package:flutter/material.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/pages/forgot_password_page.dart';
import 'package:swastify/pages/signup_options.dart';
import 'package:swastify/styles/app_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > 600 ? 100 : 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // Illustration Image
                  SizedBox(
                    height: constraints.maxWidth > 600 ? 350 : 250,
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Welcome Text
                  Text("Welcome!", style: AppText.header1),
                  const SizedBox(height: 20),

                  AppTextField(hint: 'Email'),

                  const SizedBox(height: 15),
                  // Password Field
                  AppPasswordField(hint: 'Password'),
                  const SizedBox(height: 5),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text("Forgot password?"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006FFD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Login", style: AppText.buttonText),
                    ),
                  ),
                  const SizedBox(height: 7),
                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupOptions(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text("Or continue with"),
                  const SizedBox(height: 5),
                  // Google Login Button
                  IconButton(
                    icon: Image.asset(
                      'assets/images/google_logo.png',
                      height: 40,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

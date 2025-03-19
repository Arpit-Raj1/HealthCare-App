import 'package:flutter/material.dart';
import 'package:swastify/components/app_signup.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return AppSignup(role: "Patient");
  }
}

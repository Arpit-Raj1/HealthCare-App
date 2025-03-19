import 'package:flutter/material.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_signup.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/styles/app_text.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<PatientSignupPage> {
  @override
  Widget build(BuildContext context) {
    return AppSignup(role: "Patient");
  }
}

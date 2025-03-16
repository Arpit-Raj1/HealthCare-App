import 'package:flutter/material.dart';
import 'package:health_care_app/components/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false, // Removes debug banner
      title: 'Health Care App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  LoginPage(),
    );
  }
}

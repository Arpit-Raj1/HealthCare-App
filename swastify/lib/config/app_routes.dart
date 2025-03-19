import 'package:flutter/material.dart';
import 'package:swastify/components/app_signup.dart';
import 'package:swastify/pages/login_page.dart';
import 'package:swastify/pages/patient_signup_page.dart';

class AppRoutes {
  static const login = '/';
  static const signup = '/signup';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case signup:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => AppSignup(role: args['role']));

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:swastify/components/app_signup.dart';
import 'package:swastify/pages/chat_page.dart';
import 'package:swastify/pages/login_page.dart';
import 'package:swastify/pages/medicine_alerts.dart';
import 'package:swastify/pages/profile.dart';

class AppRoutes {
  static const login = '/';
  static const signup = '/signup';
  static const chatPage = '/chatPage';
  static const medicineAlerts = '/medicineAlerts';
  static const emergencyContacts = '/emergencyContacts';
  static const profile = '/profile';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case chatPage:
        return MaterialPageRoute(builder: (_) => MessagesScreen());
        
      case medicineAlerts:
        return MaterialPageRoute(builder: (_) => MedicineAlertsScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => SettingsScreen());

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

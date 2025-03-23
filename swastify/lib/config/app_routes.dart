import 'package:flutter/material.dart';
import 'package:swastify/components/app_signup.dart';
import 'package:swastify/pages/chat_page.dart';
import 'package:swastify/pages/emergency_contacts_page.dart';
import 'package:swastify/pages/login_page.dart';
import 'package:swastify/pages/medicine_alerts.dart';
import 'package:swastify/pages/messaging_page.dart';
import 'package:swastify/pages/profile.dart';
import 'package:swastify/pages/reports.dart';

class AppRoutes {
  static const login = '/';
  static const signup = '/signup';
  static const emergency = '/emergency';
  static const chatPage = '/chatPage';
  static const medicineAlerts = '/medicineAlerts';
  static const profile = '/profile';
  static const reports = '/reports';
  static const messagingPage = '/messagingPage';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case chatPage:
        return MaterialPageRoute(builder: (_) => MessagesScreen());

      case medicineAlerts:
        return MaterialPageRoute(builder: (_) => MedicineAlertsScreen());

      case reports:
        return MaterialPageRoute(builder: (_) => MedicalReportsScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case messagingPage:
        return MaterialPageRoute(builder: (_) => ChatScreen());

      case signup:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => AppSignup(role: args['role']));

      case emergency:
        return MaterialPageRoute(builder: (_) => EmergencyContactsScreen());

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

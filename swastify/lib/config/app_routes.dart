import 'package:swastify/pages/login_page.dart';
import 'package:swastify/pages/patient_signup_page.dart';

class AppRoutes {
  static final pages = {
    login: (context) => LoginPage(),
    patientSignUp: (context) => PatientSignupPage(),
  };
  static const login = '/';
  static const patientSignUp = '/patient_sign_up';
}

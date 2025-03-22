import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsService {
  /// Fetches the user's name from local storage
  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? "User";
  }

  /// Fetches the user's phone number from local storage
  static Future<String> getUserNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userNumber') ?? "Not Available";
  }

  /// Saves user details to local storage
  static Future<void> saveUserDetails(String name, String number) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userNumber', number);
  }

  /// Clears user details from local storage
  static Future<void> clearUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userNumber');
  }
}

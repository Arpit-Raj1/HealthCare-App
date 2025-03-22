import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContactsService {
  static const String _emergencyContactsKey = 'emergency_contacts';
  static Future<void> saveEmergencyContacts(
    List<Map<String, String>> contacts,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String serializedContacts = jsonEncode(contacts);
      await prefs.setString(_emergencyContactsKey, serializedContacts);
    } catch (error) {
      print('Error saving emergency contacts: $error');
      rethrow;
    }
  }

  static Future<List<Map<String, String>>> loadEmergencyContacts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? serializedContacts = prefs.getString(_emergencyContactsKey);

      if (serializedContacts == null || serializedContacts.isEmpty) {
        return [];
      }
      final List<dynamic> decodedContacts = jsonDecode(serializedContacts);
      // if (decodedContacts is! List) {
      //   throw FormatException('Invalid format: Expected a list');
      // }
      return decodedContacts.map((contact) {
        if (contact is! Map<String, dynamic>) {
          throw FormatException('Invalid format: Expected a map');
        }
        return Map<String, String>.from(contact);
      }).toList();
    } catch (error) {
      print('Error loading emergency contacts: $error');
      return [];
    }
  }
}

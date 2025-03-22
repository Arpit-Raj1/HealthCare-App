import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MedicineAlertsService {
  static const String _medicinesKey = 'medicine_alerts';

  /// Save medicine alerts to local storage
  static Future<void> saveMedicines(
    List<Map<String, dynamic>> medicines,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final serializedMedicines = jsonEncode(medicines);
      await prefs.setString(_medicinesKey, serializedMedicines);
    } catch (error) {
      print('Error saving medicine alerts: $error');
      rethrow;
    }
  }

  /// Load medicine alerts from local storage
  static Future<List<Map<String, dynamic>>> loadMedicines() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final serializedMedicines = prefs.getString(_medicinesKey);

      if (serializedMedicines == null) {
        return [];
      }

      final List<dynamic> decodedMedicines = jsonDecode(serializedMedicines);
      return decodedMedicines
          .map((medicine) => Map<String, dynamic>.from(medicine))
          .toList();
    } catch (error) {
      print('Error loading medicine alerts: $error');
      return [];
    }
  }
}

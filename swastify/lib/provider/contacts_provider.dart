import 'package:flutter/material.dart';
import 'package:swastify/services/contacts_services.dart';

class ContactsProvider extends ChangeNotifier {
  List<Map<String, String>> _contacts = [];

  List<Map<String, String>> get contacts => _contacts;

  ContactsProvider() {
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    _contacts = await EmergencyContactsService.loadEmergencyContacts();
    notifyListeners();
  }

  Future<void> addContact(String name, String phone) async {
    _contacts.add({'name': name, 'phone': phone});
    await EmergencyContactsService.saveEmergencyContacts(_contacts);
    notifyListeners();
  }

  Future<void> editContact(int index, String name, String phone) async {
    if (index >= 0 && index < _contacts.length) {
      _contacts[index] = {'name': name, 'phone': phone};
      await EmergencyContactsService.saveEmergencyContacts(_contacts);
      notifyListeners();
    }
  }

  Future<void> deleteContact(int index) async {
    if (index >= 0 && index < _contacts.length) {
      _contacts.removeAt(index);
      await EmergencyContactsService.saveEmergencyContacts(_contacts);
      notifyListeners();
    }
  }

  Future<void> deleteMultipleContacts(List<int> indexes) async {
    indexes.sort((a, b) => b.compareTo(a)); // Sort in descending order
    for (int index in indexes) {
      if (index >= 0 && index < _contacts.length) {
        _contacts.removeAt(index);
      }
    }
    await EmergencyContactsService.saveEmergencyContacts(_contacts);
    notifyListeners();
  }
}

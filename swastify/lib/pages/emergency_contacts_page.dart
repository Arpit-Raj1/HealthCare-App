import 'package:flutter/material.dart';
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/search_bar.dart';
import 'package:swastify/components/sidebar.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/services/contacts_services.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

enum ProfileMenu { call, edit, delete }

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  _EmergencyContactsScreenState createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  List<Map<String, String>> contacts = [];
  List<Map<String, String>> filteredContacts = [];
  Set<int> selectedIndexes = {};
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContacts();
    searchController.addListener(_filterContacts);
  }

  /// Load contacts from storage
  Future<void> _loadContacts() async {
    List<Map<String, String>> savedContacts =
        await EmergencyContactsService.loadEmergencyContacts();
    setState(() {
      contacts = savedContacts;
      filteredContacts = List.from(contacts);
    });
  }

  /// Save contacts to storage
  Future<void> _saveContacts() async {
    await EmergencyContactsService.saveEmergencyContacts(contacts);
  }

  void _filterContacts() {
    setState(() {
      filteredContacts =
          contacts
              .where(
                (contact) => contact["name"]!.toLowerCase().contains(
                  searchController.text.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  void _deleteSelectedContacts() async {
    setState(() {
      contacts =
          contacts
              .asMap()
              .entries
              .where((entry) => !selectedIndexes.contains(entry.key))
              .map((entry) => entry.value)
              .toList();
      filteredContacts = List.from(contacts);
      selectedIndexes.clear();
    });
    await _saveContacts();
  }

  void _showAddContactPopup(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Emergency Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  prefixText: "+91 ",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  setState(() {
                    contacts.add({
                      "name": nameController.text,
                      "phone": "+91 ${phoneController.text}",
                    });
                    filteredContacts = List.from(contacts);
                  });
                  await _saveContacts();
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactPopup(BuildContext context, int index) {
    TextEditingController nameController = TextEditingController(
      text: contacts[index]['name'],
    );
    TextEditingController phoneController = TextEditingController(
      text: contacts[index]['phone']!.substring(4),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  prefixText: "+91 ",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  setState(() {
                    contacts[index] = {
                      "name": nameController.text,
                      "phone": "+91 ${phoneController.text}",
                    };
                    filteredContacts = List.from(contacts);
                  });
                  await _saveContacts();
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? emptyBody;
    PreferredSizeWidget? appBar1;
    if (contacts.isEmpty) {
      appBar1 = Appbar(title: AppStrings.emergencyContactList);
      emptyBody = Center(
        child: Text(
          AppStrings.addContacts,
          style: AppText.header1.copyWith(
            fontWeight: FontWeight.w100,
            color: AppColors.greyText,
          ),
        ),
      );
    }
    return Scaffold(
      appBar:
          appBar1 ??
          Appbar(
            title:
                selectedIndexes.isNotEmpty
                    ? "${selectedIndexes.length} Selected"
                    : AppStrings.emergencyContactList,
            actions:
                selectedIndexes.isNotEmpty
                    ? [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: _deleteSelectedContacts,
                      ),
                    ]
                    : [],
          ),
      drawer: const SideBar(selectedIndex: 5),
      body:
          emptyBody ??
          GestureDetector(
            onTap: () {
              if (selectedIndexes.isNotEmpty) {
                setState(() {
                  selectedIndexes.clear();
                });
              }
            },
            child: Column(
              children: [
                CustomSearchBar(controller: searchController),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndexes.contains(index);
                      return ListTile(
                        onLongPress: () => _toggleSelection(index),
                        onTap: () {
                          if (selectedIndexes.isNotEmpty) {
                            _toggleSelection(index);
                          } else {
                            // _makePhoneCall(filteredContacts[index]['phone']!);
                          }
                        },
                        tileColor: isSelected ? Colors.blue.shade100 : null,
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                        ),
                        title: Text(
                          filteredContacts[index]['name']!,
                          style: AppText.header2.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          filteredContacts[index]['phone']!,
                          style: AppText.body2,
                        ),
                        trailing: PopupMenuButton<ProfileMenu>(
                          onSelected: (value) async {
                            int actualIndex = contacts.indexWhere(
                              (contact) =>
                                  contact["phone"] ==
                                  filteredContacts[index]["phone"],
                            );
                            if (actualIndex != -1) {
                              if (value == ProfileMenu.edit) {
                                _showEditContactPopup(context, actualIndex);
                              } else if (value == ProfileMenu.delete) {
                                setState(() {
                                  contacts.removeAt(actualIndex);
                                  filteredContacts = List.from(contacts);
                                });
                                await _saveContacts();
                              }
                            }
                          },
                          icon: const Icon(Icons.more_vert_rounded),
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                value: ProfileMenu.edit,
                                child: Text(AppStrings.edit),
                              ),
                              PopupMenuItem(
                                value: ProfileMenu.delete,
                                child: Text("Delete"),
                              ),
                            ];
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactPopup(context),
        backgroundColor: const Color.fromARGB(255, 130, 184, 255),
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum ProfileMenu { call, edit, delete }

class EmergencyContactsScreen extends StatefulWidget {
  @override
  _EmergencyContactsScreenState createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  List<Map<String, String>> contacts = List.generate(
    1,
    (index) => {"name": "Aditya Aryan", "phone": "+91 7979737747"},
  );
  List<Map<String, String>> filteredContacts = [];
  Set<int> selectedIndexes = {}; // Stores selected items
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts = List.from(contacts);
    searchController.addListener(_filterContacts);
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

  void _deleteSelectedContacts() {
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
  }

  void _showAddContactPopup(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Emergency Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
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
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  setState(() {
                    contacts.add({
                      "name": nameController.text,
                      "phone": "+91 ${phoneController.text}",
                    });
                    filteredContacts = List.from(contacts);
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
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
          title: Text("Edit Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
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
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  setState(() {
                    contacts[index] = {
                      "name": nameController.text,
                      "phone": "+91 ${phoneController.text}",
                    };
                    filteredContacts = List.from(
                      contacts,
                    ); // Update the filtered list
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 
          selectedIndexes.isNotEmpty
              ? "${selectedIndexes.length} Selected"
              : "Emergency Contacts",
        ),
        leading:
            selectedIndexes.isEmpty
                ? IconButton(icon: Icon(Icons.menu), onPressed: () {})
                : null, // Remove leading when selection is active
        actions:
            selectedIndexes.isNotEmpty
                ? [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: _deleteSelectedContacts,
                  ),
                ]
                : [],
      ),

      body: GestureDetector(
        onTap: () {
          if (selectedIndexes.isNotEmpty) {
            setState(() {
              selectedIndexes.clear();
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
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
                        }
                      },
                      tileColor: isSelected ? Colors.blue.shade100 : null,
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                      title: Text(filteredContacts[index]['name']!),
                      subtitle: Text(filteredContacts[index]['phone']!),
                      trailing: PopupMenuButton<ProfileMenu>(
                        onSelected: (value) {
                          switch (value) {
                            case ProfileMenu.edit:
                              int actualIndex = contacts.indexWhere(
                                (contact) =>
                                    contact["phone"] ==
                                    filteredContacts[index]["phone"],
                              );
                              if (actualIndex != -1) {
                                _showEditContactPopup(context, actualIndex);
                              }
                              break;
                            case ProfileMenu.call:
                              break;
                            case ProfileMenu.delete:
                              setState(() {
                                contacts.removeAt(index);
                                filteredContacts = List.from(contacts);
                              });
                              break;
                          }
                        },

                        icon: const Icon(Icons.more_vert_rounded),
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: ProfileMenu.edit,
                              child: Text("Edit"),
                            ),
                            const PopupMenuItem(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactPopup(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

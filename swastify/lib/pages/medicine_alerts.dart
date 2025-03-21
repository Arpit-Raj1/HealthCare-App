import 'package:flutter/material.dart';
import 'package:swastify/components/add_medicine_dialog_box.dart';
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/medicine_tile.dart';
import 'package:swastify/components/sidebar.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/styles/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicineAlertsScreen(),
    );
  }
}

class MedicineAlertsScreen extends StatefulWidget {
  const MedicineAlertsScreen({super.key});
  @override
  _MedicineAlertsScreenState createState() => _MedicineAlertsScreenState();
}

class _MedicineAlertsScreenState extends State<MedicineAlertsScreen> {
  List<Map<String, dynamic>> medicines = [
    {
      "name": "Paracetamol",
      "times": ["7:00 AM", "4:00 PM"],
      "enabled": true,
    },
    {
      "name": "Cetrizine",
      "times": ["7:00 AM", "4:00 PM"],
      "enabled": true,
    },
    {
      "name": "Paracetamol",
      "times": ["7:00 AM", "4:00 PM"],
      "enabled": false,
    },
  ];

  List<Map<String, dynamic>> filteredMedicines = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMedicines = medicines;
  }

  void _filterMedicines(String query) {
    setState(() {
      filteredMedicines =
          medicines
              .where(
                (medicine) => medicine["name"].toLowerCase().startsWith(
                  query.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  void _showMedicineOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: AppColors.primary),
              title: Text("Edit"),
              onTap: () {
                Navigator.pop(context);
                _editMedicine(index);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text("Delete"),
              onTap: () {
                setState(() {
                  medicines.removeAt(index);
                  _filterMedicines(searchController.text);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _editMedicine(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AddMedicineDialog(
            initialName: medicines[index]["name"],
            initialTimes: List<String>.from(medicines[index]["times"]),
            onAdd: (name, times) {
              setState(() {
                medicines[index] = {
                  "name": name,
                  "times": times,
                  "enabled": medicines[index]["enabled"],
                };
                _filterMedicines(searchController.text);
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: AppStrings.medicineAlerts),
      drawer: SideBar(selectedIndex: 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: searchController,
              onChanged: _filterMedicines,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                hintText: AppStrings.search,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMedicines.length,
              itemBuilder: (context, index) {
                var medicine = filteredMedicines[index];
                return MedicineTile(
                  name: medicine["name"],
                  times: medicine["times"],
                  enabled: medicine["enabled"],
                  onChanged: (value) {
                    setState(() {
                      medicines[medicines.indexOf(medicine)]["enabled"] = value;
                      _filterMedicines(searchController.text);
                    });
                  },
                  onTap: () {
                    _showMedicineOptions(context, medicines.indexOf(medicine));
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AddMedicineDialog(
                          onAdd: (name, times) {
                            setState(() {
                              medicines.add({
                                "name": name,
                                "times": times,
                                "enabled": true,
                              });
                              _filterMedicines(searchController.text);
                            });
                          },
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  AppStrings.add,
                  style: TextStyle(fontSize: 18, color: AppColors.buttonText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

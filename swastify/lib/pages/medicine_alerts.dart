import 'package:flutter/material.dart';
import 'package:swastify/components/add_medicine_dialog_box.dart';
import 'package:swastify/components/alert_dialog.dart';
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/medicine_tile.dart';
import 'package:swastify/components/search_bar.dart';
import 'package:swastify/components/sidebar.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/services/medicine_alerts_services.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

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
  List<Map<String, dynamic>> medicines = [];
  List<Map<String, dynamic>> filteredMedicines = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  /// Load medicines from local storage
  Future<void> _loadMedicines() async {
    final loadedMedicines = await MedicineAlertsService.loadMedicines();
    setState(() {
      medicines = loadedMedicines;
      filteredMedicines = List.from(medicines);
    });
  }

  /// Save medicines to local storage
  Future<void> _saveMedicines() async {
    await MedicineAlertsService.saveMedicines(medicines);
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

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogBox(
          action: AppStrings.remove,
          title: AppStrings.removeMedicine,
          body: AppStrings.confirmRemoveMedicine,
          onDelete: () {
            setState(() {
              medicines.removeAt(index);
              _saveMedicines(); // Save after deletion
              _filterMedicines(searchController.text);
            });
            Navigator.pop(context);
          },
        );
      },
    );
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
                Navigator.pop(context);
                _showDeleteDialog(context, index);
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
      builder: (context) {
        return AddMedicineDialog(
          initialName: medicines[index]["name"],
          initialTimes: List<String>.from(medicines[index]["times"]),
          onAdd: (name, times) {
            setState(() {
              medicines[index] = {
                "name": name,
                "times": times,
                "enabled": medicines[index]["enabled"],
              };
              _saveMedicines();
              _filterMedicines(searchController.text);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: AppStrings.medicineAlerts),
      drawer: SideBar(selectedIndex: 1),
      body:
          medicines.isEmpty ? _buildEmptyState(context) : _buildMedicineList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Spacer(),
          SizedBox(height: 16),
          Text(
            AppStrings.addMedicineAlerts,
            style: AppText.header1.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.greyText,
            ),
          ),
          Spacer(),
          _addButton(context),
        ],
      ),
    );
  }

  Widget _buildMedicineList() {
    return Column(
      children: [
        CustomSearchBar(
          controller: searchController,
          onChanged: _filterMedicines,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMedicines.length,
            itemBuilder: (context, index) {
              var medicine = filteredMedicines[index];
              return MedicineTile(
                name: medicine["name"],
                times: List<String>.from(medicine["times"]),
                enabled: medicine["enabled"],
                onChanged: (value) {
                  setState(() {
                    medicines[medicines.indexOf(medicine)]["enabled"] = value;
                    _saveMedicines();
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
        _addButton(context),
      ],
    );
  }

  Widget _addButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddMedicineDialog(
                  onAdd: (name, times) {
                    setState(() {
                      medicines.add({
                        "name": name,
                        "times": times,
                        "enabled": true,
                      });
                      _saveMedicines(); // Save after adding
                      _filterMedicines(searchController.text);
                    });
                  },
                );
              },
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
    );
  }
}

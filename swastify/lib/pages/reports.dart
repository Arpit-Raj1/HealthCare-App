import 'package:flutter/material.dart';
import 'package:swastify/components/alert_dialog.dart';
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/search_bar.dart';
import 'package:swastify/components/sidebar.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class MedicalReportsScreen extends StatefulWidget {
  const MedicalReportsScreen({super.key});

  @override
  _MedicalReportsPageState createState() => _MedicalReportsPageState();
}

class _MedicalReportsPageState extends State<MedicalReportsScreen> {
  List<String> reports = ["Blood Report", "Blood Report", "Blood Report"];
  String searchQuery = "";

  void _showRenameDialog(int index) {
    TextEditingController renameController = TextEditingController(
      text: reports[index],
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              "Rename Report",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: TextField(
              controller: renameController,
              decoration: InputDecoration(
                hintText: "Enter new report name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppStrings.cancel,
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    reports[index] = renameController.text;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Text(AppStrings.rename, style: AppText.buttonText),
              ),
            ],
          ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialogBox(
            onDelete: () {
              setState(() {
                reports.removeAt(index);
              });
              Navigator.pop(context);
            },
            title: AppStrings.remove,
            body: AppStrings.confirmRemoveReport,
            action: AppStrings.remove,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredReports =
        reports
            .where(
              (report) =>
                  report.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: Appbar(title: AppStrings.medicalReports),
      drawer: SideBar(selectedIndex: 2),
      body: Column(
        children: [
          // Search Bar
          CustomSearchBar(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),

          // Reports List
          Expanded(
            child: ListView.builder(
              itemCount: filteredReports.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(
                    Icons.insert_drive_file,
                    color: AppColors.primary,
                  ),
                  title: Text(filteredReports[index], style: AppText.header2),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Rename') {
                        _showRenameDialog(index);
                      } else if (value == 'Delete') {
                        _showDeleteDialog(index);
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'Rename',
                            child: Text("Rename"),
                          ),
                          const PopupMenuItem(
                            value: 'Delete',
                            child: Text("Delete"),
                          ),
                        ],
                  ),
                );
              },
            ),
          ),

          // Upload Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle upload action
                },
                child: const Text(AppStrings.upload, style: AppText.buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

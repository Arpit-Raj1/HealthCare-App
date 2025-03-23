import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Map<String, String>> reports = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  /// Load reports from local storage
  Future<void> _loadReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedReports = prefs.getStringList('reports');

    if (storedReports != null) {
      setState(() {
        reports =
            storedReports
                .map((report) => Map<String, String>.from(jsonDecode(report)))
                .toList();
      });
    }
  }

  /// Save reports to local storage
  Future<void> _saveReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedReports =
        reports.map((report) => jsonEncode(report)).toList();
    await prefs.setStringList('reports', storedReports);

  }

  /// Pick and save a file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      Directory appDir = await getApplicationDocumentsDirectory();
      String newPath = "${appDir.path}/${result.files.single.name}";

      await file.copy(newPath);

      setState(() {
        reports.add({"name": result.files.single.name, "path": newPath});
      });
      _saveReports();
    }
  }

  /// Open a file
  void _openFile(String filePath) {
    OpenFilex.open(filePath);
  }

  /// Rename a file
  void _showRenameDialog(int index) {
    TextEditingController renameController = TextEditingController(
      text: reports[index]["name"]!,
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
                    reports[index]["name"] = renameController.text;
                  });
                  _saveReports();
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

  /// Delete a file
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialogBox(
            onDelete: () async {
              File file = File(reports[index]["path"]!);
              if (await file.exists()) {
                await file.delete();
              }
              setState(() {
                reports.removeAt(index);
              });
              _saveReports();
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
    List<Map<String, String>> filteredReports =
        reports
            .where(
              (report) => report["name"]!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      appBar: Appbar(title: AppStrings.medicalReports),
      drawer: SideBar(selectedIndex: 2),
      body: Column(
        children: [
          CustomSearchBar(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          Expanded(
            child:
                reports.isEmpty
                    ? Center(
                      child: Text("Upload Reports", style: AppText.header2),
                    )
                    : ListView.builder(
                      itemCount: filteredReports.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.insert_drive_file,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            filteredReports[index]["name"]!,
                            style: AppText.header2,
                          ),
                          onTap: () {
                            String filePath = filteredReports[index]["path"]!;
                            if (filePath.isNotEmpty) {
                              _openFile(filePath);
                            }
                          },
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
                onPressed: _pickFile,
                child: const Text(AppStrings.upload, style: AppText.buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

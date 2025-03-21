import 'package:flutter/material.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class AddMedicineDialog extends StatefulWidget {
  final Function(String, List<String>) onAdd;
  final String? initialName;
  final List<String>? initialTimes;

  const AddMedicineDialog({
    super.key,
    required this.onAdd,
    this.initialName,
    this.initialTimes,
  });

  @override
  _AddMedicineDialogState createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  late TextEditingController _nameController;
  late List<String> _times;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? "");
    _times = List.from(widget.initialTimes ?? []);
  }

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _times.add(picked.format(context));
      });
    }
  }

  void _removeTime(int index) {
    setState(() {
      _times.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(child: Text("Add Medicine", style: AppText.header1)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name of the Medicine", style: AppText.body1),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          SizedBox(height: 16),
          Text("Enter Time", style: AppText.body1),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      _times.isEmpty
                          ? Text(
                            "00:00",
                            style: AppText.body2.copyWith(color: Colors.grey),
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                _times.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  String time = entry.value;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(time, style: AppText.body2),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        onPressed: () => _removeTime(index),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: AppColors.primary),
                onPressed: _pickTime,
              ),
            ],
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty && _times.isNotEmpty) {
                widget.onAdd(_nameController.text, _times);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Add",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
  
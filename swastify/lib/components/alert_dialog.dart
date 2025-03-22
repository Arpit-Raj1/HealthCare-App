import 'package:flutter/material.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class AlertDialogBox extends StatefulWidget {
  final VoidCallback onDelete;
  final String title;
  final String body;
  final String action;
  const AlertDialogBox({
    super.key,
    required this.onDelete,
    required this.title,
    required this.body,
    required this.action,
  });

  @override
  State<AlertDialogBox> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<AlertDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(child: Text(widget.title, style: AppText.header2)),
      content: Text(
        widget.body,
        textAlign: TextAlign.center,
        style: AppText.body2,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            AppStrings.cancel,
            style: AppText.buttonText.copyWith(color: AppColors.primary),
          ),
        ),
        ElevatedButton(
          onPressed: widget.onDelete,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(widget.action, style: AppText.buttonText),
        ),
      ],
    );
  }
}

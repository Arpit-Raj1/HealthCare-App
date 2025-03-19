import 'package:flutter/material.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class ActionWithButton extends StatelessWidget {
  final String action;
  final String fileLoc;
  final String provider;
  final VoidCallback onPressed;
  const ActionWithButton({
    super.key,
    required this.fileLoc,
    required this.provider,
    required this.onPressed,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // width: 250,
        height: 40,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.actionBackround,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            side: const BorderSide(color: AppColors.white),
          ),
          icon: Image.asset(fileLoc, height: 24),
          onPressed: onPressed,
          label: Text(
            "$action with $provider",
            style: AppText.actionButtonText,
          ),
        ),
      ),
    );
  }
}

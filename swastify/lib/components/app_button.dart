import 'package:flutter/material.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String hintText;
  const AppButton({required this.onPressed, super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(hintText, style: AppText.buttonText),
      ),
    );
  }
}

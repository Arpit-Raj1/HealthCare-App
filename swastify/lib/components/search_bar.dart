import 'package:flutter/material.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/styles/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged ?? (_) => {},
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
    );
  }
}

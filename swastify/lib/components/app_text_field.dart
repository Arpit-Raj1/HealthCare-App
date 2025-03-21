import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
    );
  }
}

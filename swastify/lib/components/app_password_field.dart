import 'package:flutter/material.dart';

class AppPasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const AppPasswordField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter password";
        }
        if (value.length < 6) {
          return "Password length should be at least 6";
        }
        return null;
      },
    );
  }
}

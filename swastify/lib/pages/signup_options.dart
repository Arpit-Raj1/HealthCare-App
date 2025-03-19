import 'package:flutter/material.dart';
import 'package:swastify/components/app_signup.dart';
import 'package:swastify/config/app_routes.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class SignupOptions extends StatefulWidget {
  const SignupOptions({super.key});

  @override
  _SignupOptionsState createState() => _SignupOptionsState();
}

class _SignupOptionsState extends State<SignupOptions> {
  String? selectedRole;

  void _onRoleSelected(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Role",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Segmented Control (Tab Buttons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoleButton(
                    text: "Patient",
                    isSelected: selectedRole == "Patient",
                    onTap: () => _onRoleSelected("Patient"),
                  ),
                  _RoleButton(
                    text: "Doctor",
                    isSelected: selectedRole == "Doctor",
                    onTap: () => _onRoleSelected("Doctor"),
                  ),
                  _RoleButton(
                    text: "Caregiver",
                    isSelected: selectedRole == "Caregiver",
                    onTap: () => _onRoleSelected("Caregiver"),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // "Next" Button (Only Visible When a Role is Selected)
              if (selectedRole != null)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate or Perform Action
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.signup,
                        arguments: {'role': selectedRole},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Next", style: AppText.buttonText),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Role Button Widget
class _RoleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

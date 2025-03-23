import 'package:flutter/material.dart';
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/components/sidebar.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/services/user_details_services.dart'; // Import UserDetailsService
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  /// Fetches user details from local storage and updates the text fields
  Future<void> _loadUserDetails() async {
    String name = await UserDetailsService.getUserName();
    String number = await UserDetailsService.getUserNumber();

    setState(() {
      _nameController.text = name;
      _phoneController.text = number;
    });
  }

  /// Updates the user's name and phone number in local storage
  Future<void> _updateUserDetails() async {
    String newName = _nameController.text.trim();
    String newNumber = _phoneController.text.trim();

    await UserDetailsService.saveUserDetails(newName, newNumber);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User details updated successfully!")),
    );
  }

  String? validator(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Appbar(title: AppStrings.settings),
      drawer: SideBar(selectedIndex: 6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.18,
                      backgroundImage: AssetImage(AppStrings.profilePic),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.changePicture,
                        style: AppText.body1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              AppTextField(
                hint: AppStrings.name,
                controller: _nameController,
                validator: validator,
              ),
              SizedBox(height: 20),
              AppTextField(
                hint: AppStrings.exampleEmail,
                enabled: false,
                controller: _emailController,
                validator: validator,
              ),
              SizedBox(height: 20),
              AppTextField(
                hint: AppStrings.phoneNumber,
                controller: _phoneController,
                validator: validator,
              ),
              SizedBox(height: 20),
              AppPasswordField(
                hint: AppStrings.password,
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              // Update Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateUserDetails, // Call update function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(AppStrings.update, style: AppText.buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

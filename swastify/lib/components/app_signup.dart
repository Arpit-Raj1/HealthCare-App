import 'package:flutter/material.dart';
import 'package:swastify/components/app_button.dart';
import 'package:swastify/components/app_email_field.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/config/app_routes.dart';
import 'package:swastify/styles/app_text.dart';

class AppSignup extends StatefulWidget {
  final String role;
  const AppSignup({super.key, required this.role});

  @override
  State<AppSignup> createState() => _AppSignupState();
}

class _AppSignupState extends State<AppSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nmcController = TextEditingController();
  final TextEditingController _stateMedicalCouncilController =
      TextEditingController();
  final TextEditingController _yearOfRegistrationController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isChecked = false;

  final List<String> _stateMedicalCouncils = [
    "Andhra Pradesh Medical Council",
    "Assam Medical Council",
    "Bihar Medical Council",
    "Chhattisgarh Medical Council",
    "Delhi Medical Council",
    "Goa Medical Council",
    "Gujarat Medical Council",
    "Haryana Medical Council",
    "Himachal Pradesh Medical Council",
    "Jharkhand Medical Council",
    "Karnataka Medical Council",
    "Kerala Medical Council",
    "Madhya Pradesh Medical Council",
    "Maharashtra Medical Council",
    "Manipur Medical Council",
    "Meghalaya Medical Council",
    "Mizoram Medical Council",
    "Nagaland Medical Council",
    "Odisha Medical Council",
    "Punjab Medical Council",
    "Rajasthan Medical Council",
    "Sikkim Medical Council",
    "Tamil Nadu Medical Council",
    "Telangana Medical Council",
    "Tripura Medical Council",
    "Uttar Pradesh Medical Council",
    "Uttarakhand Medical Council",
    "West Bengal Medical Council",
  ];

  final List<String> _years = List.generate(
    DateTime.now().year - 1950 + 1,
    (index) => (1950 + index).toString(),
  );

  void _validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form is valid! Proceeding...")),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid input! Please correct the errors."),
        ),
      );
    }
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  String? nmcValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter your NMC/SMC number";
    }
    return null;
  }

  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  Widget _buildDropdownField({
    required String hintText,
    required TextEditingController controller,
    required List<String> options,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return options;
        }
        return options
            .where(
              (option) => option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              ),
            )
            .toList();
      },
      onSelected: (String selection) {
        controller.text = selection;
      },
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) {
        controller.text = textEditingController.text;
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select a $hintText";
            }
            return null;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text("Sign up as a ${widget.role}", style: AppText.header1),
                const SizedBox(height: 5),
                const Text(
                  "Create an account to get started",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  hint: 'Name',
                  controller: _nameController,
                  validator: nameValidator,
                ),
                const SizedBox(height: 15),
                EmailInputField(
                  labelText: "Email Address",
                  controller: _emailController,
                ),
                const SizedBox(height: 15),
                AppPasswordField(
                  hint: 'Create a password',
                  controller: _passwordController,
                ),
                const SizedBox(height: 15),
                AppPasswordField(
                  hint: 'Re-enter password',
                  controller: _confirmPasswordController,
                ),
                if (widget.role == "Doctor") ...[
                  const SizedBox(height: 15),
                  AppTextField(
                    hint: 'Registration Number',
                    controller: _nmcController,
                    validator: nmcValidator,
                  ),
                  const SizedBox(height: 15),
                  _buildDropdownField(
                    hintText: 'State Medical Council',
                    controller: _stateMedicalCouncilController,
                    options: _stateMedicalCouncils,
                  ),
                  const SizedBox(height: 15),
                  _buildDropdownField(
                    hintText: 'Year of Registration',
                    controller: _yearOfRegistrationController,
                    options: _years,
                  ),
                ],
                const SizedBox(height: 15),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "I've read and agree with the "),
                            TextSpan(
                              text: "Terms and Conditions",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006FFd),
                              ),
                            ),
                            TextSpan(text: " and the "),
                            TextSpan(
                              text: "Privacy Policy.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006FFd),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                AppButton(onPressed: _validateForm, hintText: "Sign Up"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

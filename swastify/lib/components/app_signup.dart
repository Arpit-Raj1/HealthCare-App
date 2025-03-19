import 'package:flutter/material.dart';
import 'package:swastify/components/action_with_button.dart';
import 'package:swastify/components/app_button.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/components/app_text_field.dart';
import 'package:swastify/config/app_routes.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/pages/login_page.dart';
import 'package:swastify/styles/app_text.dart';

class AppSignup extends StatefulWidget {
  final String role;
  const AppSignup({super.key, required this.role});

  @override
  State<AppSignup> createState() => _AppSignupState();
}

class _AppSignupState extends State<AppSignup> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth > 600 ? 100 : 20;
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppStrings.signup} as a ${widget.role}",
                      style: AppText.header1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppStrings.createAAccountToGetStarted,
                      style: AppText.subtitle3,
                    ),
                    const SizedBox(height: 20),
                    // Name Field
                    AppTextField(hint: AppStrings.name),
                    const SizedBox(height: 15),
                    AppTextField(hint: AppStrings.email),
                    const SizedBox(height: 15),
                    // Password Field
                    AppPasswordField(
                      hint: AppStrings.createAAccountToGetStarted,
                    ),
                    const SizedBox(height: 15),
                    // Confirm Password Field
                    AppPasswordField(hint: AppStrings.reEnterPassword),
                    if (widget.role == AppStrings.doctor) ...[
                      const SizedBox(height: 15),
                      AppTextField(hint: AppStrings.nmcSmcRegistrationNumber),
                    ],
                    const SizedBox(height: 15),
                    // Terms and Conditions Checkbox
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
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(
                                  text:
                                      ("${AppStrings.iveReadAndAgreeWithThe} "),
                                ),
                                TextSpan(
                                  text: AppStrings.termsAndConditions,
                                  style: AppText.primaryText,
                                ),
                                const TextSpan(
                                  text: " ${AppStrings.and} ${AppStrings.the} ",
                                ),
                                TextSpan(
                                  text: AppStrings.privacyPolicy,
                                  style: AppText.primaryBoldText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Sign Up Button
                    AppButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                          (route) => false,
                        );
                      },
                      hintText: AppStrings.signup,
                    ),
                    const SizedBox(height: 20),
                    // OR Divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey[300]),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("OR"),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey[300]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Google Sign Up Button
                    ActionWithButton(
                      fileLoc: AppStrings.googleLogo,
                      provider: AppStrings.google,
                      onPressed: () {},
                      action: AppStrings.signup,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

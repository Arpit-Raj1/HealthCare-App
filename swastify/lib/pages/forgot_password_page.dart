import 'package:flutter/material.dart';
import 'package:swastify/pages/confirmation_page.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text("Forgot Password", style: AppText.header1),
                SizedBox(height: 8),
                Text(
                  "Enter email ID to reset your password",
                  style: TextStyle(fontSize: 14, color: AppColors.greyText),
                ),
                SizedBox(height: 50),
                EmailInputField(),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(),
                        ),
                      );
                    },
                    child: Text("Submit", style: AppText.buttonText),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EmailInputField extends StatefulWidget {
  const EmailInputField({super.key});

  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Registered Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your email";
          }
          final emailRegex = RegExp(
            r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
          );
          if (!emailRegex.hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ForgotPasswordPage()),
  );
}

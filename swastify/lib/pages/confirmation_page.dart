import 'package:flutter/material.dart';
import 'package:swastify/pages/reset_password_page.dart';
import 'package:swastify/styles/app_colors.dart';
import 'package:swastify/styles/app_text.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // double width = constraints.maxWidth;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text("Enter Confirmation Code", style: AppText.header1),
                SizedBox(height: 8),
                Text(
                  "A 4-digit code was sent to a*****ks@gmail.com",
                  style: TextStyle(fontSize: 14, color: AppColors.greyText),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                OTPInputFields(),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    // Resend code action
                  },
                  child: Center(
                    child: Text(
                      "Resend code",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                SizedBox(height: 16),
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
                          builder: (context) => ResetPasswordPage(),
                        ),
                      );
                    },
                    child: Text("Continue", style: AppText.buttonText),
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

class OTPInputFields extends StatefulWidget {
  const OTPInputFields({super.key});
  @override
  _OTPInputFieldsState createState() => _OTPInputFieldsState();
}

class _OTPInputFieldsState extends State<OTPInputFields> {
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double boxSize = MediaQuery.of(context).size.width * 0.16;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: boxSize,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ConfirmationPage()),
  );
}

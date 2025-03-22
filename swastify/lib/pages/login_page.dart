import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swastify/components/action_with_button.dart';
import 'package:swastify/components/app_button.dart';
import 'package:swastify/components/app_email_field.dart';
import 'package:swastify/components/app_password_field.dart';
import 'package:swastify/config/app_routes.dart';
import 'package:swastify/config/app_strings.dart';
import 'package:swastify/pages/forgot_password_page.dart';
import 'package:swastify/pages/signup_options.dart';
import 'package:swastify/provider/login_provider.dart';
import 'package:swastify/services/auth_service.dart';
import 'package:swastify/styles/app_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key

  void _validateForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true); // Set user as logged in
      Navigator.of(context).pushReplacementNamed(AppRoutes.medicineAlerts);
    }
  }

  Future<void> submitLogin() async {
    _validateForm();
    await signInWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );

    print("Signed in");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 600 ? 100 : 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      SizedBox(
                        height: (constraints.maxWidth > 600) ? 350 : 250,
                        child: SvgPicture.asset(
                          "assets/svg/app_logo.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text("Welcome!", style: AppText.header1),
                      const SizedBox(height: 20),

                      EmailInputField(
                        labelText: "Email",
                        controller: _emailController,
                      ),
                      const SizedBox(height: 15),

                      AppPasswordField(
                        hint: 'Password',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text("Forgot password?"),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Calls _validateForm()
                      AppButton(
                        onPressed: () async {
                          await submitLogin();
                        },
                        hintText: "Login",
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Not a member?"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignupOptions(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      ActionWithButton(
                        fileLoc: "assets/images/google_logo.png",
                        provider: "Google",
                        onPressed: () async {
                          // print("Google");
                          if (await signInWithGoogle() != null) {
                            final user = FirebaseAuth.instance.currentUser;
                            final token = await user?.getIdToken();

                            final loginProvider = Provider.of<LoginProvider>(
                              context,
                              listen: false,
                            );

                            await loginProvider.setToken(token!, user!.uid);
                            // for logout
                            // final loginProvider = Provider.of<LoginProvider>(context, listen: false);
                            // await loginProvider.clearToken();
                            // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                            final response = await verifyUser(
                              url: "${AppStrings.serverBaseUrl}/auth/verify",
                              body: {"uid": user.uid},
                              loginProvider: loginProvider,
                            );

                            // not a new user
                            if (response.statusCode == 202) {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(AppRoutes.medicineAlerts);
                            }
                            // new user
                            else if (response.statusCode == 201) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignupOptions(),
                                ),
                              );
                            } else {
                              loginProvider.clearToken();
                              throw Exception();
                            }
                          }
                        },
                        action: "Login",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

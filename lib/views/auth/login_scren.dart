import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/service/auth_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/views/auth/forgot_paas.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';

class LoginScren extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final authService = AuthService();
  bool isPasswordVisible = false;
  String? errorMessage;
  void login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    String email = emailcontroler.text.trim();
    String password = passwordcontroler.text.trim();

    if (!email.endsWith("@gmail.com")) {
      email = "$email@gmail.com";
    }
    try {
      bool success = await authService.login(email, password);
      if (!mounted) return;
      if (success) {
        Navigator.pushReplacementNamed(context, AppRoutes.bottomNavigationBar);
      } else {
        setState(() {
          errorMessage = "Invalid username or password";
        });
        Future.delayed(Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              errorMessage = null;
            });
          }
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = "Something went wrong. Please try again.";
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailcontroler.dispose();
    passwordcontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 20,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 90,
                          width: 90,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.restaurant_menu,
                              size: 75,
                              color: AppColors.primary,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 0.1),
                      // App name
                      Center(
                        child: Text(
                          'RecipeNest',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      // Welcome text
                      Center(
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(
                            color: AppColors.text1,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Sign in to discover your favourite recipes.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textsec,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // email
                            Text(
                              'Email Address',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.text1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            //email field
                            CustomTextField(
                              hintText: "Enter your email",
                              controller: emailcontroler,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.text1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomTextField(
                              hintText: 'Enter your password',
                              controller: passwordcontroler,
                              prefixIcon: Icons.lock_outline,
                              obscureText: !isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.textsec,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              
                              builder: (context) =>
                                  ForgotPasswordDialog(),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              errorMessage!,
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),
                        ),

                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: isLoading ? 'Please wait...' : 'Login',
                          onpressed: login,
                          isLoading: isLoading,
                          icon: Icons.login,
                        ),
                      ),
                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: AppColors.textsec,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.signup);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
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

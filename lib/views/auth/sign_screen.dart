import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/service/auth_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';

class SignScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  String? errorMessage;

  // Error message hide cheyyan
  void showError(String message) {
    setState(() {
      errorMessage = message;
    });

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          errorMessage = null;
        });
      }
    });
  }

  //save
  void registeruser() async {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // String conformpassword = confirmPasswordController.text.trim();
    //emailvalidation
    if (!email.endsWith("@gmail.com")) {
      email = "$email@gmail.com";
    }
    //register user
    try {
      bool success = await authService.register(name, email, password);
      if (!mounted) return;
      if (success) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        showError("This email is already existing");
      }
    } catch (e) {
      if (!mounted) return;
      showError("Something went wrong. Please try again.");
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 24,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        // Back Arrow
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Color(0xFFF3DFD7),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 20,
                              color: AppColors.text1,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        // Create Account heading
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1,
                          ),
                        ),
                        SizedBox(height: 6),
                        // Subtitle
                        Text(
                          'Join RecipeNest to store and manage your recipes .',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: AppColors.textsec,
                          ),
                        ),
                        SizedBox(height: 22),
                        // Full Name
                        Text(
                          'FULL NAME *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text1,
                          ),
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter your full name',
                          controller: nameController,
                          prefixIcon: Icons.person_outline,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Email Address
                        Text(
                          'EMAIL ADDRESS *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text1,
                          ),
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter your email',
                          controller: emailController,
                          prefixIcon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            if (errorMessage != null) {
                              setState(() {
                                errorMessage = null;
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),
                        // Existing email error
                        if (errorMessage != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              errorMessage!,
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),
                        SizedBox(height: 16),
                        // Password
                        Text(
                          'PASSWORD *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text1,
                          ),
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Create a password',
                          controller: passwordController,
                          prefixIcon: Icons.lock_outline,
                          obscureText: !isPasswordVisible,
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
                              size: 20,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            if (value.length < 6) {
                              return "Password must contain at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Confirm Password
                        Text(
                          'CONFIRM PASSWORD *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text1,
                          ),
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Re-enter your password',
                          controller: confirmPasswordController,
                          obscureText: !isConfirmPasswordVisible,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.textsec,
                              size: 20,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != passwordController.text) {
                              return "Password do not match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Register Account',
                            onpressed: () {
                              registeruser();
                            },
                            isLoading: isLoading,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Color(0xFFE5EAF2), height: 1),
                        SizedBox(height: 9),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: AppColors.textsec,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Color(0xFFFF543D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

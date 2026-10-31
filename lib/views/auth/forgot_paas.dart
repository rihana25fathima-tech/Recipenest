import 'package:flutter/material.dart';
import 'package:recipe_next/service/auth_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_text_field.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authService = AuthService();
  bool isLoading = false;
  bool isPasswordVisible = false;
  Future<void> updatePassword() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (!email.contains('@')) {
      email = '$email@gmail.com';
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    bool success = await authService.resetPassword(email, password);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pop(context); 
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password updated successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email address not found')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,

      title: Row(
        children: [
          Icon(Icons.lock_reset, color: AppColors.primary, size: 25),
          SizedBox(width: 8),
          Text(
            'Forgot Password?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            Text(
              'Email Address',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.text1,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 8),

            CustomTextField(
              hintText: "Enter your email",
              controller: emailController,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 20),

            Text(
              'New Password',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.text1,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 8),

            CustomTextField(
              hintText: 'Enter your new password',
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
                ),
              ),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel', style: TextStyle(color: AppColors.textsec)),
        ),

        ElevatedButton(
          onPressed: isLoading ? null : updatePassword,

          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text('Update Password', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

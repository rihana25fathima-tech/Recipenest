import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_next/model/user_model.dart';
import 'package:recipe_next/service/auth_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final authService = AuthService();
  late TextEditingController namecontroller;
  late UserModel currentUser;

  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController();
    loadUser();
  }
  Future<void> loadUser() async {

  // Get logged-in email from SharedPreferences
  String? email = await authService.getLoggedInUser();

  if (email == null) return;

  final userBox = Hive.box<UserModel>('open');

  // Find user using email
  currentUser = userBox.values.firstWhere(
    (user) => user.email == email,
  );

  namecontroller.text = currentUser.name;

  if (mounted) {
    setState(() {});
  }
}

  @override
  void dispose() {
    namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF3DFD7),
                        border: Border.all(color: Color(0xFFF3DFD7)),
                      ),
                      child: Icon(Icons.arrow_back, size: 19),
                    ),
                  ),
                  SizedBox(width: 18),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: 106,
                  width: 106,
                  margin: EdgeInsets.only(top: 0, left: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1,
                      ),
                    ),

                    Text(
                      'Manage your personal details',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textsec,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Personal information heading
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'PERSONAL INFORMATION',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: AppColors.text1,
                  ),
                ),
              ),
              SizedBox(height: 22),
              // Full name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: "Enter full name",
                      controller: namecontroller,
                      prefixIcon: Icons.person,
                    ),

                    SizedBox(height: 50),
                    CustomButton(
                      text: "Save changes",
                      onpressed: () async {
                        String newName = namecontroller.text.trim();
                        if (newName.isEmpty) {
                          return;
                        }
                        final userBox = Hive.box<UserModel>('open');
                        // Update existing name
                        // currentUser.name = newName;

                        // Save updated user in Hive
                        int index = userBox.values.toList().indexWhere(
                          (user) => user.isLoggedIn == true,
                        );
                        if (index == -1) {
                          return;
                        }

                        // Get current user
                        currentUser = userBox.getAt(index)!;

                        // Update name
                        currentUser.name = newName;

                        // Save in Hive
                        await userBox.putAt(index, currentUser);

                        if (!context.mounted) return;

                        // Close edit page
                        Navigator.pop(context, true);
                      },
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Text(
                        'Changes will instantly update your RecipeNest profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textsec,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

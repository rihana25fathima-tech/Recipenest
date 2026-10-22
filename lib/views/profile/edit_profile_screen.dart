import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController? get namecontroller => null;

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
              SizedBox(height: 5),
              _buildProfilePhoto(),
              SizedBox(height: 2),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Profile Photo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1,
                      ),
                    ),

                    Text(
                      'Update your profile photo',
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
                    SizedBox(height: 22),
                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: "Enter Email",
                      controller: namecontroller,
                      prefixIcon: Icons.email,
                    ),

                    SizedBox(height: 50),
                    CustomButton(
                      text: "Save changes",
                      onpressed: () {
                        Navigator.pop(context);
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

  Widget _buildProfilePhoto() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 2),
          SizedBox(
            height: 126,
            width: 126,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 106,
                  width: 106,
                  margin: EdgeInsets.only(top: 0, left: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 24,
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Photo upload will be added later.'),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

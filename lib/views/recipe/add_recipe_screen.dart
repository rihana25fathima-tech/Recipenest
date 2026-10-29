import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';
import 'package:recipe_next/widget/difficult.dart';
import 'package:recipe_next/widget/steps_3.dart';

class AddRecipeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final List<String> catagary = [
    'Breakfast',
    'Lunch',
    'Evening Snack',
    'Dinner',
    'Dessert',
    'Other',
  ];
  String selectedCatagory = 'Dinner';
  String selectedDifficuilt = 'Medium';

  TextEditingController reciepenamecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  final imagePicker = ImagePicker();
  File? selectedImage;
  //image picker function
  Future<void> pickRecipeImage() async {
    XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  RecipeModel? editingRecipe;
  int? editingIndex;
  bool argumentsLoaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (argumentsLoaded) return;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map) {
      editingRecipe = args['recipe'] as RecipeModel?;
      editingIndex = args['index'] as int?;
    }

    if (editingRecipe != null) {
      reciepenamecontroller.text = editingRecipe!.name;
      timecontroller.text = editingRecipe!.cookinTime;

      selectedCatagory = editingRecipe!.category;
      selectedDifficuilt = editingRecipe!.difficulty;

      if (editingRecipe!.image.isNotEmpty) {
        final file = File(editingRecipe!.image);

        if (file.existsSync()) {
          selectedImage = file;
        }
      }
    }

    argumentsLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //back button
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(18, 12, 18, 0),
              child: Column(
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
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add New Recipe',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Step 1 of 3 · Basic Details',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textsec,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  //step indicator
                  Row(
                    spacing: 8,
                    children: [
                      Steps3(title: '1 details', active: true),
                      Steps3(title: '2. Ingredients', active: false),
                      Steps3(title: '3. Steps', active: false),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 26),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //recipe cober image
                    Text(
                      'RECIPE COVER IMAGE *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: pickRecipeImage,
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8E6FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: selectedImage != null
                              ? Image.file(
                                  selectedImage!,
                                  width: double.infinity,
                                  height: 160,
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 42,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Add Cover image",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.text1,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Tap to choose from gallery',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textsec,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      selectedImage != null
                          ? 'Tap the image to change it.'
                          : 'Choose a beautiful photo of your dish.',
                      style: TextStyle(fontSize: 13, color: AppColors.textsec),
                    ),
                    SizedBox(height: 24),
                    // Recipe Information Heading
                    Row(
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'RECIPE INFORMATION',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Recipe Name Label
                    Text(
                      'RECIPE NAME *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 8),

                    CustomTextField(
                      controller: reciepenamecontroller,
                      hintText: 'Enter recipe name',
                      prefixIcon: Icons.restaurant_menu,
                    ),
                    SizedBox(height: 20),
                    //cartagory
                    Text(
                      'CATEGORY *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 8),
                    //catagy dropdown
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCatagory,
                          isExpanded: true,
                          hint: Text("Selected Category"),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textsec,
                          ),
                          items: catagary.map((categary) {
                            return DropdownMenuItem<String>(
                              value: categary,
                              child: Text(
                                categary,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.text1,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedCatagory = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //coking time
                    Text(
                      'COOKING TIME *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: timecontroller,
                      hintText: 'Enter cooking time in minutes',
                      prefixIcon: Icons.access_time,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    // Difficulty Level Label
                    Text(
                      'DIFFICULTY LEVEL *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Difficulty Level Options
                    Row(
                      spacing: 10,
                      children: [
                        Difficult(
                          difficulty: "Easy",
                          selectedDifficuilt: selectedDifficuilt,
                          onSelected: (value) {
                            setState(() {
                              selectedDifficuilt = value;
                            });
                          },
                        ),
                        Difficult(
                          difficulty: "Medium",
                          selectedDifficuilt: selectedDifficuilt,
                          onSelected: (value) {
                            setState(() {
                              selectedDifficuilt = value;
                            });
                          },
                        ),
                        Difficult(
                          difficulty: "Hard",
                          selectedDifficuilt: selectedDifficuilt,
                          onSelected: (value) {
                            setState(() {
                              selectedDifficuilt = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          color: AppColors.background,
          child: CustomButton(
            text: 'Next: Add Ingredients',
            onpressed: () async {
              if (reciepenamecontroller.text.trim().isEmpty ||
                  timecontroller.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter recipe name and cooking time'),
                  ),
                );
                return;
              }
              final result = await Navigator.pushNamed(
                context,
                AppRoutes.addIngredientScreen,
                arguments: {
                  'name': reciepenamecontroller.text.trim(),
                  'category': selectedCatagory,
                  'cookingTime': timecontroller.text.trim(),
                  'difficulty': selectedDifficuilt,
                  'image': selectedImage?.path ?? editingRecipe?.image ?? '',
                  'editingRecipe': editingRecipe,
                  'index': editingIndex,
                },
              );
              if (!mounted) return;
              if (result == true) {
                Navigator.pop(context, true);
              }
            },
            icon: Icons.arrow_forward,
          ),
        ),
      ),
    );
  }
}

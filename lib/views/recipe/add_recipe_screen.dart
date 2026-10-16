import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';

class AddRecipeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  String selectedCatagory = 'Dinner';
  final List<String> catagary = [
    'Breakfast',
    'Lunch',
    'Evening Snack',
    'Dinner',
    'Dessert',
    'Other',
  ];

  String selectedDifficuilt = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //back button
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
                children: [
                  _buildStep('1 details', true),
                  SizedBox(width: 8),
                  _buildStep('2. Ingredients', false),
                  SizedBox(width: 8),
                  _buildStep('3. Steps', false),
                ],
              ),
              SizedBox(height: 26),
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
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E6FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/chicken-biryani-recipe.jpg',
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Choose a beautiful photo of your dish.',
                style: TextStyle(fontSize: 14, color: AppColors.textsec),
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
                  border: Border.all(
                    color: AppColors.textsec.withValues(alpha: 0.3),
                  ),
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
                children: [
                  _buildDifficult('Easy'),
                  SizedBox(width: 10),
                  _buildDifficult('Medium'),
                  SizedBox(width: 10),
                  _buildDifficult('Hard'),
                ],
              ),
               SizedBox(height: 30),

// Next Button
CustomButton(
  text: 'Next: Add Ingredients',
  onpressed: () {
    Navigator.pushNamed(context, AppRoutes.addIngredientScreen);
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
        content: Text('Ingredients page coming next!'),
      ),
    );
  },
  icon: Icons.arrow_forward,
),

const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String title, bool active) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : const Color(0xFFE0E6F0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 7),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9,
              color: active ? AppColors.primary : const Color(0xFF8A9AB8),
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildDifficult(String difficulty) {
    final bool isSelected = selectedDifficuilt == difficulty;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDifficuilt = difficulty;
          });
        },
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textsec.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            difficulty,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.text1,
            ),
          ),
        ),
      ),
    );
  }
}

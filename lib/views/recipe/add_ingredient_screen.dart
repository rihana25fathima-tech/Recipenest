import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';

class AddIngredientScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddIngredientScreen> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  TextEditingController? get ingredientControlle => null;

  TextEditingController? get quantityController => null;

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
                  SizedBox(width: 18),
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
                          'Step 2 of 3 ·Ingredients',
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
              Row(
                children: [
                  _buildStep('1 details', false),
                  SizedBox(width: 8),
                  _buildStep('2. Ingredients', true),
                  SizedBox(width: 8),
                  _buildStep('3. Steps', false),
                ],
              ),
              SizedBox(height: 22),

              // Add New Ingredient Card
              Container(
                padding: EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE4EAF2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Heading
                    Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFFFF5038),
                          size: 17,
                        ),

                        SizedBox(width: 7),

                        Expanded(
                          child: Text(
                            'ADD NEW INGREDIENT',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF172033),
                            ),
                          ),
                        ),

                        Text(
                          'Item & Measure',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textsec,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'INGREDIENT',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: ingredientControlle,
                      hintText: 'e.g. Large Raw Shrimp',
                    ),
                    SizedBox(height: 14),
                    Text(
                      'QUANTITY / MEASURE',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),

                    SizedBox(height: 8),
                    CustomTextField(
                      hintText: 'e.g. 400g or 2 cups',
                      controller: quantityController,
                    ),
                    SizedBox(height: 14),
                    SizedBox(
                      height: 42,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                         
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColors.primary,
                          size: 18,
                        ),

                        label: Text(
                          'Add to List',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 236, 231),
                          side: BorderSide(color: Color(0xFFFFD1C7)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              // Added Ingred Heading
              Row(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      'ADDED INGREDIENTS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
              _buildList("1", "Egg", "2"),
              SizedBox(height: 8),
              _buildList("2", "Milk", "3/4"),
              SizedBox(height: 8),
              _buildList("3", "Pototao", "4"),
              SizedBox(height: 8),
              _buildList("3", "Pototao", "4"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        color: AppColors.background,
        child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      text: 'Back',
                      onpressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 12),

                  ///nextbutton
                  Expanded(
                    flex: 6,
                    child: CustomButton(
                      text: 'Next Instruction',
                      onpressed: () {
                        Navigator.pushNamed(context, AppRoutes.addInstructions);
                      },
                    ),
                  ),
                ],
              ),
      )),
    );
  }

  //bild list
  Widget _buildList(String number, String name, String quantity) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Row(
        children: [
          //number
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF2EE),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 12),
          // Name and Quantity
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  quantity,
                  style: TextStyle(fontSize: 11, color: AppColors.textsec),
                ),
              ],
            ),
          ),
          // Delete Button
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_outline,
              size: 18,
              color: Color(0xFF98A8C0),
            ),
          ),
        ],
      ),
    );
  }

  //stps widget
  Widget _buildStep(String title, bool active) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : Color(0xFFE0E6F0),
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
              color: active ? AppColors.primary : Color(0xFF8A9AB8),
            ),
          ),
        ],
      ),
    );
  }
}

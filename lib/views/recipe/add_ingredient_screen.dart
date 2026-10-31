import 'package:flutter/material.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/custom_text_field.dart';
import 'package:recipe_next/widget/ingredients_list.dart';
import 'package:recipe_next/widget/steps_3.dart';

class AddIngredientScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddIngredientScreen> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  TextEditingController ingredientControlle = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  List<Map<String, String>> ingredients = [];
  Map<String, dynamic> recipedetails = {};
  bool argumentsLoaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!argumentsLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args is Map) {
        recipedetails = Map<String, dynamic>.from(args);
      }

      final recipe = recipedetails['editingRecipe'];

      if (recipe is RecipeModel && recipe.ingredients.trim().isNotEmpty) {
        final items = recipe.ingredients.split(',');

        ingredients = items.map((item) {
          final parts = item.split(' - ');
          return <String, String>{
            'name': parts.first.trim(),
            'quantity': parts.length > 1
                ? parts.sublist(1).join(' - ').trim()
                : '',
          };
        }).toList();
      }
      argumentsLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // fixed
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
                    spacing: 8,
                    children: [
                      Steps3(title: '1 Details', active: false),
                      Steps3(title: '2 Ingredients', active: true),
                      Steps3(title: '3 Steps', active: false),
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
                            offset: Offset(0, 3),
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
                                String ingredient = ingredientControlle.text
                                    .trim();
                                String quantity = quantityController.text
                                    .trim();

                                if (ingredient.isEmpty || quantity.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Enter ingredient and quantity',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  ingredients.add({
                                    'name': ingredient,
                                    'quantity': quantity,
                                  });

                                  ingredientControlle.clear();
                                  quantityController.clear();
                                });
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
                                backgroundColor: Color.fromARGB(
                                  255,
                                  255,
                                  236,
                                  231,
                                ),
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
                      ],
                    ),
                    SizedBox(height: 20),
                    ...ingredients.asMap().entries.map((e) {
                      int index = e.key;
                      Map<String, String> ingredient = e.value;
                      return IngredientsList(
                        number: '${index + 1}',
                        name: ingredient['name'] ?? '',
                        quantity: ingredient['quantity'] ?? '',
                        onDelete: () {
                          setState(() {
                            ingredients.removeAt(index);
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                  onpressed: () async {
                    if (ingredients.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please add at least one ingredient'),
                        ),
                      );
                      return;
                    }
                    final String ingredienttext = ingredients
                        .map(
                          (items) => '${items['name']} - ${items['quantity']}',
                        )
                        .join(',');
                    final result = await Navigator.pushNamed(
                      context,
                      AppRoutes.addInstructions,
                      arguments: {
                        ...recipedetails,
                        'ingredients': ingredienttext,
                      },
                    );
                    if (!context.mounted) return;

                    if (result == true) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

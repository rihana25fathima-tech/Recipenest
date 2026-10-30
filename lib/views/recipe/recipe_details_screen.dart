import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/service/recipe_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/ingrediitemss.dart';
import 'package:recipe_next/widget/instructionitem.dart';
import 'package:recipe_next/widget/recipeinfocard.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final recipeService = RecipeService();
  Future<void> delete(RecipeModel recipe) async {
    final recipes = recipeService.getRecipe();
    final index = recipes.indexOf(recipe);
    if (index == -1) return;
    await recipeService.deleteRecipes(index);
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  int getRecipeIndex(RecipeModel recipe) {
    return recipeService.getRecipe().indexWhere(
      (item) => identical(item, recipe),
    );
  }

  Future<void> update(RecipeModel recipe) async {
    final index = getRecipeIndex(recipe);
    if (index == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Recipe not found')));
      return;
    }
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.addRecipeScreen,
      arguments: {'recipe': recipe, 'index': index},
    );
    if (!mounted) return;

    if (result == true) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as RecipeModel;
    final List<String> ingredient = recipe.ingredients
        .split(',')
        .where((item) => item.trim().isNotEmpty)
        .toList();
    final List<String> instructions = recipe.instruction
        .split('\n')
        .where((step) => step.trim().isNotEmpty)
        .toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 220,
                          child:
                              recipe.image.isNotEmpty &&
                                  File(recipe.image).existsSync()
                              ? Image.file(
                                  File(recipe.image),
                                  width: double.infinity,
                                  height: 220,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 220,
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 70,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),

                        Positioned(
                          top: 12,
                          left: 14,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.name,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Category
                          Text(
                            recipe.category,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textsec,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Cooking Time and Difficulty
                          Row(
                            children: [
                              Expanded(
                                child: Recipeinfocard(
                                  icon: Icons.access_time,
                                  title: "Cook Time",
                                  value: '${recipe.cookinTime} mins',
                                ),
                              ),

                              SizedBox(width: 12),
                              Expanded(
                                child: Recipeinfocard(
                                  icon: Icons.local_fire_department,
                                  title: "Difficulty",
                                  value: recipe.difficulty,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24),
                          // Ingredients Heading
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Ingredients',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${ingredient.length} items',
                                style: TextStyle(
                                  color: Color(0xFFE85D3F),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),
                          //ing list dyanmic
                          ...ingredient.map((item) {
                            final parts = item.split(' - ');
                            final String name = parts.first.trim();
                            final String quantity = parts.length > 1
                                ? parts.sublist(1).join(' - ').trim()
                                : '';
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Ingrediitemss(
                                name: name,
                                quantity: quantity,
                              ),
                            );
                          }),

                          SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Cooking Instructions',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              Text(
                                'Step-by-Step',
                                style: TextStyle(
                                  color: Color(0xFFE85D3F),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          ...instructions.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final String step = entry.value.trim();
                            // "Step 1: " remove cheyyunnu
                            final String description = step.replaceFirst(
                              RegExp(
                                r'^Step\s+\d+\s*:\s*',
                                caseSensitive: false,
                              ),
                              '',
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),

                              child: Instructionitem(
                                number: '${index + 1}',
                                title: 'Step ${index + 1}',
                                description: description,
                              ),
                            );
                          }),

                          SizedBox(height: 24),
                        ],
                      ),
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
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: AppColors.background,
          child: Row(
            children: [
              // Delete Button
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      delete(recipe);
                    },
                    icon: Icon(Icons.delete, size: 18),
                    label: Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.text,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // Edit Button
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      update(recipe);
                    },
                    icon: Icon(Icons.edit, size: 18),
                    label: Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.text,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // Your CustomButton
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.bottomNavigationBar,
                      );
                    },
                    icon: Icon(Icons.check, size: 20),
                    label: Text('Ok'),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.text,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

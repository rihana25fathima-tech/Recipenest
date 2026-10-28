import 'package:flutter/material.dart';
import 'package:recipe_next/model/recipe_model.dart';
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
  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as RecipeModel;

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
                          child: Image.network(
                            'https://i.pinimg.com/1200x/39/e8/9a/39e89ae11f7ef02eecfe9a205aab4e47.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 14,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Ingredients',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Check All',
                                style: TextStyle(
                                  color: Color(0xFFE85D3F),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          //ing list
                          Ingrediitemss(
                            name: "white fish fillets (cod or haddock)",
                            quantity: "2",
                          ),
                          SizedBox(height: 5),
                          Ingrediitemss(
                            name: "white fish fillets (cod or haddock)",
                            quantity: "2",
                          ),
                          SizedBox(height: 5),
                          Ingrediitemss(
                            name: "white fish fillets (cod or haddock)",
                            quantity: "2",
                          ),

                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Cooking Instructions',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              Spacer(),
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
                          Instructionitem(
                            number: "1",
                            title: "Prepare the Potatoes",
                            description:
                                "Peel the potatoes and cut them into thick strips."
                                "Rinse the potato strips in cold water and pat them dry."
                                "Heat oil in a deep pan and fry the potatoes until they are soft but not golden."
                                "Remove the potatoes and set them aside.",
                          ),

                          Instructionitem(
                            number: "1",
                            title: "Prepare the Potatoes",
                            description:
                                "Peel the potatoes and cut them into thick strips."
                                "Rinse the potato strips in cold water and pat them dry."
                                "Heat oil in a deep pan and fry the potatoes until they are soft but not golden."
                                "Remove the potatoes and set them aside.",
                          ),

                          Instructionitem(
                            number: "1",
                            title: "Prepare the Potatoes",
                            description:
                                "Peel the potatoes and cut them into thick strips."
                                "Rinse the potato strips in cold water and pat them dry."
                                "Heat oil in a deep pan and fry the potatoes until they are soft but not golden."
                                "Remove the potatoes and set them aside.",
                          ),

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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    onPressed: () {},
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

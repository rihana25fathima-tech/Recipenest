import 'package:flutter/material.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/service/recipe_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/catagories.dart';
import 'package:recipe_next/widget/custom_text_field.dart';
import 'package:recipe_next/widget/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedCatagory = 'All';

  final List<String> categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Evening Snack',
    'Dinner',
    'Sweet',
  ];
  final recipeService = RecipeService();
  List<RecipeModel> savedRecipes = [];
  void loadRecipes() {
    savedRecipes = recipeService.getRecipe();
    setState(() {});
  }
  void refreshRecipes() {
    setState(() {
      savedRecipes = recipeService.getRecipe();
    });
  }
  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  //sarch bar
  List<RecipeModel> get filterRecipes {
    List<RecipeModel> recipes = savedRecipes;
    if (selectedCatagory != "All") {
      recipes = recipes
          .where((recipe) => recipe.category == selectedCatagory)
          .toList();
    }

    // Search filter
    String searchText = searchController.text.trim().toLowerCase();
    if (searchText.isNotEmpty) {
      recipes = recipes.where((recipe) {
        return recipe.name.toLowerCase().contains(searchText) ||
            recipe.ingredients.toLowerCase().contains(searchText);
      }).toList();
    }

    return recipes;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 18,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //header
                    Row(
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset("assets/images/logo.png"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'RecipeNest',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Offline Kitchen Assistant',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textsec,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      prefixIcon: Icons.search,
                      hintText: 'Search recipe or ingredients...',
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 20),

                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1,
                      ),
                    ),
                    SizedBox(height: 14),
                    Catagories(
                      categories: categories,
                      selectedCatagory: selectedCatagory,
                      onCategorySelected: (value) {
                        setState(() {
                          selectedCatagory = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Saved Recipes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1,
                          ),
                        ),
                        Text(
                          '${filterRecipes.length} recipes',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textsec,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    //recipdummy
                    if (filterRecipes.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'No recipes found.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      for (var recipe in filterRecipes)
                        Recipecard(
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              AppRoutes.recipeDetailsScreen,
                              arguments: recipe,
                            );
                            if (!mounted) return;
                            if (result == true) {
                              loadRecipes();
                            }
                          },

                          recipeName: recipe.name,
                          category: recipe.category,
                          cookingTime: '${recipe.cookinTime} mins',
                          difficulty: recipe.difficulty,
                          imageUrl: recipe.image,
                          isFavourite: recipe.isFavorite,
                          onFavouriteTap: () async {
                            final index = savedRecipes.indexWhere(
                              (item) =>
                                  item.name == recipe.name &&
                                  item.category == recipe.category,
                            );

                            if (index == -1) return;
                            setState(() {
                              recipe.isFavorite = !recipe.isFavorite;
                            });
                            await recipeService.updateRecipe(index, recipe);

                          },
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //floating acction button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.addRecipeScreen);
          if (!mounted) return;
          loadRecipes();
        },
        backgroundColor: AppColors.primary,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Recipe',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

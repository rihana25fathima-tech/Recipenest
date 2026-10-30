import 'package:flutter/material.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/service/recipe_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_text_field.dart';
import 'package:recipe_next/widget/recipe_card.dart';

class FavoriteScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoriteScreen> createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  TextEditingController searchController = TextEditingController();
  final recipeService = RecipeService();

  List<RecipeModel> favoriteRecipes = [];

  void loadFavoriteRecipes() {
    final recipes = recipeService.getRecipe();

    favoriteRecipes = recipes.where((recipe) => recipe.isFavorite).toList();
  }

  void refreshFavorites() {
    setState(() {
      loadFavoriteRecipes();
    });
  }

  @override
  void initState() {
    super.initState();
    loadFavoriteRecipes();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favourite',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text1,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'All the recipes you love, nestled in one place.',
                style: TextStyle(fontSize: 13, color: AppColors.textsec),
              ),

              SizedBox(height: 15),
              CustomTextField(
                prefixIcon: Icons.search,
                hintText: 'Search recipe or ingredients...',
                controller: searchController,
              ),
              SizedBox(height: 25),
              if (favoriteRecipes.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'No favourite recipes yet.',
                      style: TextStyle(color: AppColors.textsec, fontSize: 14),
                    ),
                  ),
                )
              else
                for (var recipe in favoriteRecipes)
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Recipecard(
                      recipeName: recipe.name,
                      category: recipe.category,
                      cookingTime: '${recipe.cookinTime} mins',
                      difficulty: recipe.difficulty,
                      imageUrl: recipe.image,
                      isFavourite: recipe.isFavorite,
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          AppRoutes.recipeDetailsScreen,
                          arguments: recipe,
                        );

                        if (!mounted) return;

                        if (result == true) {
                          setState(() {
                            loadFavoriteRecipes();
                          });
                        }
                      },
                      onFavouriteTap: () async {
                        final allRecipes = recipeService.getRecipe();
                        final index = allRecipes.indexWhere(
                          (item) =>
                              item.name == recipe.name &&
                              item.category == recipe.category,
                        );

                        if (index == -1) return;

                        recipe.isFavorite = false;
                        await recipeService.updateRecipe(index, recipe);

                        if (!mounted) return;
                        setState(() {
                          favoriteRecipes.removeWhere(
                            (item) =>
                                item.name == recipe.name &&
                                item.category == recipe.category,
                          );
                        });
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

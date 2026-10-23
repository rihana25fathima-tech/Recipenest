import 'package:flutter/cupertino.dart';
import 'package:recipe_next/navigation/bottom_navigation.dart';
import 'package:recipe_next/views/auth/login_scren.dart';
import 'package:recipe_next/views/auth/sign_screen.dart';
import 'package:recipe_next/views/favorite/favorite_screen.dart';
import 'package:recipe_next/views/home/home_screen.dart';
import 'package:recipe_next/views/profile/edit_profile_screen.dart';
import 'package:recipe_next/views/profile/profile_screen.dart';
import 'package:recipe_next/views/recipe/add_cooking_instructions.dart';
import 'package:recipe_next/views/recipe/add_ingredient_screen.dart';
import 'package:recipe_next/views/recipe/add_recipe_screen.dart';
import 'package:recipe_next/views/recipe/recipe_details_screen.dart';
import 'package:recipe_next/views/splash/splash_screen.dart';

class AppRoutes {
  static String splash = '/';
  static String login = '/login';
  static String signup = '/signup';
  static String profile = '/profile';
  static String home = '/home';
  static String favorite = '/favorite';
  static String bottomNavigationBar = '/bottomNavigationBar';
  static String addRecipeScreen = '/addRecipeScreen';
  static String addIngredientScreen = '/addIngredientScreen';
  static String addInstructions = '/addInstructions';
  static String recipeDetailsScreen = '/recipeDetailsScreen';
  static String editProfileScreen = '/editProfileScreen';
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => Splashscreen(),
    login: (context) => LoginScren(),
    signup: (context) => SignScreen(),
    profile: (context) => ProfileScreen(),
    home: (context) => HomeScreen(),
    favorite: (context) => FavoriteScreen(),
    bottomNavigationBar: (context) => BottomNavigation(),
    addRecipeScreen: (context) => AddRecipeScreen(),
    addIngredientScreen: (context) => AddIngredientScreen(),
    addInstructions: (context) => AddInstructions(),
    recipeDetailsScreen: (context) => RecipeDetailsScreen(),
    editProfileScreen :(context) => EditProfileScreen(),
  };
}

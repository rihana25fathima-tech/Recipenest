import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
    
    );
  }
}
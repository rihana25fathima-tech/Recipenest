import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class Difficult extends StatelessWidget {
 final String difficulty;
 final String selectedDifficuilt;
final Function(String) onSelected;
  const new({
    super.key,
    required this.difficulty,
    required this.selectedDifficuilt,
    required this.onSelected,
    });



  @override
  Widget build(BuildContext context) {
      bool isSelected = selectedDifficuilt == difficulty;
    return Expanded(
      child: GestureDetector(
        onTap: () {
        onSelected(difficulty);
        },
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.text : AppColors.primary,
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
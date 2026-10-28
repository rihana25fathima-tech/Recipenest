import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class Catagories extends StatelessWidget {
  final List<String> categories;
  final String selectedCatagory;
  final ValueChanged<String> onCategorySelected;
  const new({
    super.key,
     required this.categories,
    required this.selectedCatagory,
    required this.onCategorySelected,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(width: 30);
        },
        itemCount: categories.length,
        itemBuilder: (context, index) {
                 final category = categories[index];
          final isSelected = selectedCatagory == category;
          return GestureDetector(
            onTap: () {
               onCategorySelected(category);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  categories[index],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.primary : AppColors.textsec,
                  ),
                ),
                SizedBox(height: 7),

                if (isSelected)
                  Container(
                    height: 3,
                    width: 35,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
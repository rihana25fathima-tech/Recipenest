import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class Ingrediitemss extends StatelessWidget {
  final String name;
  final String quantity;
  const new({super.key, required this.name, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 208, 208),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 247, 249),
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.text1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(width: 8),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3EF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              quantity,
              style: TextStyle(
                color: Color(0xFFE85D3F),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

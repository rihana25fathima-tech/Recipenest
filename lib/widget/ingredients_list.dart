 import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class IngredientsList extends StatelessWidget {
 final String number;
 final String name;
 final String quantity;
 final VoidCallback onDelete;
  const new({
    super.key,
    required this.number,
    required this.name,
    required this.quantity,
     required this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary),
      ),

      child: Row(
        children: [
          //number
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFFF2EE),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 12),
          // Name and Quantity
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  quantity,
                  style: TextStyle(fontSize: 11, color: AppColors.textsec),
                ),
              ],
            ),
          ),
          // Delete Button
          IconButton(
            onPressed: 
              onDelete,
            
            icon: Icon(
              Icons.delete_outline,
              size: 18,
              color: Color(0xFF98A8C0),
            ),
          ),
        ],
      ),
    );
  }
  }

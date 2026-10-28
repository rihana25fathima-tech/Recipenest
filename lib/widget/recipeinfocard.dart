import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class Recipeinfocard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const new({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 239, 218, 218),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Color.fromARGB(255, 16, 16, 16),
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

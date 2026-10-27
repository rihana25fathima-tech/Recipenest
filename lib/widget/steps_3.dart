import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class Steps3 extends StatelessWidget {
final  String title;
 final bool active;
  const new({
    super.key,
    required this.title,
    required this.active,
    });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : Color(0xFFE0E6F0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 7),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9,
              color: active ? AppColors.primary : Color(0xFF8A9AB8),
            ),
          ),
        ],
      ),
    );
  }
}
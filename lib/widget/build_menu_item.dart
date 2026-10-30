import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class BuildMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? trailing;

  const BuildMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Color(0xFFFFF2EF),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                icon,
                size: 18,
                color: AppColors.primary,
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            if (trailing != null)
              Text(
                trailing!,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textsec,
                ),
              ),

            SizedBox(width: 8),

            Icon(
              Icons.chevron_right,
              size: 18,
              color: Color(0xFFB0B0B0),
            ),
          ],
        ),
      ),
    );
  }
}
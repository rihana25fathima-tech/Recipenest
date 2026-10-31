import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class Recipecard extends StatelessWidget {
  final String recipeName;
  final String category;
  final String cookingTime;
  final String difficulty;
  final String imageUrl;
  final VoidCallback onFavouriteTap;
  final bool isFavourite;
  final VoidCallback onTap;
  const new({
    super.key,
    required this.recipeName,
    required this.category,
    required this.cookingTime,
    required this.difficulty,
    required this.imageUrl,
    required this.onFavouriteTap,
    required this.isFavourite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image and icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: imageUrl.isNotEmpty && File(imageUrl).existsSync()
                      ? Image.file(
                          File(imageUrl),
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 170,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.restaurant,
                            size: 45,
                            color: Colors.grey,
                          ),
                        ),
                ),

                //catagary label
                Positioned(
                  left: 12,
                  bottom: 7,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                // Favourite Icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    color: Colors.white,
                    shape: CircleBorder(),
                    child: InkWell(
                      onTap: onFavouriteTap,
                      customBorder: CircleBorder(),
                      child: SizedBox(
                        height: 42,
                        width: 42,
                        child: Icon(
                          isFavourite 
                          ? Icons.favorite 
                          : Icons.favorite_border,
                          color: isFavourite
                          ?Colors.red
                          :Colors.grey,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                // Recipe Details
                Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipeName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text1,
                        ),
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 5),

                          Expanded(
                            child: Text(
                              cookingTime,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textsec,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                
                        ],
                      ),
                      SizedBox(height: 10,),
                    
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

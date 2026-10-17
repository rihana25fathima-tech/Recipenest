import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 18,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                                                Text(
                              'Favourite',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text(
                              'Your Favourite recipes collection',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textsec,
                              ),
                            ),
                            SizedBox(height: 10,),
                               recipeCard(
                      recipeName: 'Chicken Biriyani',
                      category: 'Lunch',
                      cookingTime: '45 mins',
                      difficulty: 'Medium',
                      imageUrl: 'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/12/chicken-biryani-recipe.jpg',
                      onFavouriteTap: () {
                        setState(() {});
                      },
                      isFavourite: false,
                    ),
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
   Widget recipeCard({
    required String recipeName,
    required String category,
    required String cookingTime,
    required String difficulty,
    required String imageUrl,
    required VoidCallback onFavouriteTap,
    required bool isFavourite,
  }) {
    return Container(
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
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
              
                ),
              ),

              //catagary label
              Positioned(
                left: 12,
                bottom: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),

              // Favourite Icon
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: onFavouriteTap,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.white,
                    child: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Recipe Details
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipeName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Icon(Icons.access_time, size: 15, color: AppColors.primary),
                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        cookingTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textsec,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        difficulty,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            )
          )
        ]
      )
    );
  }
}
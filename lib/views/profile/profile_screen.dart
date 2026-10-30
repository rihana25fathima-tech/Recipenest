import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/model/user_model.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/build_menu_item.dart';
import 'package:recipe_next/widget/build_pofilecard.dart';
import 'package:recipe_next/widget/build_stat_card.dart';

class ProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userbox = Hive.box<UserModel>('open');
  String userName = '';
  String usereEmail = '';
  final recipeBox = Hive.box<RecipeModel>('recipes');

  int totalRecipes = 0;
  int favoriteRecipes = 0;
  void updateRecipeCount() {
    setState(() {
      totalRecipes = recipeBox.length;

      favoriteRecipes = recipeBox.values
          .where((recipe) => recipe.isFavorite)
          .length;
    });
  }

  void getUserdeatails() {
    String name = '';
    String email = '';
    for (UserModel user in userbox.values) {
      if (user.isLoggedIn) {
        name = user.name;
        email = user.email;
        break;
      }
    }
    setState(() {
      userName = name;
      usereEmail = email;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserdeatails();
    updateRecipeCount();
    recipeBox.listenable().addListener(updateRecipeCount);
  }

  @override
  void dispose() {
    recipeBox.listenable().removeListener(updateRecipeCount);
    super.dispose();
  }

  void logout() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Cancel', style: TextStyle(color: AppColors.textsec)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                for (int i = 0; i < userbox.length; i++) {
                  final user = userbox.getAt(i)!;

                  if (user.isLoggedIn) {
                    user.isLoggedIn = false;
                    await userbox.putAt(i, user);
                    break;
                  }
                }

                if (!mounted) return;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Heading
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Account',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text1,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Your personal cooking space',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textsec,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE8E2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.restaurant_menu_rounded,
                            color: Color(0xFFE43D20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Profile Card
                    BuildPofilecard(userEmail: usereEmail, userName: userName),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: BuildStatCard(
                            icon: Icons.menu_book,
                            count: totalRecipes.toString(),
                            title: 'Total Recipes',
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 11),
                        Expanded(
                          child: BuildStatCard(
                            icon: Icons.favorite,
                            count: favoriteRecipes.toString(),
                            title: 'Favourite Recipes',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          'My Cooking Space',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF252538),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                            color: Color(0xFFE43D20),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'PREFERENCES',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8290AA),
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    BuildMenuItem(
                      icon: Icons.favorite,

                      title: 'My Favourite Recipes',
                      trailing: '1 item',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.favorite);
                      },
                    ),
                    // About RecipeNest
                    BuildMenuItem(
                      icon: Icons.info,
                      title: 'About RecipeNest',
                      onTap: () {
                        _showAboutDialog(context);
                      },
                    ),
                    //my recipe
                    BuildMenuItem(
                      icon: Icons.restaurant_rounded,
                      title: "My Recipes",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bottomNavigationBar,
                        );
                      },
                    ),
                    // Logout
                    BuildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {
                        logout();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Statistics Card

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          title: Text(
            'About RecipeNest',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          content: Text(
            'RecipeNest helps you save, organise, '
            'and manage your favourite recipes '
            'in one place.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('OK', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }
}

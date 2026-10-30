import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/views/favorite/favorite_screen.dart';
import 'package:recipe_next/views/home/home_screen.dart';
import 'package:recipe_next/views/profile/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const new({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final favoriteKey = GlobalKey<FavoriteScreenState>();
  final homeKey = GlobalKey<HomeScreenState>();
  late final List<Widget> pages = [
    HomeScreen(key: homeKey),
    FavoriteScreen(key: favoriteKey),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          if (value == 0) {
            homeKey.currentState?.refreshRecipes();
          }
          if (value == 1) {
            favoriteKey.currentState?.refreshFavorites();
          }
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

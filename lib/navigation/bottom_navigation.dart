import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/views/home/home_screen.dart';
import 'package:recipe_next/views/profile/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const new({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int  currentIndex = 0;
 final List<Widget> pages =  [
    HomeScreen(),
    // FavouriteScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: IndexedStack(
      index: currentIndex,
      children: pages,
    ),
    bottomNavigationBar: 
    BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,

      items: [
        BottomNavigationBarItem(icon: Icon( Icons.home_outlined),
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
    )
       );
  }
}
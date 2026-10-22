import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                    _buildProfileCard(),

                    SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.menu_book,
                            count: '1',
                            title: 'Total Recipes',
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 11),
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.favorite,
                            count: '1',
                            title: 'Favourite Recipes',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        const Text(
                          'My Cooking Space',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF252538),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          height: 7,
                          width: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE43D20),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Spacer(),
                        const Text(
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

                    SizedBox(height: 12),

                    const SizedBox(height: 8),
                    _buildMenuItem(
                      icon: Icons.favorite,
                      title: 'My Favourite Recipes',
                      trailing: '1 item',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.favorite);
                      },
                    ),
                    // About RecipeNest
                    _buildMenuItem(
                      icon: Icons.info,
                      title: 'About RecipeNest',
                      onTap: () {
                        _showAboutDialog(context);
                      },
                    ),
                    //my recipe
                    _buildMenuItem(icon:Icons.restaurant_rounded , 
                    title: "My Recipes",
                     onTap: () {
                       Navigator.pushNamed(context, AppRoutes.bottomNavigationBar);
                     },),
                    // Logout
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      // isLogout: true,
                      onTap: () {
                        _showLogoutDialog(context);
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

  //profilcard
  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.text,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Color.fromARGB(255, 236, 178, 178)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Default Avatar
              Container(
                height: 66,
                width: 66,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: const Color.fromARGB(255, 243, 238, 238),
                  size: 25,
                ),
              ),
              SizedBox(width: 14),
              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'User name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Text(
                      'user email',
                      style: TextStyle(fontSize: 11, color: AppColors.text1),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editProfileScreen);
                },
                icon: Icon(
                  Icons.chevron_right,
                  color: Color.fromARGB(255, 36, 34, 34),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Statistics Card
  Widget _buildStatCard({
    required IconData icon,
    required String count,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 10),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary),
      ),

      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 216, 211),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 19, color: AppColors.primary),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              // Fixed Count
              Text(
                count,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 5),
              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.text1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Menu Item
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Color(0xFFFFF2EF),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),

            SizedBox(width: 12),
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),

            // Trailing Text
            if (trailing != null)
              Text(
                trailing,
                style: TextStyle(fontSize: 10, color: AppColors.textsec),
              ),
            SizedBox(width: 8),
            // Arrow
            Icon(Icons.chevron_right, size: 18, color: Color(0xFFB0B0B0)),
          ],
        ),
      ),
    );
  }

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

  void _showLogoutDialog(BuildContext context) {
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
            // Cancel
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: Text('Cancel', style: TextStyle(color: AppColors.textsec)),
            ),

            // Logout
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

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
}

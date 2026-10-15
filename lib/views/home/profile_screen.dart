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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'User Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text1,
                ),
              ),
              SizedBox(height: 8),

              Text(
                'Manage your session, preferences & storage',
                style: TextStyle(fontSize: 12, color: AppColors.textsec),
              ),
              SizedBox(height: 28),

              // Profile Card
              _buildProfileCard(),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.menu_book_outlined,
                      count: '1',
                      title: 'Total Recipes',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.favorite_border,
                      count: '1',
                      title: 'Favourite Recipes',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(color: AppColors.border),
              SizedBox(height: 8),
              _buildMenuItem(
                icon: Icons.favorite_border,
                title: 'My Favourite Recipes',
                trailing: '1 item',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
              // About RecipeNest
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About RecipeNest',
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
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
    );
  }

  //profilcard
  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.text,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          // Default Avatar
          Container(
            height: 46,
            width: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: const Color.fromARGB(255, 243, 238, 238),
              size: 25,
            ),
          ),
          SizedBox(height: 10),
          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1,
                  ),
                ),

                SizedBox(height: 5),
                Text(
                  'user email',
                  style: TextStyle(fontSize: 11, color: AppColors.textsec),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Color(0xFFB0B0B0)),
        ],
      ),
    );
  }

  // Statistics Card
  Widget _buildStatCard({
    required IconData icon,
    required String count,
    required String title,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 11),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Background
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Color(0xFFFFF2EF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 19, color: AppColors.primary),
          ),
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
            style: TextStyle(fontSize: 11, color: AppColors.textsec),
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

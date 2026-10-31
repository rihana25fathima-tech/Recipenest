import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';

class BuildPofilecard extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onProfileUpdated;
  const new({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {
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
                  color: Color.fromARGB(255, 243, 238, 238),
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
                            userName,
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
                      userEmail,
                      style: TextStyle(fontSize: 11, color: AppColors.text1),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    AppRoutes.editProfileScreen,
                  );

                  if (result == true) {
                    onProfileUpdated();
                  }
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
}

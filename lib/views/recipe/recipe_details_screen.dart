import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 220,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1559737558-2f5a35f4523b',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 14,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Creamy Garlic Butter Tuscan Shrimp',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Cooking Time and Difficulty
                          Row(
                            children: [
                              Expanded(
                                child: _buildtimeanddifficult(
                                  icon: Icons.access_time,
                                  title: "Cook Time",
                                  value: "25 mins",
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildtimeanddifficult(
                                  icon: Icons.local_fire_department,
                                  title: "Difficulty",
                                  value: "Medium",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          // Ingredients Heading
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Ingredients',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Check All',
                                style: TextStyle(
                                  color: Color(0xFFE85D3F),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          //ing list
                          _buildingredient("Large Raw Shrimp ", "150 kg"),
                          SizedBox(height: 5),
                          _buildingredient("Minced Garlic Cloves", "2"),
                          SizedBox(height: 5),
                          _buildingredient("Heavy Whipping Creamm", "3/4 cup"),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cooking Instructions',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              Spacer(),
                              Text(
                                'Step-by-Step',
                                style: TextStyle(
                                  color: Color(0xFFE85D3F),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          _buildinstraction(
                            "1",
                            "Sear Shrimp",
                            "Sear shrimp in melted butter with minced garlic  2 minutes on each side until pink and fragrant.Set aside on a plate.",
                          ),

                          _buildinstraction(
                            "2",
                            "Simmer Cream Sauce",
                            "Pour in heavy crea add sun-dried tomatoesand simmer gently over medium heat until thesauce thickens slightly.",
                          ),
                          _buildinstraction(
                            "#",
                            "Simmer Cream Sauce",
                            "Pour in heavy crea add sun-dried tomatoesand simmer gently over medium heat until thesauce thickens slightly.",
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: AppColors.background,
          child: Row(
            children: [
              // Delete Button
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outline, size: 18),
                    label: Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // Edit Button
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit_outlined, size: 18),
                    label: Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // Your CustomButton
              Expanded(
                child: CustomButton(
                  text: 'Submit',
                  onpressed: () {
                    Navigator.pushNamed(context, AppRoutes.bottomNavigationBar);
                  },
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildtimeanddifficult({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 239, 218, 218),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Color.fromARGB(255, 16, 16, 16),
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildingredient(String name, String quantity) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 208, 208),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 247, 249),
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.text1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(width: 8),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3EF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              quantity,
              style: TextStyle(
                color: Color(0xFFE85D3F),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildinstraction(String number, String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFFF1F1F1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFFF3EF),
              shape: BoxShape.circle,
            ),
            child: Text(
              'number',
              style: TextStyle(
                color: Color(0xFFE85D3F),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.6,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';

class AddInstructions extends StatefulWidget {
  const new({super.key});

  @override
  State<AddInstructions> createState() => _AddInstructionsState();
}

class _AddInstructionsState extends State<AddInstructions> {
  TextEditingController instructionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //back button
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF3DFD7),
                        border: Border.all(color: Color(0xFFF3DFD7)),
                      ),
                      child: Icon(Icons.arrow_back, size: 19),
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add New Recipe',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Step 3 of 3 .Cooking Instruction',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textsec,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22),
              Row(
                children: [
                  _buildStep('1 details', false),
                  SizedBox(width: 8),
                  _buildStep('2. Ingredients', false),
                  SizedBox(width: 8),
                  _buildStep('3. Steps', true),
                ],
              ),
              SizedBox(height: 22),
              Row(
                children: [
                  Icon(
                    Icons.integration_instructions,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      'ADDED INSTRUCTION',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              _buildInstruction("1", "Step 1"),
              SizedBox(height: 8),
              _buildInstruction("2", "Step2"),
              SizedBox(height: 10),
              SizedBox(
                height: 42,
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add, color: AppColors.primary, size: 18),

                  label: Text(
                    'Add Steps',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 236, 231),
                    side: BorderSide(color: Color(0xFFFFD1C7)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          color: AppColors.background,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Back',
                  onpressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 12),

              ///nextbutton
              Expanded(
                flex: 6,
                child: CustomButton(
                  icon: Icons.save,
                  text: 'Save',
                  onpressed: () {
                    Navigator.pushNamed(context, AppRoutes.bottomNavigationBar);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String title, bool active) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : Color(0xFFE0E6F0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 7),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9,
              color: active ? AppColors.primary : Color(0xFF8A9AB8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstruction(String number, String step) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFFE5EAF2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColors.primary,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  step,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Color(0xFF98A8C0),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          TextField(
            controller: instructionController,
            minLines: 2,
            maxLines: 5,
            style: TextStyle(fontSize: 11, color: AppColors.text1, height: 1.5),
            decoration: InputDecoration(
              hintText: 'Describe this cooking step...',
              hintStyle: TextStyle(fontSize: 11, color: AppColors.textsec),
              filled: true,
              fillColor: Color(0xFFF8FAFC),
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFE5EAF2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFE5EAF2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

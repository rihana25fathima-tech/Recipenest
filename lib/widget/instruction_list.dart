import 'package:flutter/material.dart';
import 'package:recipe_next/theme/app_colors.dart';

class InstructionList extends StatelessWidget {
  final String number;
  final String step;
  final TextEditingController controller;
  final VoidCallback onDelete;
  final ValueChanged<String> onChanged;
  const new({
    super.key,
    required this.number,
    required this.step,
    required this.controller,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                onPressed: onDelete,

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
            controller: controller,
            onChanged: onChanged,
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

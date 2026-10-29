import 'package:flutter/material.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/service/recipe_service.dart';
import 'package:recipe_next/theme/app_colors.dart';
import 'package:recipe_next/widget/custom_button.dart';
import 'package:recipe_next/widget/instruction_list.dart';
import 'package:recipe_next/widget/steps_3.dart';

class AddInstructions extends StatefulWidget {
  const new({super.key});

  @override
  State<AddInstructions> createState() => _AddInstructionsState();
}

class _AddInstructionsState extends State<AddInstructions> {
  List<TextEditingController> instructionController = [
    TextEditingController(),
    TextEditingController(),
  ];
  Map<String, dynamic> recipedetails = {};
  bool argumentsLoaded = false;
  bool isSaving = false;
  String instructinText = '';
  final recipeService = RecipeService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (argumentsLoaded) return;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      recipedetails = Map<String, dynamic>.from(args);
    }
    final recipe = recipedetails['editingRecipe'];
    if (recipe is RecipeModel && recipe.instruction.trim().isNotEmpty) {
      final steps = recipe.instruction
          .split('\n')
          .where((step) => step.trim().isNotEmpty)
          .map((step) {
            return step.replaceFirst(
              RegExp(r'^Step\s+\d+\s*:\s*', caseSensitive: false),
              '',
            );
          })
          .toList();
      for (final controller in instructionController) {
        controller.dispose();
      }
      instructionController = steps
          .map((step) => TextEditingController(text: step))
          .toList();
    }
    argumentsLoaded = true;
  }

  Future<void> saveRecipe() async {
    if (isSaving) return;
    if ((recipedetails['name'] ?? '').toString().trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Recipe name is missing")));
      return;
    }
    //list edthu
    final String ingredients = recipedetails['ingredients']?.toString() ?? '';
    if (ingredients.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add at least one ingredient')),
      );
      return;
    }

    final String instruction = instructionController
        .asMap()
        .entries
        .map((entry) {
          final text = entry.value.text.trim();
          if (text.isEmpty) {
            return '';
          }
          return 'Step ${entry.key + 1}: $text';
        })
        .where((step) => step.isNotEmpty)
        .join('\n');

    //instructin valisation
    if (instruction.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter cooking instructions')),
      );
      return;
    }
    final RecipeModel? oldRecipe =
        recipedetails['editingRecipe'] as RecipeModel?;

    final int? index = recipedetails['index'] as int?;
    final recipeModel = RecipeModel(
      name: recipedetails['name'] ?? '',
      category: recipedetails['category'] ?? '',
      ingredients: ingredients,
      instruction: instruction,
      cookinTime: recipedetails['cookingTime'] ?? '',
      difficulty: recipedetails['difficulty'] ?? '',
      image: recipedetails['image'] ?? '',
      isFavorite: oldRecipe?.isFavorite ?? false,
    );
    setState(() {
      isSaving = true;
    });
    try {
      if (oldRecipe != null) {
        // Existing recipe update cheyyunnu
        if (index == null || index < 0) {
          throw Exception('Recipe index not found');
        }
        await recipeService.updateRecipe(index, recipeModel);
      } else {
        //new recipe
        await recipeService.addRecipe(recipeModel);
      }
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            oldRecipe != null
                ? 'Recipe Update successfully!'
                : 'Recipe saved successfully!',
          ),
        ),
      );

      // Edit flow: previous screens-ilekku succes result pass cheyyuka
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save recipe: $error')));
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    for (final controller in instructionController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //back button
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(18, 12, 18, 0),
              child: Column(
                children: [
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
                    spacing: 8,
                    children: [
                      Steps3(title: '1 Details', active: false),
                      Steps3(title: '2 Ingredients', active: true),
                      Steps3(title: '3 Steps', active: false),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 26),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    ...instructionController.asMap().entries.map((e) {
                      final index = e.key;
                      return InstructionList(
                        number: '${index + 1} ',
                        step: 'Step ${index + 1}',
                        controller: e.value,
                        onChanged: (value) {
                          instructinText = instructionController
                              .asMap()
                              .entries
                              .map((en) {
                                final text = en.value.text.trim();
                                return text.isEmpty
                                    ? ''
                                    : 'Step ${en.key + 1}: $text';
                              })
                              .where((step) => step.isNotEmpty)
                              .join('\n');
                        },
                        onDelete: () {
                          setState(() {
                            instructionController[index].dispose();
                            instructionController.removeAt(index);
                          });
                        },
                      );
                    }),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 42,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            instructionController.add(TextEditingController());
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColors.primary,
                          size: 18,
                        ),
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
          ],
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
                  text: isSaving ? 'Saving...' : 'Save',
                  onpressed: () {
                    if (!isSaving) {
                      saveRecipe();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

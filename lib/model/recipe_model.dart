import 'package:hive_flutter/hive_flutter.dart';
part 'recipe_model.g.dart';

@HiveType(typeId: 1)
class RecipeModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String category;
  @HiveField(2)
  String difficulty;
  @HiveField(3)
  String ingredients;
  @HiveField(4)
  String instruction;
  @HiveField(5)
  String cookinTime;
  @HiveField(6)
  String image;
  @HiveField(7)
  bool isFavorite;

  RecipeModel({
    required this.name,
    required this.category,
    required this.ingredients,
    required this.instruction,
    required this.cookinTime,
    required this.difficulty,
    required this.image,
    this.isFavorite = false,
  });
}

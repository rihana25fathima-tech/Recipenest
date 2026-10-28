import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_next/model/recipe_model.dart';

class RecipeService {
 Box<RecipeModel> recipeBox = Hive.box<RecipeModel>('recipes');

  // Save recipe
 Future<void>addRecipe(RecipeModel recipe){
  return recipeBox.add(recipe);
 }
 //get
 List<RecipeModel>getRecipe(){
  return recipeBox.values.toList();
 }
 //delete
 Future<void>deleteRecipes(int index){
  return recipeBox.deleteAt(index);
 }
 //update
 Future<void>updateRecipe(RecipeModel recipe)async{
   final key = recipeBox.keys.firstWhere(
    (key) => recipeBox.get(key) == recipe,
  );
 return recipeBox.putAt(key, recipe);
 }
}
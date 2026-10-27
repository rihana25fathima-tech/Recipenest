import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_next/model/recipe_model.dart';
import 'package:recipe_next/model/user_model.dart';
import 'package:recipe_next/routes/app_routes.dart';
import 'package:recipe_next/theme/app_theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(RecipeModelAdapter());
  await Hive.openBox<UserModel>('open');    
  await Hive.openBox<RecipeModel>('recipes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: 'Flutter Demo',
       theme: AppTheme.lightTheme,
       initialRoute: AppRoutes.splash,
       routes: AppRoutes.routes,
       debugShowCheckedModeBanner: false,
    );
  }
}

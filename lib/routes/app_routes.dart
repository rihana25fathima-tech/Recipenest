import 'package:flutter/cupertino.dart';
import 'package:recipe_next/views/auth/login_scren.dart';
import 'package:recipe_next/views/auth/sign_screen.dart';
import 'package:recipe_next/views/home/home_screen.dart';
import 'package:recipe_next/views/profile/profile_screen.dart';
import 'package:recipe_next/views/splash/splashscreen.dart';

class AppRoutes {
    static String splash = '/';
    static String login = '/login';
   static String signup = '/signup';
  static String profile = '/profile';
  static String home = '/home';
    static Map<String,WidgetBuilder>routes = {
        splash:(context) =>  Splashscreen(),
        login:(context) => LoginScren(),
        signup:(context) => SignScreen(),
        profile:(context) => ProfileScreen(),
        home:(context) => HomeScreen(),
    };
}
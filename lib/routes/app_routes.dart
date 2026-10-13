import 'package:flutter/cupertino.dart';
import 'package:recipe_next/views/auth/login_scren.dart';
import 'package:recipe_next/views/splash/splashscreen.dart';

class AppRoutes {
    static String splash = '/';
    static String login = '/login';


    static Map<String,WidgetBuilder>routes = {
        splash:(context) =>  Splashscreen(),
        login:(context) => LoginScren(),
    };
}
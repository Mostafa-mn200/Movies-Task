import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/screen/buttomNavagation/buttom_navagation_page.dart';
import 'package:untitled/ui/screen/changeLanguage/change_language_screen.dart';
import 'package:untitled/ui/screen/search/search_screen.dart';
import 'package:untitled/ui/screen/splash/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case'/splash_screen':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case'/change_language_screen':
        return MaterialPageRoute(builder: (_) => ChangeLanguageScreen());
      case'/buttom_navagation_page':
        int index=settings.arguments as int;
        return MaterialPageRoute(builder: (_) => ButtomNavagationPage(index));
      case'/search_screen':
        return MaterialPageRoute(builder: (_) => SearchScreen());
    }
  }
}
import 'package:base_project/app/modules/home/screens/home_screen.dart';
import 'package:base_project/app/modules/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.login;

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.home: (context) => const HomeScreen(),
  };
}


import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/modules/cart/controller/cart_controller.dart';
import 'package:base_project/app/modules/login/controller/login_controller.dart';
import 'package:base_project/app/modules/login/screens/business_id_screen.dart';
import 'package:base_project/app/modules/menu/controller/menu_controller.dart';
import 'package:base_project/app/modules/sales/controller/sales_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => SalesViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const BusinessIdScreen(),
    );
  }
}
import 'dart:async';
import 'package:base_project/app/constants/app_assets.dart';
import 'package:base_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/modules/login/screens/business_id_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image(
              image: const AssetImage(AppImages.splash),
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
